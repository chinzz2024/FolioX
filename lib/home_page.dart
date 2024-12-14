import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
<<<<<<< HEAD
import 'dart:convert';

class StockNewsPage extends StatefulWidget {
  const StockNewsPage({Key? key}) : super(key: key);
=======
import 'package:html/parser.dart';
import 'planner_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
>>>>>>> ac381e55c7343aef60a8a6c4d895c269ed1f6092

  @override
  _StockNewsPageState createState() => _StockNewsPageState();
}

<<<<<<< HEAD
class _StockNewsPageState extends State<StockNewsPage> {
  List<dynamic> _newsArticles = [];
  bool _isLoading = true;
  String _errorMessage = '';
=======
class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Map<String, String>> newsArticles = [];
  bool isLoading = true;
>>>>>>> ac381e55c7343aef60a8a6c4d895c269ed1f6092

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    _fetchStockNews();
  }

  Future<void> _fetchStockNews() async {
    const String apiUrl =
        'https://api.example.com/stock-news'; // Replace with a real API URL

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          final data = json.decode(response.body);
          _newsArticles = data['articles'] ?? [];
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load news. Please try again later.';
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'An error occurred: $error';
        _isLoading = false;
=======
    scrapeStockNews();
  }

  Future<void> scrapeStockNews() async {
    final url =
        'https://www.moneycontrol.com/rss/MCtopnews.xml'; // Public RSS feed for stock news
     // Public RSS feed for stock news


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
>>>>>>> ac381e55c7343aef60a8a6c4d895c269ed1f6092
      });
      print('Error: $e');
    }
  }

<<<<<<< HEAD
  void _openArticleUrl(String url) {
    // Logic to open the URL (e.g., using url_launcher package)
    print('Opening URL: $url');
=======
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      // Navigate to Planner page when Planner tab is tapped
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PlannerPage()), // Navigates to PlannerPage
      );
    }
>>>>>>> ac381e55c7343aef60a8a6c4d895c269ed1f6092
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
<<<<<<< HEAD
          'Stock News',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  itemCount: _newsArticles.length,
                  itemBuilder: (context, index) {
                    final article = _newsArticles[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(article['title'] ?? 'No Title'),
                        subtitle:
                            Text(article['description'] ?? 'No Description'),
                        onTap: () {
                          if (article['url'] != null) {
                            _openArticleUrl(article['url']);
                          }
                        },
=======
          'Stock News Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 12, 6, 37),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : newsArticles.isEmpty
              ? const Center(child: Text('No news available.'))
              : GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two columns
                    crossAxisSpacing: 10.0, // Horizontal spacing between items
                    mainAxisSpacing: 10.0, // Vertical spacing between items
                  ),
                  itemCount: newsArticles.length,
                  itemBuilder: (context, index) {
                    final article = newsArticles[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NewsDetailPage(link: article['link']!),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article['title']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
>>>>>>> ac381e55c7343aef60a8a6c4d895c269ed1f6092
                      ),
                    );
                  },
                ),
<<<<<<< HEAD
=======
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Calls the onItemTapped function on tap
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
>>>>>>> ac381e55c7343aef60a8a6c4d895c269ed1f6092
    );
  }
}
