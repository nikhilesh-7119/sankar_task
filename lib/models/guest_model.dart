
enum RsvpStatus { yes, no, maybe, pending }

class GuestModel {
  final String id;
  String fullName;
  String email;
  String phone;
  RsvpStatus status;

  GuestModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.status,
  });
}
