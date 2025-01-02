import 'package:blog_web_site/screens/recap/activity.dart';
import 'package:blog_web_site/widgets/source_aware_image.dart';
import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

List<Activity> liste = [
  Activity(
    id: '1',
    title: 'Puslu Kıtalar Atlası',
    description: 'İhsan Oktay Anar',
    imageUrl:
        'https://i.dr.com.tr/cache/500x400-0/originals/0000000061857-1.jpg',
    url:
        'https://www.dr.com.tr/Kitap/Puslu-Kitalar-Atlasi/Edebiyat/Roman/Turk-Roman/urunno=0000000061857',
    startedDate: DateTime(2025, 1, 1),
    finishedDate: null,
    status: ActivityStatus.ongoing,
    type: ActivityType.book,
  ),
];

class RecapScreen extends StatelessWidget {
  const RecapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
            builder: (context) => Timeline.custom(
                  childrenDelegate: TimelineTileBuilderDelegate(
                    (context, index) {
                      return TimelineTile(
                        nodeAlign: TimelineNodeAlign.start,
                        contents: ListTile(
                          title: Text(liste[index].title),
                          subtitle: Text(liste[index].description),
                          leading: SourceAwareImage(
                            image: liste[index].imageUrl,
                            isNetworkImage: true,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Scaffold(
                                      appBar: AppBar(
                                        title: Text(liste[index].title),
                                      ),
                                      body: Center(
                                        child: Column(
                                          children: [
                                            Image.network(
                                                liste[index].imageUrl),
                                            Text(liste[index].description),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Geri'))
                                          ],
                                        ),
                                      ),
                                    )));
                          },
                        ),
                        node: TimelineNode(
                          indicatorPosition: 0,
                          indicator: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: const BorderSide(color: Colors.blue),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${liste[index].startedDate?.year ?? ''} - ${liste[index].finishedDate == null ? 'Devam Ediyor' : liste[index].finishedDate?.year.toString() ?? ''}',
                              ),
                            ),
                          ),
                          startConnector:
                              const SolidLineConnector(color: Colors.blue),
                          endConnector:
                              const SolidLineConnector(color: Colors.blue),
                        ),
                      );
                    },
                    childCount: liste.length,
                  ),
                )));
  }
}
