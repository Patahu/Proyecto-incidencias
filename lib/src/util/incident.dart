import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
//DocumentSnapshot


class Incidentes extends Equatable {
  String? _tipo;
  String? _descripcion;
  List<String>? _fotos;
  String? _idUsuario;
  String? _video;
  String? _estado;
  GeoPoint? _locationData;
  Timestamp? _fecha;
  String? _idIncidente;
  Incidentes(
      {String? tipo,
        String? descripcion,
        List<String>? fotos,
        String? idUsuario,
        String? video,
        String? estado,


        String? idIncidente,

        GeoPoint? localizacion,
        Timestamp? fecha}) {
    _tipo = tipo;
    _descripcion = descripcion;
    _fotos = fotos ?? [];
    _idUsuario = idUsuario;
    _video = video;

    _estado = estado;

    _idIncidente = idIncidente;
    _locationData = localizacion;
    _fecha = fecha;
  }

  static Incidentes fromDB(DocumentSnapshot documentSnapshot) {
    return Incidentes(
      tipo: documentSnapshot['tipo'],
      descripcion: documentSnapshot['descripcion'],
      fotos: documentSnapshot['idFotos'].cast<String>(),
      video: documentSnapshot['video'],
      estado: documentSnapshot['estado'],
      idUsuario: documentSnapshot['idUsuario'],
      localizacion: documentSnapshot['localizacion'],
      fecha: documentSnapshot['fecha'],
      idIncidente: documentSnapshot['idIncidencia'],

    );
  }


  String? get tipo => _tipo;
  String? get descripcion => _descripcion;
  String? get idIncidente => _idIncidente;
  List<String>? get fotos => _fotos;
  String? get idUsuario => _idUsuario;
  String? get estado => _estado;
  String? get video => _video;
  Timestamp? get fecha => _fecha;
  GeoPoint? get locationData => _locationData;
  void set seTipo(String tipo) {
    _tipo = tipo;
  }

  void set seDescripcion(String descripcion) {
    _descripcion = descripcion;
  }

  void set seLocalizacion(GeoPoint localizacion) {
    _locationData = localizacion;
  }

  void set seFotos(String path) {
    _fotos!.add(path);
  }

  void setResetFotos() {
    _fotos = [];
  }

  void set seVideo(String path) {
    _video = path;
  }

  void set seIdUsuario(String idUsuario) {
    _idUsuario = idUsuario;
  }


  void set seEstado(String estado) {
    _estado = estado;
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [tipo, descripcion, fotos, idUsuario, estado, locationData];
}
