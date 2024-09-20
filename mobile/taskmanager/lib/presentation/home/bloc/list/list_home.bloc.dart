import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:taskmanager/common/api_constant.dart';
import 'package:taskmanager/data/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dio/dio.dart';

part 'list_home.state.dart';
part 'list_home.event.dart';

class ListHomeBloc extends Bloc<ListHomeEvent, ListHomeState> {
  ListHomeBloc() : super(const ListHomeState()) {
    on<FetchTaskList>(_fetchList);
    on<RemoveOneTask>(_removeTask);
    on<ListHomeCheckTask>(_editTask);
  }

  void _fetchList(FetchTaskList event, Emitter<ListHomeState> emit) async {
    final dio = Dio(
      BaseOptions(
        responseType: ResponseType.plain,
      ),
    );
    emit(state.copyWith(status: HomeStatus.loading));

    List<TaskModel> taskList = [];

    try {
      final res = await dio.get("${ApiConstant.api_const}");
      final data = jsonDecode(res.data);

      taskList = (data["data"]).map<TaskModel>((task) {
        return TaskModel.fromJson(task);
      }).toList();
    } catch (e) {
      print('Error occurred while fetching task list: $e');
    }

    emit(state.copyWith(status: HomeStatus.success, taskList: taskList));
  }

  void _removeTask(RemoveOneTask event, Emitter<ListHomeState> emit) async {
    final dio = Dio();
    try {
      await dio.delete("${ApiConstant.api_const}${event.taskToRemoveIndex}");
    } catch (e) {
      print(e);
    }
    add(FetchTaskList());
  }

  void _editTask(ListHomeCheckTask event, Emitter<ListHomeState> emit) async {
    final dio = Dio();

    final TaskModel task = state.taskList.firstWhere((task) {
      return task.id == event.taskId;
    });

    final data = task.toResponse(status: event.taskStatus);

    print(data);
    print(data.toJson());

    try {
      await dio.put("${ApiConstant.api_const}${event.taskId}",
          data: data.toJson());
    } catch (e) {
      print(e);
    }
    // add(FetchTaskList());
  }
}
