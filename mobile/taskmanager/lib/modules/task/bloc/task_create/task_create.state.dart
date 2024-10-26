part of 'task_create.bloc.dart';

enum NewHomeStatus { initial, loading, success, failure }

class TaskCreateStatus extends Equatable {
  final NewHomeStatus status;
  final DateTime date;
  final TimeOfDay time;
  final String dateLabel;
  final String timeLabel;
  final String? missionName;
  final String? description;

  @override
  List<Object?> get props =>
      [status, date, dateLabel, timeLabel, missionName, description];

  const TaskCreateStatus({
    required this.status,
    required this.date,
    required this.time,
    required this.dateLabel,
    required this.timeLabel,
    this.missionName,
    this.description,
  });

  TaskCreateStatus.initial()
      : this(
            status: NewHomeStatus.initial,
            date: DateTime.now(),
            time: TimeOfDay.now(),
            dateLabel: "Today",
            timeLabel: TimeOfDay.now().toLabel());

  TaskCreateStatus copyWith(
      {NewHomeStatus? status,
      DateTime? date,
      TimeOfDay? time,
      String? dateLabel,
      String? timeLabel,
      String? missionName,
      String? description}) {
    return TaskCreateStatus(
        status: status ?? this.status,
        date: date ?? this.date,
        time: time ?? this.time,
        dateLabel: dateLabel ?? this.dateLabel,
        timeLabel: timeLabel ?? this.timeLabel,
        missionName: missionName ?? this.missionName,
        description: description ?? this.description);
  }

  TaskDTO toDTO() {
    if (missionName == null) {
      throw ArgumentError('missionName cannot be null');
    }

    return TaskDTO(
      name: missionName!,
      description: description,
      createTime: DateTime.now(),
      deadTime: date.at(time),
      status: false,
    );
  }
}