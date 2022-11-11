import 'package:flutter/material.dart';

class AppVersions extends StatelessWidget {
  const AppVersions({
    Key? key,
    required this.app,
  }) : super(key: key);

  final Map<String, dynamic> app;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: screenWidth < 780 ? double.infinity : screenWidth - 200,
          minWidth: 580,
        ),
        child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final indexedVersion = app['versions'][index];
              var versionAndDate = <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        indexedVersion['version'],
                        style: textTheme.displaySmall!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                      ),
                      Visibility(
                        visible: index == 0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            shadowColor: colorScheme.background,
                            color: colorScheme.tertiaryContainer,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'En Son',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Yayınlanma tarihi: ${indexedVersion['date']}",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ];
              return Card(
                color: colorScheme.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      screenWidth < 550
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: versionAndDate,
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: versionAndDate,
                            ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                        child: Text(
                          'Yapılan Değişikler',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListView.builder(
                        padding: const EdgeInsets.all(8),
                        shrinkWrap: true,
                        itemBuilder: (context, index2) {
                          return Text('* ${indexedVersion['changes'][index2]}');
                        },
                        itemCount: indexedVersion['changes'].length,
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                        child: Text('Düzeltilen Hatalar',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      ListView.builder(
                        padding: const EdgeInsets.all(8),
                        shrinkWrap: true,
                        itemBuilder: (context, index3) {
                          return Text(
                              '* ${indexedVersion['fixed bugs'][index3]}');
                        },
                        itemCount: indexedVersion['fixed bugs'].length,
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(),
              );
            },
            itemCount: app['versions'].length),
      ),
    );
  }
}
