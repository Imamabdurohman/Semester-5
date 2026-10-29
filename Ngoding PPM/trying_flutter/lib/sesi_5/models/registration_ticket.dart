class RegistrationTicket {
  final String id;
  final String eventId;
  final String eventTitle;
  final String participantName;
  final String nim;
  final String email;
  final String whatsapp;
  final String participantType;
  final String attendanceDate;
  final String seminarKit;
  final double donation;
  final bool agreedTerms;
  final DateTime registeredAt;

  RegistrationTicket({
    required this.id,
    required this.eventId,
    required this.eventTitle,
    required this.participantName,
    required this.nim,
    required this.email,
    required this.whatsapp,
    required this.participantType,
    required this.attendanceDate,
    required this.seminarKit,
    required this.donation,
    required this.agreedTerms,
    required this.registeredAt,
  });
}