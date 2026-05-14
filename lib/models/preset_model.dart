class PresetModel {
  const PresetModel({
    required this.name,
    required this.venue,
    required this.catering,
    required this.photography,
    required this.decor,
    required this.other,
  });
  final String name;
  final double venue, catering, photography, decor, other;
}