import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:location/location.dart';
import '../../repository/data_base_firestores.dart';
import '../../repository/data_base_incidents.dart';
import '../../util/authUser.dart';
import '../../util/incident.dart';
import 'bloc.dart';

import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

class reportIncidentBloc
    extends Bloc<reportIncidentEvent, homeReportIncidentState> {
  final DataBaseIncident _dataBaseIncident;
  final DataBaseIncidentFirestore _dataBaseIncidentFirestore;
  Incidentes? _incidente = Incidentes();
  AuthUser? _usuarioAntiguo;
  reportIncidentBloc(
      {required DataBaseIncident dataBaseIncident,
      required DataBaseIncidentFirestore dataBaseIncidentFirestore})
      : _dataBaseIncident = dataBaseIncident,
        _dataBaseIncidentFirestore = dataBaseIncidentFirestore,
        super(homeReportIncidentState.empty());

  homeReportIncidentState get initialState => homeReportIncidentState.empty();

  @override
  Stream<homeReportIncidentState> mapEventToState(
      reportIncidentEvent event) async* {
    if (event is reportIncidentUploadToDb) {

      var localizacion=false;

      if(_incidente!.locationData==null){
        localizacion=true;
      }
      if(localizacion){
        yield state.copyWith(isRequiredField: true);
      }else {
        yield* _uploadFile();
      }
    } else if (event is enterTipo) {
      _incidente!.seTipo = event.tipo;
      _incidente!.seIdUsuario=event.authUser.uid;
      yield state.Enter(incindente: _incidente);
    } else if (event is insertPhotoIncident) {
      yield state.Loading();
      yield* _selectFilePhoto(event.isGallery);
    } else if (event is SacarLocalizacionUsuario) {
      yield* _getLocation();
    } else if (event is inicialR) {
      _incidente = Incidentes();

      yield homeReportIncidentState.empty();
    } else if (event is chaDescripcionUsuario) {
      _incidente!.seDescripcion = event.descripcion;
    } else if (event is reportIncidentToDb) {

        try {
          _dataBaseIncident.insertIncident(_incidente!);
          yield homeReportIncidentState.Success();
          add(inicialR());
        } catch (_) {
          yield state.copyWith(
              incindente: _incidente, isFail: true, isSuccess: false);
        }


    } else if (event is insertVideoIncident) {
      yield state.Loading();
      yield* _selectFileVideo(event.isGallery);
    } else if (event is inicialWhatssapp) {
      yield* _openWhatsapp('983060182');
    } else if (event is iniciarTelefonos) {
      yield state.phones();
    }
  }

  Stream<homeReportIncidentState> _getLocation() async* {
    yield state.Loading();
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData _locationData = await location.getLocation();

    _incidente!.seLocalizacion =
        GeoPoint(_locationData.latitude!, _locationData.longitude!);
    yield state.copyWith(
        isLoading: false, isSuccess: true, incindente: _incidente);
  }

  Stream<homeReportIncidentState> _selectFilePhoto(bool isGallery) async* {
    if (isGallery) {
      try {
        List<XFile>? imageFileList = await ImagePicker().pickMultiImage();
        for (XFile documento in imageFileList!) {
          _incidente!.seFotos = documento.path;
        }
        yield homeReportIncidentState.UploadPhoto(_incidente!);
      } catch (_) {
        yield state.copyWith(isError: true);
      }
    } else {
      try {
        final image = await ImagePicker().pickImage(source: ImageSource.camera);

        _incidente!.seFotos = image!.path;
        print(image.path);
        yield homeReportIncidentState.UploadPhoto(_incidente!);
      } catch (_) {
        yield state.copyWith(isError: true);
      }
    }
  }

  Stream<homeReportIncidentState> _selectFileVideo(bool isGallery) async* {
    if (isGallery) {
      try {
        final video =
            await ImagePicker().pickVideo(source: ImageSource.gallery);
        _incidente!.seVideo = video!.path;
        yield homeReportIncidentState.UploadPhoto(_incidente!);
      } catch (_) {
        yield state.copyWith(isError: true);
      }
    } else {
      try {
        final video = await ImagePicker().pickVideo(source: ImageSource.camera);
        _incidente!.seVideo = video!.path;
        yield homeReportIncidentState.UploadPhoto(_incidente!);
      } catch (_) {
        yield state.copyWith(isError: true);
      }
    }
  }

  Stream<homeReportIncidentState> _openWhatsapp(String numero) async* {
    String url = 'whatsapp://send?phone=$numero&text=Hola';
    await canLaunch(url) ? launch(url) : print('Error');
  }

  Stream<homeReportIncidentState> _uploadFile() async* {
    yield state.Loading();
    final fotoss = _incidente!.fotos;
    _incidente!.setResetFotos();
    try {
      for (String path in fotoss!) {
        final file = File(path);
        final fileName = basename(file.path);
        final destination = 'filesPhoto/$fileName';
        UploadTask? task;

        task = _dataBaseIncidentFirestore.uploadFile(destination, file);

        final snapshot = await task!.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();
        _incidente!.seFotos = urlDownload;
      }

      if (_incidente!.video != null) {
        final file = File(_incidente!.video!);
        final fileName = basename(file.path);
        final destination = 'filesVideo/$fileName';
        UploadTask? task;

        task = _dataBaseIncidentFirestore.uploadFile(destination, file);

        final snapshot = await task!.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();
        _incidente!.seVideo = urlDownload;
      }
      add(reportIncidentToDb());
    } catch (_) {
      yield state.FailedDb();
    }
  }
}
