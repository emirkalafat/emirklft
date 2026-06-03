import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blog_web_site/core/providers/error_provider.dart';
import 'package:blog_web_site/features/recap/models/activity.dart';
import 'package:blog_web_site/services/firestore/activities/activities_controller.dart';
import 'package:blog_web_site/services/external/external_search_service.dart';

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
  late TextEditingController _personalNoteController;
  late TextEditingController _personalRatingController;
  DateTime? _startDate;
  DateTime? _finishDate;
  ActivityType _selectedType = ActivityType.other;
  ActivityStatus _selectedStatus = ActivityStatus.ongoing;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.activity?.title ?? '');
    _descriptionController = TextEditingController(text: widget.activity?.description ?? '');
    _imageUrlController = TextEditingController(text: widget.activity?.imageUrl ?? '');
    _urlController = TextEditingController(text: widget.activity?.url ?? '');
    _personalNoteController = TextEditingController(text: widget.activity?.personalNote ?? '');
    _personalRatingController = TextEditingController(text: widget.activity?.personalRating?.toString() ?? '');
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
    _personalNoteController.dispose();
    _personalRatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.activity == null ? 'Add Activity' : 'Edit Activity'),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    suffixIcon: _isSearching
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: _searchActivity,
                            tooltip: 'Search details',
                          ),
                  ),
                  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                ExpansionTile(
                  title: const Text('Metadata (Auto-filled)', style: TextStyle(fontSize: 14, color: Colors.grey)),
                  children: [
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(labelText: 'Description'),
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
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const Text('Personal Review', style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _personalRatingController,
                  decoration: const InputDecoration(labelText: 'Personal Rating (0.0 - 5.0)'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) return null;
                    final rating = double.tryParse(value);
                    if (rating == null) return 'Invalid number';
                    if (rating < 0 || rating > 5) return 'Must be between 0 and 5';
                    return null;
                  },
                ),
                TextFormField(
                  controller: _personalNoteController,
                  decoration: const InputDecoration(labelText: 'Personal Note'),
                  maxLines: 5,
                ),
                const Divider(),
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

  Future<void> _searchActivity() async {
    final query = _titleController.text;
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title to search')),
      );
      return;
    }

    setState(() => _isSearching = true);

    List<Activity> results = [];
    if (_selectedType == ActivityType.movie || _selectedType == ActivityType.tvShow) {
      results = await ref.read(tmdbServiceProvider).search(query);
    } else if (_selectedType == ActivityType.book) {
      results = await ref.read(openLibraryServiceProvider).search(query);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Search not supported for this type')),
      );
      setState(() => _isSearching = false);
      return;
    }

    setState(() => _isSearching = false);

    if (!mounted) return;

    if (results.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No results found')),
      );
      return;
    }

    // Show results dialog
    final selected = await showDialog<Activity>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Result'),
        content: SizedBox(
          width: 400,
          height: 400,
          child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final item = results[index];
              return ListTile(
                leading: item.imageUrl != null
                    ? Image.network(item.imageUrl!, width: 50, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.broken_image))
                    : const Icon(Icons.image),
                title: Text(item.title),
                subtitle: Text(item.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                onTap: () => Navigator.pop(context, item),
              );
            },
          ),
        ),
      ),
    );

    if (selected != null) {
      setState(() {
        _titleController.text = selected.title;
        _descriptionController.text = selected.description;
        _imageUrlController.text = selected.imageUrl ?? '';
        _urlController.text = selected.url ?? '';
        if (selected.type != ActivityType.unknown) {
          _selectedType = selected.type;
        }
      });
    }
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
        personalNote: _personalNoteController.text.isEmpty ? null : _personalNoteController.text,
        personalRating: double.tryParse(_personalRatingController.text),
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
