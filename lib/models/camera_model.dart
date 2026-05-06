class CameraModel {
  final String id;
  final String name;
  final String location;
  final bool isOnline;
  final bool hasActiveAlert;
  final String? streamUrl;
  
  const CameraModel({
    required this.id,
    required this.name,
    required this.location,
    required this.isOnline,
    this.hasActiveAlert = false,
    this.streamUrl,
  });
}