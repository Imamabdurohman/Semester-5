class EventItem {
  final String id;
  final String title;
  final String speaker;
  final String category; // AI, Mobile, IoT, Cybersecurity
  final String date;
  final String time;
  final String location;
  final double price;
  final String posterUrl;
  final int quota;
  final String description;

  EventItem({
    required this.id,
    required this.title,
    required this.speaker,
    required this.category,
    required this.date,
    required this.time,
    required this.location,
    required this.price,
    required this.posterUrl,
    required this.quota,
    required this.description,
  });
}