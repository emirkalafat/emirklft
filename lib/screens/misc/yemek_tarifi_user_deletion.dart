import 'package:blog_web_site/core/constants.dart';
import 'package:blog_web_site/core/utils/utils.dart';
import 'package:flutter/material.dart';

class YemekTarifiUserDeletion extends StatelessWidget {
  const YemekTarifiUserDeletion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Yemek Tarifi Kullanıcı Silme'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Kullanıcıyı silmek için uygulamanın içerisindeki kullanıcı silme işlemini kullanınız. Kullanıcı silindikten sonra verileriniz geri getirilemez.',
                style: TextStyle(fontSize: 18),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Utils.startUrl(AppConstants.yemekDeposuPlayLink);
                },
                child: const Text('Kullanıcıyı Sil')),
          ],
        ));
  }
}
