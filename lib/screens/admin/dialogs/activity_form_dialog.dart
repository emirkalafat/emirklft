import 'package:blog_web_site/screens/recap/activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blog_web_site/services/firestore/activities/activities_controller.dart';
import 'package:blog_web_site/core/providers/error_provider.dart';

class ActivityFormDialog extends ConsumerStatefulWidget {
  final Activity? activity;

  const ActivityFormDialog({super.key, this.activity});

  @override
  ConsumerState<ActivityFormDialog> createState() => _ActivityFormDialogState();
}

class _ActivityFormDialogState extends ConsumerState<ActivityFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;
  late TextEditingController _urlController;
  DateTime? _startDate;
  DateTime? _finishDate;
  ActivityType _selectedType = ActivityType.other;
  ActivityStatus _selectedStatus = ActivityStatus.ongoing;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.activity?.title ?? '');
    _descriptionController = TextEditingController(text: widget.activity?.description ?? '');
    _imageUrlController = TextEditingController(text: widget.activity?.imageUrl ?? '');
    _urlController = TextEditingController(text: widget.activity?.url ?? '');
    _startDate = widget.activity?.startedDate;
    _finishDate = widget.activity?.finishedDate;
    _selectedType = widget.activity?.type ?? ActivityType.other;
    _selectedStatus = widget.activity?.status ?? ActivityStatus.ongoing;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.activity == null ? 'Add Activity' : 'Edit Activity'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                maxLines: 3,
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
              TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(labelText: 'URL'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Start Date'),
                      subtitle: Text(_startDate?.toString() ?? 'Not set'),
                      onTap: () => _selectDate(context, true),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Finish Date'),
                      subtitle: Text(_finishDate?.toString() ?? 'Not set'),
                      onTap: () => _selectDate(context, false),
                    ),
                  ),
                ],
              ),
              DropdownButtonFormField<ActivityType>(
                value: _selectedType,
                decoration: const InputDecoration(labelText: 'Type'),
                items: ActivityType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.name),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedType = value);
                  }
                },
              ),
              DropdownButtonFormField<ActivityStatus>(
                value: _selectedStatus,
                decoration: const InputDecoration(labelText: 'Status'),
                items: ActivityStatus.values.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status.name),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedStatus = value);
                  }
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _saveActivity,
          child: const Text('Save'),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? (_startDate ?? DateTime.now()) : (_finishDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _finishDate = picked;
        }
      });
    }
  }

  void _saveActivity() async {
    if (_formKey.currentState?.validate() ?? false) {
      final activity = Activity(
        id: widget.activity?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        imageUrl: _imageUrlController.text.isEmpty ? null : _imageUrlController.text,
        url: _urlController.text.isEmpty ? null : _urlController.text,
        startedDate: _startDate,
        finishedDate: _finishDate,
        type: _selectedType,
        status: _selectedStatus,
      );

      final controller = ref.read(activitiesControllerProvider.notifier);
      bool success;

      if (widget.activity == null) {
        success = await controller.addActivity(activity);
      } else {
        success = await controller.updateActivity(activity);
      }

      if (mounted) {
        if (success) {
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(ref.read(errorProvider) ?? 'An error occurred'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
