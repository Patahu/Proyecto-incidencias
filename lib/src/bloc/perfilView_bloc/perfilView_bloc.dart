
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../repository/user_repository.dart';
import '../../util/authUser.dart';
import 'bloc.dart';

class perfilViewBloc
    extends Bloc<perfilViewEvent, perfilViewtState> {
  final UserRepository _userRepository;
  AuthUser? _usuarioAntiguo=AuthUser('', '', '', '', '');
  AuthUser? _usuarioActualizar=AuthUser('', '', '', '', '');
  perfilViewBloc(
      {required UserRepository userRepository
        })
      : _userRepository = userRepository,

        super(perfilViewtState.empty());

  perfilViewtState get initialState => perfilViewtState.empty();

  @override
  Stream<perfilViewtState> mapEventToState(
      perfilViewEvent event) async* {
    if(event is iniciarUsuarioVerificar){
      var isRequiredDni=false;
      var isRequiredTelefono=false;

      _usuarioAntiguo!.seTelefono=event.authUser.numero;
      _usuarioAntiguo!.seDNIUsuario=event.authUser.dni;
      _usuarioAntiguo!.seCorreo=event.authUser.correo;
      _usuarioAntiguo!.seNombre=event.authUser.nombre;
      _usuarioAntiguo!.seUID=event.authUser.uid;
      if(event.authUser.dni==''){
        isRequiredDni=true;
      }
      if(event.authUser.numero==''){
        isRequiredTelefono=true;
      }
      yield state.copyWith(isTelefonoRequired:isRequiredTelefono,isDNIRequired:isRequiredDni,usuarioAn: _usuarioAntiguo,isDNIenable:false,isTelefonoEnable:false,isNombreEnable:false);

    }else if(event is chaTelefonoUsuarioEnable){
      _usuarioActualizar!.seTelefono=_usuarioAntiguo!.numero;
      yield state.update(isTelefonoEnable:true);
    }
    else if(event is chaTelefonoUsuarioCancel){
      _usuarioAntiguo!.seTelefono=_usuarioActualizar!.numero;
      yield state.update(isTelefonoEnable:false);
    }
    else if(event is chaDNIUsuarioEnable){
      _usuarioActualizar!.seDNIUsuario=_usuarioAntiguo!.dni;
      yield state.update(isDNIenable:true);
    }else if(event is chaDNIUsuarioCancel){
      _usuarioAntiguo!.seDNIUsuario=_usuarioActualizar!.dni;
      yield state.update(isDNIenable:false);
    }  else if(event is chaNombreUsuarioEnable){
      _usuarioActualizar!.seNombre=_usuarioAntiguo!.nombre;
      yield state.update(isNombreEnable:true);
    }else if(event is chaNombreUsuarioCancel){
      _usuarioAntiguo!.seNombre=_usuarioActualizar!.nombre;
      yield state.update(isNombreEnable:false);
    }

    else if(event is chaDNIUsuario){
      if(event.dni==''){
        _usuarioAntiguo!.seDNIUsuario='';
        yield state.update(isDNIRequired:true);

      }else {
        _usuarioAntiguo!.seDNIUsuario=event.dni;
        yield state.update(isDNIRequired: false,usuarioAn: _usuarioAntiguo);
      }
    } else if(event is chaNombreUsuario){
      if(event.nombre==''){
        _usuarioAntiguo!.seNombre='';
        yield state.update(isNombreRequired:true);

      }else {
        _usuarioAntiguo!.seNombre=event.nombre;
        yield state.update(isNombreRequired: false,usuarioAn: _usuarioAntiguo);
      }
    }

    else if(event is chaTelefonocionUsuario){
      if(event.telefono==''){
        yield state.update(isTelefonoRequired:true);
      }else {
        _usuarioAntiguo!.seTelefono=event.telefono;
        yield state.update(isTelefonoRequired: false,usuarioAn: _usuarioAntiguo);
      }
    }else if(event is chaDatasUsuarioDB){
        final usuarioActual=await _userRepository.getUsuario();
        Map<String, Object?> ejecucion={};
        if(usuarioActual!.numero!=_usuarioAntiguo!.numero){
          ejecucion['numero']=_usuarioAntiguo!.numero;
        }
        if(usuarioActual.dni!=_usuarioAntiguo!.dni){
          ejecucion['DNI']=_usuarioAntiguo!.dni;

        }
        if(usuarioActual.nombre!=_usuarioAntiguo!.nombre){
          ejecucion['nombre']=_usuarioAntiguo!.nombre;

        }
        if(ejecucion.isNotEmpty){

          try {
            _userRepository.actualizarUsuario(
                idUsuario: usuarioActual.uid, ejecucion: ejecucion);
            yield state.update(isRequiredReload: true);
          }catch(_){
            print('Error al ingresar a la base de datos');
          }
        }


    }
  }
}
