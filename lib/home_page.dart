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
  int _selectedIndex = 0;
  List<Map<String, String>> newsArticles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    scrapeStockNews();
  }

  Future<void> scrapeStockNews() async {
    final url =
        'https://www.finance.yahoo.com/rss/'; // Public RSS feed for stock news

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the XML response
        final document = parse(response.body);
        final items = document.getElementsByTagName('item');

        final fetchedNews = items.map((item) {
          final title = item.getElementsByTagName('title').first.text;
          final link = item.getElementsByTagName('link').first.text;
          return {'title': title, 'link': link};
        }).toList();

        setState(() {
          newsArticles = fetchedNews;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to load the news: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NewsDetailPage(link: article['link']!),
                          ),
                        );
                      },
                    );
                  },
                ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Stock',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.savings),
            label: 'Planner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
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
        child: Text('Visit the full article: $link'),
      ),
    );
  }
}
