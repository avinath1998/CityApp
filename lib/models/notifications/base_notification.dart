abstract class BaseNotification {
  final String title;
  final String body;
  final NotificationType type;
  BaseNotification({
    this.title,
    this.body,
    this.type,
  });

  @override
  String toString() =>
      'BaseNotification(title: $title, body: $body, type: $type)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BaseNotification &&
        o.title == title &&
        o.body == body &&
        o.type == type;
  }

  @override
  int get hashCode => title.hashCode ^ body.hashCode ^ type.hashCode;
}

enum NotificationType { prize, disposal, addBin, general }
