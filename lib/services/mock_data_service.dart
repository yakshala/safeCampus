import '../models/camera_model.dart';
import '../features/alerts/models/alert_model.dart';
/// Mock data service for UI demonstration
/// Replace with actual API integration in production
class MockDataService {
  static List<CameraModel> getCameras() {
    return const [
      CameraModel(
        id: '1',
        name: 'Main Entrance',
        location: 'Building A - Ground Floor',
        isOnline: true,
        hasActiveAlert: true,
      ),
      CameraModel(
        id: '2',
        name: 'Parking Lot A',
        location: 'North Campus',
        isOnline: true,
      ),
      CameraModel(
        id: '3',
        name: 'Library Hall',
        location: 'Building C - 2nd Floor',
        isOnline: true,
      ),
      CameraModel(
        id: '4',
        name: 'Cafeteria',
        location: 'Building B - Ground Floor',
        isOnline: false,
      ),
      CameraModel(
        id: '5',
        name: 'Sports Complex',
        location: 'South Campus',
        isOnline: true,
      ),
      CameraModel(
        id: '6',
        name: 'Admin Block',
        location: 'Building A - 3rd Floor',
        isOnline: true,
        hasActiveAlert: true,
      ),
    ];
  }
  static List<AlertModel> getAlerts() {
    final now = DateTime.now();
    return [
      AlertModel(
        id: '1',
        type: AlertType.weapon,
        severity: AlertSeverity.critical,
        title: 'Potential weapon detected',
        location: 'Main Entrance - Camera 1',
        timestamp: now.subtract(const Duration(minutes: 2)),
        cameraId: '1',
      ),
      AlertModel(
        id: '2',
        type: AlertType.crowd,
        severity: AlertSeverity.high,
        title: 'Overcrowding detected',
        location: 'Cafeteria - Camera 4',
        timestamp: now.subtract(const Duration(minutes: 15)),
        cameraId: '4',
      ),
      AlertModel(
        id: '3',
        type: AlertType.unauthorized,
        severity: AlertSeverity.high,
        title: 'Unauthorized access attempt',
        location: 'Server Room - Building C',
        timestamp: now.subtract(const Duration(minutes: 32)),
        cameraId: '3',
      ),
      AlertModel(
        id: '4',
        type: AlertType.suspicious,
        severity: AlertSeverity.medium,
        title: 'Unusual movement pattern',
        location: 'Parking Lot A',
        timestamp: now.subtract(const Duration(hours: 1)),
        cameraId: '2',
      ),
      AlertModel(
        id: '5',
        type: AlertType.intrusion,
        severity: AlertSeverity.medium,
        title: 'Perimeter breach detected',
        location: 'East Gate',
        timestamp: now.subtract(const Duration(hours: 2)),
      ),
      AlertModel(
        id: '6',
        type: AlertType.fire,
        severity: AlertSeverity.low,
        title: 'Smoke detected (false alarm)',
        location: 'Kitchen Area',
        timestamp: now.subtract(const Duration(hours: 3)),
        isResolved: true,
      ),
    ];
  }
  
  static Map<String, dynamic> getDashboardStats() {
    return {
      'activeAlerts': 4,
      'alertsTrend': -12.5,
      'camerasOnline': 18,
      'totalCameras': 20,
      'camerasTrend': 5.0,
      'incidentsToday': 7,
      'incidentsTrend': -8.3,
      'systemHealth': 98,
      'healthTrend': 2.1,
    };
  }
}