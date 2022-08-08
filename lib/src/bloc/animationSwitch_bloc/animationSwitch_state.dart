import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class AnimationSwitchState {
  final bool isHome;
  final bool isFindMap;
  final bool isPerfil;
  AnimationSwitchState( {required this.isHome, required this.isFindMap,required this.isPerfil});

  // - Pagina de buscar tiendas
  factory AnimationSwitchState.isReport() {
    return AnimationSwitchState(isPerfil:false,isHome: true, isFindMap: false);
  }

  // -Pagina de buscar tiendas en el mapa
  factory AnimationSwitchState.isChat() {
    return AnimationSwitchState(isPerfil:false,isHome: false, isFindMap: true);
  }


  // -Pagina de buscar tiendas en el mapa
  factory AnimationSwitchState.isPerfil() {
    return AnimationSwitchState(isPerfil:true,isHome: false, isFindMap: false);
  }

  @override
  String toString() {
    return '''
      isHome: $isHome,
      isFindMap: $isFindMap,
    ''';
  }
}
