import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/modules/task/bloc/task_detail/task_detail.bloc.dart';

class TaskDetailEdit extends StatefulWidget {
  const TaskDetailEdit({super.key});

  @override
  State<TaskDetailEdit> createState() => _TaskDetailEditState();
}

class _TaskDetailEditState extends State<TaskDetailEdit> {
  final TextEditingController nameFieldController = TextEditingController();
  final TextEditingController descriptionFieldController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    nameFieldController.text = context.read<TaskDetailBloc>().state.task!.name;
    descriptionFieldController.text =
        context.read<TaskDetailBloc>().state.task!.description ?? "";
  }

  void _cancelTapped() {
    context.read<TaskDetailBloc>().add(HomeDetailTaskCancelEdit());
  }

  void _saveTapped() {
    context.read<TaskDetailBloc>().add(HomeDetailTaskSaveEdit(
        taskName: nameFieldController.text,
        taskDescription: descriptionFieldController.text));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 6,
              width: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.zero),
              onPressed: () => _cancelTapped(),
              child: const Text("Cancel"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.zero),
              onPressed: () => _saveTapped(),
              child: const Text("Save"),
            )
          ],
        ),
        const SizedBox(height: 28),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Icon(Icons.check_box_outline_blank_rounded)),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                autofocus: true,
                controller: nameFieldController,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                maxLines: null,
                minLines: 1,
                decoration: const InputDecoration.collapsed(
                  hintText: "Enter your task",
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.notes),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                controller: descriptionFieldController,
                maxLines: null,
                minLines: 1,
                decoration:
                    const InputDecoration.collapsed(hintText: "Description"),
              ),
            ),
          ],
        )
      ],
    );
  }
}