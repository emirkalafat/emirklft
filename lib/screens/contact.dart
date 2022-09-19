import 'dart:convert';

import 'package:blog_web_site/screens/home_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../widgets/utils.dart';

class ContactWithMe extends StatefulWidget {
  const ContactWithMe({super.key});

  @override
  State<ContactWithMe> createState() => _ContactWithMeState();
}

class _ContactWithMeState extends State<ContactWithMe> {
  final _formKey = GlobalKey<FormState>();
  var controllerUserName = TextEditingController();
  var controllerUserEmail = TextEditingController();
  var controllerEmailSubject = TextEditingController();
  var controllerMessage = TextEditingController();
  Future _sendFeedback({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    if (!_formKey.currentState!.validate()) return;
    const serviceID = 'service_xup0xjb';
    const templateID = 'template_ltjsda5';
    const userID = 'UZdx0SjUX4IzCjN7M';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    bool isSent = false;
    try {
      await http.post(
        url,
        headers: {
          'origin': 'http://emirklftweb.firebaseapp.com',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceID,
          'template_id': templateID,
          'user_id': userID,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'user_subject': subject,
            'user_message': message,
          }
        }),
      );
      isSent = true;
    } on Exception catch (e) {
      Utils.showSnackBar(e.toString());
    }
    if (isSent) {
      showTopSnackBar(
        context,
        MyCustomTopBar(message: 'Mailiniz Gönderildi.'),
      );
      //Utils.showSnackBar("Mailiniz Gönderildi.", isError: false);
    }
    controllerEmailSubject.clear();
    controllerMessage.clear();
    controllerUserEmail.clear();
    controllerUserName.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 750),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Bana Ulaşın",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Boş Bırakmayınız!'
                              : null,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("İsminiz"),
                          ),
                          controller: controllerUserName),
                      const SizedBox(height: 12),
                      TextFormField(
                          autocorrect: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Boş Bırakmayınız!'
                              : !EmailValidator.validate(value)
                                  ? 'Geçerli bir mail adresi girin!'
                                  : null,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Mail Adresiniz"),
                          ),
                          controller: controllerUserEmail),
                      const SizedBox(height: 12),
                      TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Boş Bırakmayınız!'
                              : null,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Mailin Konusu"),
                          ),
                          controller: controllerEmailSubject),
                      const SizedBox(height: 12),
                      TextFormField(
                          maxLines: 5,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Boş Bırakmayınız!'
                              : null,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Mesajınız"),
                          ),
                          controller: controllerMessage),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // Foreground color
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    // Background color
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                  onPressed: () => _sendFeedback(
                    name: controllerUserName.text.trim(),
                    email: controllerUserEmail.text.trim(),
                    subject: controllerEmailSubject.text.trim(),
                    message: controllerMessage.text.trim(),
                  ),
                  child: const Text("Maili Gönderin"),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
