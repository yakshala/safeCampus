enum AlertSeverity { critical, high, medium, low }
enum AlertType {
  weapon('Weapon Detected'),
  crowd('Overcrowding'),
  intrusion('Intrusion'),
  suspicious('Suspicious Activity'),
  fire('Fire/Smoke'),
  unauthorized('Unauthorized Access');
  
  const AlertType(this.label);
  final String label;
}
class AlertModel {
  final String id;
  final AlertType type;
  final AlertSeverity severity;
  final String title;
  final String location;
  final DateTime timestamp;
  final String? cameraId;
  final bool isResolved;
  
  const AlertModel({
    required this.id,
    required this.type,
    required this.severity,
    required this.title,
    required this.location,
    required this.timestamp,
    this.cameraId,
    this.isResolved = false,
  });
  
  String get timeAgo {
    final now = DateTime.now();
    final diff = now.difference(timestamp);
    
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}