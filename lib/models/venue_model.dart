class VenueModel {
  final String id;
  final String name;
  final String location; // city/region/state
  final double rating;   // 0.0 - 5.0
  final int capacity;    // max guests
  final int budgetMinLakh; // e.g. 8 means ₹8L
  final int budgetMaxLakh; // e.g. 12 means ₹12L
  final String imageAsset; // assets/images/venu1.jpg

  VenueModel({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.capacity,
    required this.budgetMinLakh,
    required this.budgetMaxLakh,
    required this.imageAsset,
  });
}
