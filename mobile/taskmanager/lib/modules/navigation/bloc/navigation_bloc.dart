import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager/main.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState()) {
    on<NavigationItemTapped>(_onItemTapped);
  }

  void _onItemTapped(
      NavigationItemTapped event, Emitter<NavigationState> emit) {
    if (state.index == event.newIndex) {
      return;
    }

    emit(state.copyWith(index: event.newIndex));
  }
}
