import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsService {
  // Using NewsAPI's free tier
  static const String _baseUrl = 'https://newsapi.org/v2';

  //get environment variable for API key
  static const String _apiKey = String.fromEnvironment('NEWSAPI_KEY');

  Future<List<Article>> getTopHeadlines() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/everything?q=artificial+intelligence+OR+AI&sortBy=publishedAt&apiKey=$_apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = (data['articles'] as List)
            .map((article) => Article.fromJson(article))
            .toList();
        return articles;
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      // For demo purposes, return mock data if API fails
      return _getMockArticles();
    }
  }

  List<Article> _getMockArticles() {
    return [
      Article(
        title: 'AI Makes Breakthrough in Drug Discovery',
        description: 'Artificial Intelligence system successfully identifies new potential drug candidates...',
        url: 'https://example.com/ai-drug-discovery',
        imageUrl: 'https://via.placeholder.com/300x200',
        source: 'AI News',
        publishedAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Article(
        title: 'ChatGPT Advances Natural Language Processing',
        description: 'OpenAI\'s latest model shows significant improvements in understanding context...',
        url: 'https://example.com/chatgpt-nlp',
        imageUrl: 'https://via.placeholder.com/300x200',
        source: 'Tech AI',
        publishedAt: DateTime.now().subtract(const Duration(hours: 4)),
      ),
      Article(
        title: 'AI Ethics Guidelines Released',
        description: 'Major tech companies collaborate on new AI ethics framework...',
        url: 'https://example.com/ai-ethics',
        imageUrl: 'https://via.placeholder.com/300x200',
        source: 'AI Ethics Watch',
        publishedAt: DateTime.now().subtract(const Duration(hours: 6)),
      ),
    ];
  }
}
