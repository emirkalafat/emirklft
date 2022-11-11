import 'dart:convert';
import 'package:blog_web_site/widgets/default_widgets.dart';
import 'package:blog_web_site/screens/home/external_links_section.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../widgets/custom_notification.dart';
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
      showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      await http.post(
        url,
        headers: {
          'origin': 'http://emirklftweb.web.app',
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
      // ignore: use_build_context_synchronously
      Navigator.maybePop(context);
    } on Exception catch (e) {
      Utils.showSnackBar(e.toString());
    }
    if (isSent) {
      // ignore: use_build_context_synchronously
      showTopSnackBar(
        context,
        const CustomNotification(message: 'Mailiniz Gönderildi.'),
      );
    }
    controllerEmailSubject.clear();
    controllerMessage.clear();
    controllerUserEmail.clear();
    controllerUserName.clear();
    //clear işlemlerinden sonra _formkey kutuları boş bırakmayın uyarısını göstermemesi için reset işlemi yapıyoruz.
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        height: screenSize.height - 56,
        child: Container(
          constraints: buildDefaultConstraints(
            maxWidth: 700,
            minHeight: screenSize.height - 56,
            maxHeight: screenSize.height - 56,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //Spacer(),
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          controllerEmailSubject.clear();
                          controllerMessage.clear();
                          controllerUserEmail.clear();
                          controllerUserName.clear();
                          _formKey.currentState!.reset();
                        },
                        child: const Text("Formu Temizle"),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // Foreground color
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          // Background color
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                        onPressed: () => _sendFeedback(
                          name: controllerUserName.text.trim(),
                          email: controllerUserEmail.text.trim(),
                          subject: controllerEmailSubject.text.trim(),
                          message: controllerMessage.text.trim(),
                        ),
                        child: const Text(
                          "Maili Gönderin",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  const MyLinksSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
