







import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';


class AnimationSwitchBloc extends Bloc<AnimationSwitchEvent,AnimationSwitchState>{
  AnimationSwitchBloc(): super(AnimationSwitchState.isReport());
  @override
  AnimationSwitchState get  initialState => AnimationSwitchState.isReport();

  @override
  Stream<AnimationSwitchState> mapEventToState(AnimationSwitchEvent event) async*{
    if(event is reportarPage){
      yield AnimationSwitchState.isReport();
    }
    if(event is BuscarChat){
      yield AnimationSwitchState.isChat();
    }if(event is BuscarPerfil){

      yield AnimationSwitchState.isPerfil();
    }
  }
}