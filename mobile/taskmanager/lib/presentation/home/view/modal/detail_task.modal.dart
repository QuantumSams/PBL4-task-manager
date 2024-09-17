import 'package:flutter/material.dart';
import 'package:taskmanager/common/datetime_extension.dart';
import 'package:taskmanager/common/timeofday_extension.dart';

import 'package:taskmanager/presentation/home/bloc/detail/detail_home.bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class DetailTaskModal extends StatefulWidget {
  const DetailTaskModal({super.key});

  @override
  State<DetailTaskModal> createState() => _DetailTaskModalState();
}

class _DetailTaskModalState extends State<DetailTaskModal> {
  @override
  void initState() {
    super.initState();
  }

  void _showDateHandle(DetailHomeState state) async {
    final DateTime? selectedDate = await showDatePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2032));

    if (!mounted) return;
    context.read<DetailHomeBloc>().add(DetailHomeEditTask(date: selectedDate));
  }

  void _showTimeHandle(DetailHomeState state) async {
    final TimeOfDay? selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (!mounted) return;
    context.read<DetailHomeBloc>().add(DetailHomeEditTask(time: selectedTime));
  }

  void _checkBoxHandle(DetailHomeState state, bool? newStatus) async {
    context.read<DetailHomeBloc>().add(DetailHomeEditTask(status: newStatus));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailHomeBloc, DetailHomeState>(
      builder: (context, state) {
        if (state.status == DetailHomeStatus.loaded) {
          return DraggableScrollableSheet(
            shouldCloseOnMinExtent: true,
            expand: false,
            maxChildSize: 0.95,
            minChildSize: 0.6,
            initialChildSize: 0.601,
            snap: true,
            snapSizes: const [0.601, 0.95],
            builder: (context, scrollController) => ListView(
              controller: scrollController,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(state.task!.createTime.relativeToToday()),
                    Wrap(
                      children: [
                        IconButton.filled(
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.all(4),
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            color: Colors.deepPurple[100],
                          ),
                        ),
                        IconButton.filled(
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.all(4),
                          onPressed: () {
                            if (context.mounted) {
                              Navigator.pop(context);
                              context
                                  .read<DetailHomeBloc>()
                                  .add(DetailHomeClose());
                            }
                          },
                          icon: Icon(
                            Icons.clear,
                            color: Colors.deepPurple[100],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                        visualDensity:
                            const VisualDensity(horizontal: -4, vertical: -4),
                        value: state.task!.status,
                        onChanged: (bool? value) =>
                            _checkBoxHandle(state, value)),
                    InkWell(
                      onTap: () {
                        print("Tapped");
                      },
                      child: Text(state.task!.name,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ListTile(
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  dense: true,
                  onTap: () => _showDateHandle(state),
                  horizontalTitleGap: 8,
                  minVerticalPadding: 0,
                  contentPadding: const EdgeInsets.all(0),
                  leading: const Icon(Icons.calendar_month_sharp, size: 24),
                  title: Text(
                    state.task!.deadTime.relativeToToday(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 4),
                const Divider(),
                const SizedBox(height: 4),
                ListTile(
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  dense: true,
                  onTap: () => _showTimeHandle(state),
                  horizontalTitleGap: 8,
                  minVerticalPadding: 0,
                  contentPadding: const EdgeInsets.all(0),
                  leading: const Icon(Icons.access_time_filled, size: 24),
                  title: Text(
                    TimeOfDay.fromDateTime(state.task!.deadTime).toLabel(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 4),
                const Divider(),
                const SizedBox(height: 8),
                const Text(
                  "Description",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  maxLines: null,
                  minLines: 6,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                  ),
                  initialValue: state.task!.description,
                  readOnly: true,
                )
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
