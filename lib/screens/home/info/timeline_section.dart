import 'package:flutter/material.dart';

import '../../../widgets/timeline_widget.dart';

class TimelineSection extends StatelessWidget {
  const TimelineSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Wrap(
        children: const [
          TimelineWidget(
            year: '2013',
            event:
                'İlk uygulamamı Python ile yazdım. Basit bir hesap makinesi uygulamasıydı.',
          ),
          TimelineWidget(
            year: '2016',
            event:
                'Şehremini Anadolu Lisesi\'nde eğitime başladım.\nVisual Basic ile ilk uygulamamı yazdım. TicTacToe oyunuydu. Visual Basic\'i çok sevemedim.',
          ),
          TimelineWidget(
            year: '2020',
            event:
                'Fatih Sultan Mehmet Vakıf Üniversitesi\'nde lisans eğitimine başladım. Java öğrenmeye başladım ve bir kaç demo uygulama oluşturdum.',
          ),
          TimelineWidget(
            year: '2021',
            event:
                'Flutter and Dart öğrenmeye başladım. Yeni küçük uygulamalar yapmaya başladım. Flutter\'ı çok sevdim.',
          ),
          TimelineWidget(
            year: '2022',
            event:
                'İlk büyük ölçekli uygulamamı Play Store\'da yayınladım. Projelerim sekmesinde paylaştım. "Yemek Deposu" adıyla bulabilirsiniz.',
          ),
        ],
      ),
    );
  }
}
