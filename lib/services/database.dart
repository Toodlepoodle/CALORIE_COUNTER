import '../models/day_log.dart';
import '../models/user.dart';
class Database {
  static List<User> users = [];

  static void addDayLog(String userName, DayLog dayLog) {
    final user = users.firstWhere(
      (user) => user.name == userName,
      orElse: () => User(name: userName, dayLogs: []),
    );
    user.dayLogs.add(dayLog);
    if (!users.contains(user)) {
      users.add(user);
    }
  }

  static List<DayLog> getDayLogs(String userName) {
    final user = users.firstWhere(
      (user) => user.name == userName,
      orElse: () => User(name: userName, dayLogs: []),
    );
    return user.dayLogs;
  }
}