import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StockNewsPage extends StatefulWidget {
  const StockNewsPage({Key? key}) : super(key: key);

  @override
  _StockNewsPageState createState() => _StockNewsPageState();
}

class _StockNewsPageState extends State<StockNewsPage> {
  List<dynamic> _newsArticles = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
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
      });
    }
  }

  void _openArticleUrl(String url) {
    // Logic to open the URL (e.g., using url_launcher package)
    print('Opening URL: $url');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
                      ),
                    );
                  },
                ),
    );
  }
}
