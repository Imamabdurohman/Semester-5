import 'package:flutter/material.dart';
import '../data/sample_events.dart';
import '../models/event_item.dart';
import '../models/registration_ticket.dart';
import '../widgets/event_card.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/venue_map_viewer.dart';
import 'event_registration_screen.dart';
import 'registered_tickets_screen.dart';

class HomeEventsScreen extends StatefulWidget {
  const HomeEventsScreen({super.key});

  @override
  State<HomeEventsScreen> createState() => _HomeEventsScreenState();
}

class _HomeEventsScreenState extends State<HomeEventsScreen> {
  String _selectedCategory = 'Semua';
  final List<RegistrationTicket> _registeredTickets = [];

  List<EventItem> get _filteredEvents {
    if (_selectedCategory == 'Semua') {
      return sampleEvents;
    }
    return sampleEvents
        .where((e) => e.category == _selectedCategory)
        .toList();
  }

  void _openFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return FilterBottomSheet(
          selectedCategory: _selectedCategory,
          onSelectCategory: (cat) {
            setState(() => _selectedCategory = cat);
          },
        );
      },
    );
  }

  void _navigateToRegistration(EventItem event) async {
    final ticket = await Navigator.push<RegistrationTicket>(
      context,
      MaterialPageRoute(
        builder: (context) => EventRegistrationScreen(event: event),
      ),
    );

    if (ticket != null) {
      setState(() {
        _registeredTickets.add(ticket);
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '🎉 Pendaftaran Berhasil! Tiket ${ticket.id} ditambahkan.',
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('NusaEvent Hub'),
          actions: [
            IconButton(
              tooltip: 'Filter Kategori',
              icon: const Icon(Icons.filter_list_rounded),
              onPressed: _openFilterBottomSheet,
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.event_note_rounded),
                text: 'Seminar',
              ),
              Tab(
                icon: Icon(Icons.map_rounded),
                text: 'Denah & Galeri',
              ),
              Tab(
                icon: Icon(Icons.confirmation_number_rounded),
                text: 'Tiket Saya',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Seminar & Workshop List
            Column(
              children: [
                if (_selectedCategory != 'Semua')
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: Colors.indigo.withOpacity(0.08),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Filter: Kategori $_selectedCategory'),
                        InkWell(
                          onTap: () => setState(() => _selectedCategory = 'Semua'),
                          child: const Text(
                            'Reset Filter',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredEvents.length,
                    itemBuilder: (context, index) {
                      final event = _filteredEvents[index];
                      return EventCard(
                        event: event,
                        onTap: () => _navigateToRegistration(event),
                        onRegister: () => _navigateToRegistration(event),
                      );
                    },
                  ),
                ),
              ],
            ),

            // Tab 2: Galeri & Denah Venue InteractiveViewer
            VenueMapViewer(events: sampleEvents),

            // Tab 3: Tiket Terdaftar & Dismissible
            RegisteredTicketsScreen(
              tickets: _registeredTickets,
              onCancelTicket: (ticketId) {
                setState(() {
                  _registeredTickets.removeWhere((t) => t.id == ticketId);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
