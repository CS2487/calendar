import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../cubit/calendar_cubit.dart';
import '../models/calendar_event.dart';

class EditEventScreen extends StatefulWidget {
  final CalendarEvent event;
  final DateTime selectedDay;

  const EditEventScreen({
    Key? key,
    required this.event,
    required this.selectedDay,
  }) : super(key: key);

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.event.title);
    _descriptionController =
        TextEditingController(text: widget.event.description);
    _selectedColor = widget.event.color;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final calendarCubit = context.read<CalendarCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.editEvent),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (_titleController.text.trim().isEmpty ||
                  _descriptionController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.titleRequired)),
                );
                return;
              }

              final editedEvent = CalendarEvent(
                id: widget.event.id,
                title: _titleController.text.trim(),
                description: _descriptionController.text.trim(),
                gregorianDate: widget.selectedDay,
                color: _selectedColor,
              );

              calendarCubit.updateEvent(widget.event, editedEvent);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.eventUpdatedSuccess)),
              );

              Navigator.pop(context, editedEvent);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: l10n.title,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: l10n.description,
                  border: const OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 9,
                children: Colors.primaries.map((color) {
                  final isSelected = _selectedColor == color;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedColor = color),
                    child: Container(
                      width: 30,
                      height: 30,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                size: 22,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
