import 'package:flutter/material.dart';
import '../models/event_item.dart';

class VenueMapViewer extends StatelessWidget {
  final List<EventItem> events;

  const VenueMapViewer({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🗺️ Denah Venue Interaktif',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            height: 240,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.indigo.shade200),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: InteractiveViewer(
                boundaryMargin: const EdgeInsets.all(20),
                minScale: 0.8,
                maxScale: 3.5,
                child: Container(
                  color: Colors.indigo.shade50,
                  alignment: Alignment.center,
                  child: const Text(
                    '📍 PETA DENAH VENUE (Zoom & Drag)',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.indigo),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '🖼️ Galeri Poster Seminar',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: events.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final ev = events[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: Image.network(ev.posterUrl, fit: BoxFit.cover),
              );
            },
          ),
        ],
      ),
    );
  }
}