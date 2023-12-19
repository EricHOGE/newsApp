import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleCard extends StatelessWidget {
  final String title;
  final String? author;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  final String? sourceName;

  const ArticleCard({
    Key? key,
    required this.title,
    this.author,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.sourceName,
  }) : super(key: key);

  void _launchURL(String? url) async {
    if (url == null || url.isEmpty) {
      print('URL is null or empty');
      return;
    }
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    // Convertir la date
    String formattedDate = '';
    if (publishedAt != null) {
      DateTime dateTime = DateTime.parse(publishedAt!);
      formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    }
    // void launchUrl(String url) async {
    //   if (!await launchUrlString(url)) throw Exception('Could not launch $url');
    // }

    return InkWell(
      onTap: () => _launchURL(url),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (urlToImage != null)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                child: Image.network(urlToImage!),
              ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  if (author != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('Auteur: $author'),
                    ),
                  if (publishedAt != null) Text('Publié le : $formattedDate'),
                  if (description != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(description!),
                    ),
                  if (sourceName != null) Text('Source: $sourceName'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
