import '../../util/authUser.dart';

class perfilViewtState {
  final bool isUpdate;
  final bool isDNIRequired;
  final bool isTelefonoRequired;
  final bool isNombreRequired;
  final bool isRequiredReload;
  final bool isSuccess;
  final AuthUser usuarioAn;
  final bool isDNIenable;
  final bool isTelefonoEnable;
  final bool isNombreEnable;
  perfilViewtState({required this.isUpdate,required this.isDNIRequired,required this.isTelefonoRequired,required this.isRequiredReload,required this.isSuccess,required this.usuarioAn,required this.isDNIenable,required this.isTelefonoEnable,required this.isNombreEnable,required this.isNombreRequired});

  factory perfilViewtState.empty() {
    return perfilViewtState(
      isUpdate: false,
      isDNIRequired: false,
      isTelefonoRequired:false,
      isRequiredReload:false,
      isSuccess:false,
      usuarioAn:AuthUser('', '', '', '', ''),
      isDNIenable:false,
      isTelefonoEnable:false,
      isNombreEnable:false,
      isNombreRequired:false,
    );
  }
  perfilViewtState copyWith({
    bool? isUpdate,
    bool? isDNIRequired,
    bool? isTelefonoRequired,
    bool? isRequiredReload,
    bool? isSuccess,
    AuthUser? usuarioAn,
    bool? isDNIenable,
    bool? isTelefonoEnable,
    bool? isNombreEnable,
    bool? isNombreRequired,
  }) {
    return perfilViewtState(
      isUpdate: isUpdate ?? this.isUpdate,
      isDNIRequired: isDNIRequired ?? this.isDNIRequired,
      isTelefonoRequired: isTelefonoRequired ?? this.isTelefonoRequired,
      isRequiredReload: isRequiredReload ?? this.isRequiredReload,
      isSuccess: isSuccess ?? this.isSuccess,
      usuarioAn: usuarioAn ?? this.usuarioAn,
      isDNIenable: isDNIenable ?? this.isDNIenable,
      isTelefonoEnable: isTelefonoEnable ?? this.isTelefonoEnable,
      isNombreEnable: isNombreEnable ?? this.isNombreEnable,
      isNombreRequired: isNombreRequired ?? this.isNombreRequired,
    );
  }

  perfilViewtState update({bool? isUpdate, bool? isDNIRequired,bool? isTelefonoRequired,bool? isRequiredReload,bool? isSuccess,AuthUser? usuarioAn,bool? isDNIenable,bool? isTelefonoEnable,bool? isNombreEnable,bool? isNombreRequired}) {
    return copyWith(
      isUpdate:isUpdate,
      isDNIRequired:isDNIRequired,
      isTelefonoRequired:isTelefonoRequired,
      isRequiredReload:isRequiredReload,
      isSuccess:isSuccess,
      usuarioAn:usuarioAn,
      isDNIenable:isDNIenable,
      isTelefonoEnable:isTelefonoEnable,
      isNombreEnable:isNombreEnable,
      isNombreRequired:isNombreRequired,
    );
  }

  @override
  String toString() {
    return '''
            isUpdate ,$isUpdate,
            isDNIRequired: $isDNIRequired,
            isTelefonoRequired: $isTelefonoRequired,
            isRequiredReload:$isRequiredReload,
            isSucces:$isSuccess,
            usuarioAn:$usuarioAn,
            isDNIenable:$isDNIenable,
            isTelefonoEnable:$isTelefonoEnable,
            isNombreEnable:$isNombreEnable,
            isNombreRequired:$isNombreRequired,
''';

  }
}