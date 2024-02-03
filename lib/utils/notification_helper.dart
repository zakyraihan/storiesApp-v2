import 'package:rxdart/subjects.dart';
import 'package:story_app_api/utils/received_notification.dart';

final selecNotificationSubject = BehaviorSubject<String?>();
final didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

class NotificationHelper {
  static const _channedId = '01';
  static const _channelName = 'channel_01';
  static const _channelDesc = 'dicoding channel';
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  // Kita akan membuat beberapa fungsi jenis notifikasi di dalam kelas ini
}
