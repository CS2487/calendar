import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../cubit/calendar_cubit.dart';
import '../models/calendar_event.dart';
import 'edit_event_screen.dart';

class EventDetailsScreen extends StatefulWidget {
  final CalendarEvent event;
  final DateTime selectedDay;

  const EventDetailsScreen({
    Key? key,
    required this.event,
    required this.selectedDay,
  }) : super(key: key);

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late CalendarEvent _currentEvent;

  @override
  void initState() {
    super.initState();
    _currentEvent = widget.event;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitleDetail),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final editedEvent = await Navigator.push<CalendarEvent>(
                context,
                MaterialPageRoute(
                  builder: (context) => EditEventScreen(
                    event: _currentEvent,
                    selectedDay: widget.selectedDay,
                  ),
                ),
              );

              if (editedEvent != null && mounted) {
                setState(() {
                  _currentEvent = editedEvent;
                });

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.eventUpdatedSuccess)),
                  );
                }
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                _currentEvent.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 10,
              decoration: BoxDecoration(
                color: _currentEvent.color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _currentEvent.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
