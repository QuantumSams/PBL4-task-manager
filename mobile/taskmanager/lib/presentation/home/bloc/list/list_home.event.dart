part of "list_home.bloc.dart";

abstract class ListHomeEvent extends Equatable {
  const ListHomeEvent();
  @override
  List<Object?> get props => [];
}

class FetchTaskList extends ListHomeEvent {}

class RemoveOneTask extends ListHomeEvent {
  final int taskToRemoveIndex;

  const RemoveOneTask({required this.taskToRemoveIndex});
  @override
  List<Object?> get props => [taskToRemoveIndex];
}

class ListHomeCheckTask extends ListHomeEvent {
  final bool taskStatus;
  final int taskId;

  const ListHomeCheckTask({required this.taskId, required this.taskStatus});


  @override
  List<Object?> get props => [taskId];
}
