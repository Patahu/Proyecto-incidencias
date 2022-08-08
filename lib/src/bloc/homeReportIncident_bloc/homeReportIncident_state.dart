import 'dart:io';

import '../../util/incident.dart';

class homeReportIncidentState {
  final bool isLoading;
  final bool isUploadPhoto;
  final bool isUploadLocation;
  final bool isNormal;
  final bool isFail;
  final bool isError;
  final bool isEnter;
  final Incidentes incindente;
  final bool isSuccess;
  final bool isPhones;


  homeReportIncidentState({
    required this.isLoading,
    required this.isUploadPhoto,
    required this.isUploadLocation,
    required this.isNormal,
    required this.isFail,
    required this.isError,
    required this.isEnter,
    required this.incindente,
    required this.isSuccess,
    required this.isPhones,
  });
  factory homeReportIncidentState.empty() {
    return homeReportIncidentState(
      isLoading: false,
      isUploadPhoto: false,
      isNormal: true,
      isFail: false,
      isEnter: false,
      incindente: Incidentes(),
      isSuccess: false,
      isUploadLocation: false,
      isPhones: false,
      isError:false,
    );
  }

  homeReportIncidentState copyWith({
    bool? isLoading,
    bool? isUploadPhoto,
    bool? isNormal,
    bool? isFail,
    bool? isEnter,
    Incidentes? incindente,
    bool? isSuccess,
    bool? isUploadLocation,
    bool? isPhones,
    bool? isError,
    bool? isRequiredField,
  }) {
    return homeReportIncidentState(
      isLoading: isLoading ?? this.isLoading,
      isUploadPhoto: isUploadPhoto ?? this.isUploadPhoto,
      isNormal: isNormal ?? this.isNormal,
      isFail: isFail ?? this.isFail,
      isEnter: isEnter ?? this.isEnter,
      incindente: incindente ?? this.incindente,
      isSuccess: isSuccess ?? this.isSuccess,
      isUploadLocation: isUploadLocation ?? this.isUploadLocation,
      isPhones: isPhones ?? this.isPhones,
      isError: isError ?? this.isError,
    );
  }

  homeReportIncidentState Loading() {
    return copyWith(
      isLoading: true,
      isUploadPhoto: false,
      isNormal: false,
      isFail: false,
      isEnter: true,
      isSuccess: false,
      isUploadLocation: false,
      isError:false,
      isRequiredField:false,
    );
  }

  factory homeReportIncidentState.UploadPhoto(Incidentes incindente) {
    return homeReportIncidentState(
      isUploadLocation: false,
      isLoading: false,
      isUploadPhoto: true,
      isNormal: false,
      isFail: false,
      isEnter: true,
      incindente: incindente,
      isSuccess: false,
      isPhones: false,
      isError:false,
    );
  }
  factory homeReportIncidentState.UploadLocation(Incidentes incindente) {
    return homeReportIncidentState(
      isUploadLocation: true,
      isLoading: false,
      isUploadPhoto: false,
      isNormal: false,
      isFail: false,
      isEnter: true,
      incindente: incindente,
      isSuccess: false,
      isPhones: false,
      isError:false,
    );
  }
  homeReportIncidentState FailedDb() {
    return copyWith(
      isUploadLocation: false,
      isLoading: false,
      isUploadPhoto: false,
      isNormal: false,
      isFail: true,
      isSuccess: false,
      isError:false,
      isRequiredField:false,
    );
  }

  homeReportIncidentState Enter({Incidentes? incindente}) {
    return homeReportIncidentState(
      isUploadLocation: false,
      isLoading: false,
      isUploadPhoto: false,
      isNormal: false,
      isFail: false,
      isEnter: true,
      incindente: incindente ?? Incidentes(),
      isSuccess: false,
      isPhones: false,
      isError:false,
    );
  }

  homeReportIncidentState phones() {
    return homeReportIncidentState(
      isUploadLocation: false,
      isLoading: false,
      isUploadPhoto: false,
      isNormal: false,
      isFail: false,
      isEnter: false,
      incindente: Incidentes(),
      isSuccess: false,
      isPhones: true,
      isError:false,
    );
  }

  factory homeReportIncidentState.Success() {
    return homeReportIncidentState(
      isUploadLocation: false,
      isLoading: false,
      isUploadPhoto: false,
      isNormal: false,
      isFail: false,
      isEnter: true,
      incindente: Incidentes(),
      isSuccess: true,
      isPhones: false,
      isError:false,
    );
  }

  @override
  String toString() {
    return '''
            isLoading ,$isLoading,
            isUploadPhoto: $isUploadPhoto,
            isNormal:$isNormal,
            isFail:$isFail,
            isEnter:$isEnter,
            foto:${incindente.fotos!.length},
            isSucces:$isSuccess,
            isPhones: $isPhones,
            isError: $isError,
      ''';
  }
}
