import 'package:flutter/material.dart';
import 'package:maps_app/models/documents.dart';

import '../../utils/apptheme.dart';
import 'document_detail.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<DocmnetRe> documnets = docs;
    return Scaffold(
        appBar: AppBar(
          titleTextStyle: ThemeConfig.textTheme.headline2,
          title: const Text(
            'Application Center',
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height - 50,
          child: ListView.builder(
            itemCount: documnets.length,
            itemBuilder: (context, ints) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DocumentDetailScreen(documnets[ints]))),
                  title: Text(documnets[ints].title),
                  subtitle: Text(
                      "${documnets[ints].certificates.length} Certificates required"),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.document_scanner,
                      color: Colors.white,
                    ),
                  ),
                  trailing: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
