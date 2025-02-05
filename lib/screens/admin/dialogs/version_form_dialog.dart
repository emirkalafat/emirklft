import 'package:blog_web_site/core/providers/error_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blog_web_site/models/version.dart';
import 'package:blog_web_site/services/firestore/versions/versions_controller.dart';
import 'package:blog_web_site/core/utils/form_validators.dart';

class VersionFormDialog extends ConsumerStatefulWidget {
  final String storageID;
  final Version? version;
  final String? versionId;

  const VersionFormDialog({
    super.key,
    required this.storageID,
    this.version,
    this.versionId,
  });

  @override
  ConsumerState<VersionFormDialog> createState() => _VersionFormDialogState();
}

class _VersionFormDialogState extends ConsumerState<VersionFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _versionController;
  late TextEditingController _dateController;
  bool _isBeta = false;
  final List<String> _changes = [];
  final List<String> _fixes = [];

  @override
  void initState() {
    super.initState();
    _versionController =
        TextEditingController(text: widget.version?.version ?? '');
    _dateController = TextEditingController(text: widget.version?.date ?? '');
    _isBeta = widget.version?.isBeta ?? false;
    if (widget.version != null) {
      _changes.addAll(widget.version!.changes.cast<String>());
      _fixes.addAll(widget.version!.fixes.cast<String>());
    }
  }

  @override
  void dispose() {
    _versionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.version == null ? 'Add Version' : 'Edit Version'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _versionController,
                decoration: const InputDecoration(
                  labelText: 'Version',
                  hintText: '1.0.0',
                ),
                validator: FormValidators.version,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  hintText: 'YYYY-MM-DD',
                ),
                validator: FormValidators.date,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              CheckboxListTile(
                title: const Text('Is Beta'),
                value: _isBeta,
                onChanged: (value) => setState(() => _isBeta = value ?? false),
              ),
              _buildListSection('Changes', _changes),
              _buildListSection('Fixes', _fixes),
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
          onPressed: _saveVersion,
          child: const Text('Save'),
        ),
      ],
    );
  }

  Widget _buildListSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        ...items.asMap().entries.map((entry) => Row(
              children: [
                Expanded(child: Text(entry.value)),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => setState(() => items.removeAt(entry.key)),
                ),
              ],
            )),
        TextButton(
          onPressed: () => _addItem(items),
          child: Text('Add $title'),
        ),
      ],
    );
  }

  void _addItem(List<String> items) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Item'),
        content: TextFormField(
          controller: controller,
          validator: FormValidators.required,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            hintText: 'Enter item description',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() => items.add(controller.text));
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _saveVersion() async {
    if (_formKey.currentState?.validate() ?? false) {
      final version = Version(
        version: _versionController.text,
        date: _dateController.text,
        isBeta: _isBeta,
        changes: _changes,
        fixes: _fixes,
      );

      final controller = ref.read(versionsControllerProvider.notifier);
      bool success;

      if (widget.version == null) {
        success = await controller.addVersion(widget.storageID, version);
      } else {
        success = await controller.updateVersion(
          widget.storageID,
          widget.versionId!,
          version,
        );
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
