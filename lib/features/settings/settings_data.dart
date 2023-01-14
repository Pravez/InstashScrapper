import 'package:hive/hive.dart';

part 'settings_data.g.dart';

@HiveType(typeId: 0)
class SettingsData extends HiveObject {
  @HiveField(0)
  String serverAddress = "http://localhost:5000";

  @HiveField(1)
  String username = "";

  @HiveField(2)
  String password = "";
}
