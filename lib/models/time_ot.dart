class TimeOt {
  final int id;
  final String cause_title;
  final String user_created_name;
  final String user_assign_name;
  final dynamic user_created_avatar;
  final dynamic user_assign_avatar;
  final String title;
  final String day;
  final String created_at;
  final String updated_at;
  final dynamic time_start;
  final dynamic time_end;
  final bool status;
  final dynamic task;
  final int cause;
  final int user_created;
  final int user_assign;

  TimeOt({
    required this.id,
    required this.cause_title,
    required this.user_created_name,
    required this.user_assign_name,
    required this.user_created_avatar,
    required this.user_assign_avatar,
    required this.title,
    required this.day,
    required this.created_at,
    required this.updated_at,
    required this.time_start,
    required this.time_end,
    required this.status,
    required this.task,
    required this.cause,
    required this.user_created,
    required this.user_assign,
  });
}