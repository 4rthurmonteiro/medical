class Event {

  final String action;
  final String type;

  Event(this.action, this.type);

  @override
  String toString() {
    return 'Event{action: $action, type: $type}';
  }
}