import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> newsArticles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    scrapeStockNews();
  }

  Future<void> scrapeStockNews() async {
    final url =
        'https://example.com/stock-news'; // Replace with a valid stock news URL

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final document = parse(response.body);

        // Extract news data (update selectors based on actual webpage structure)
        final newsElements = document.querySelectorAll('.news-item-class');
        final fetchedNews = newsElements.map((element) {
          final title = element.querySelector('.news-title-class')?.text.trim();
          final link = element.querySelector('a')?.attributes['href'];
          return {'title': title ?? 'No Title', 'link': link ?? '#'};
        }).toList();

        setState(() {
          newsArticles = fetchedNews;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to load the webpage: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock News'),
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : newsArticles.isEmpty
              ? const Center(child: Text('No news available.'))
              : ListView.builder(
                  itemCount: newsArticles.length,
                  itemBuilder: (context, index) {
                    final article = newsArticles[index];
                    return ListTile(
                      title: Text(article['title']!),
                      onTap: () {
                        // Open news link
                        if (article['link'] != null && article['link'] != '#') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewsDetailPage(link: article['link']!),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
    );
  }
}

class NewsDetailPage extends StatelessWidget {
  final String link;

  const NewsDetailPage({required this.link, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Detail'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text('Display full article from: $link'),
      ),
    );
  }
}
