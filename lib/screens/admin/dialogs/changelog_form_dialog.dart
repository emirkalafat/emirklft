import 'package:blog_web_site/core/providers/error_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blog_web_site/models/changelog_model.dart';
import 'package:blog_web_site/services/firestore/changelogs/changelogs_controller.dart';
import 'package:blog_web_site/core/utils/form_validators.dart';

class ChangelogFormDialog extends ConsumerStatefulWidget {
  final Changelog? changelog;

  const ChangelogFormDialog({super.key, this.changelog});

  @override
  ConsumerState<ChangelogFormDialog> createState() =>
      _ChangelogFormDialogState();
}

class _ChangelogFormDialogState extends ConsumerState<ChangelogFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _idController;
  late TextEditingController _storageIDController;
  late TextEditingController _nameController;
  late TextEditingController _explanationController;
  late TextEditingController _imageController;
  late TextEditingController _googlePlayController;
  late TextEditingController _appStoreController;
  late TextEditingController _githubController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: widget.changelog?.id ?? '');
    _storageIDController =
        TextEditingController(text: widget.changelog?.storageID ?? '');
    _nameController = TextEditingController(text: widget.changelog?.name ?? '');
    _explanationController =
        TextEditingController(text: widget.changelog?.explanation ?? '');
    _imageController =
        TextEditingController(text: widget.changelog?.image ?? '');
    _googlePlayController =
        TextEditingController(text: widget.changelog?.googlePlayLink ?? '');
    _appStoreController =
        TextEditingController(text: widget.changelog?.appStoreLink ?? '');
    _githubController =
        TextEditingController(text: widget.changelog?.githubLink ?? '');
  }

  @override
  void dispose() {
    _idController.dispose();
    _storageIDController.dispose();
    _nameController.dispose();
    _explanationController.dispose();
    _imageController.dispose();
    _googlePlayController.dispose();
    _appStoreController.dispose();
    _githubController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(widget.changelog == null ? 'Add Changelog' : 'Edit Changelog'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(labelText: 'ID'),
                validator: FormValidators.required,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              TextFormField(
                controller: _storageIDController,
                decoration: const InputDecoration(labelText: 'Storage ID'),
                validator: FormValidators.required,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: FormValidators.required,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              TextFormField(
                controller: _explanationController,
                decoration: const InputDecoration(labelText: 'Explanation'),
                validator: FormValidators.required,
                maxLines: 3,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
              TextFormField(
                controller: _googlePlayController,
                decoration:
                    const InputDecoration(labelText: 'Google Play Link'),
              ),
              TextFormField(
                controller: _appStoreController,
                decoration: const InputDecoration(labelText: 'App Store Link'),
              ),
              TextFormField(
                controller: _githubController,
                decoration: const InputDecoration(labelText: 'GitHub Link'),
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
          onPressed: _saveChangelog,
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _saveChangelog() async {
    if (_formKey.currentState?.validate() ?? false) {
      final changelog = Changelog(
        id: _idController.text,
        storageID: _storageIDController.text,
        name: _nameController.text,
        explanation: _explanationController.text,
        image: _imageController.text.isEmpty ? null : _imageController.text,
        googlePlayLink: _googlePlayController.text.isEmpty
            ? null
            : _googlePlayController.text,
        appStoreLink:
            _appStoreController.text.isEmpty ? null : _appStoreController.text,
        githubLink:
            _githubController.text.isEmpty ? null : _githubController.text,
      );

      final controller = ref.read(changelogsControllerProvider.notifier);
      bool success;
      
      if (widget.changelog == null) {
        success = await controller.addChangelog(changelog);
      } else {
        success = await controller.updateChangelog(changelog);
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
