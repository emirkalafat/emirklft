import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blog_web_site/core/secrets.dart';
import 'package:blog_web_site/features/recap/models/activity.dart';

final tmdbServiceProvider = Provider((ref) => TmdbService());

class TmdbService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  Future<List<Activity>> search(String query) async {
    if (Secrets.tmdbApiKey == 'YOUR_TMDB_API_KEY_HERE' || Secrets.tmdbApiKey.isEmpty) {
      return [];
    }

    final url = Uri.parse('$_baseUrl/search/multi?api_key=${Secrets.tmdbApiKey}&query=${Uri.encodeComponent(query)}');
    
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'] ?? [];
        
        return results.map((item) {
          final isMovie = item['media_type'] == 'movie';
          final title = item[isMovie ? 'title' : 'name'] ?? '';
          final description = item['overview'] ?? '';
          final posterPath = item['poster_path'];
          final imageUrl = posterPath != null ? '$_imageBaseUrl$posterPath' : null;
          
          return Activity(
            id: DateTime.now().millisecondsSinceEpoch.toString(), // Temporary ID
            title: title,
            description: description,
            imageUrl: imageUrl,
            type: isMovie ? ActivityType.movie : ActivityType.tvShow,
            status: ActivityStatus.ongoing,
          );
        }).toList();
      }
    } catch (e) {
      print('TMDb search error: $e');
    }
    return [];
  }
}

final openLibraryServiceProvider = Provider((ref) => OpenLibraryService());

class OpenLibraryService {
  static const String _baseUrl = 'https://openlibrary.org/search.json';
  static const String _imageBaseUrl = 'https://covers.openlibrary.org/b/id';

  Future<List<Activity>> search(String query) async {
    final url = Uri.parse('$_baseUrl?q=${Uri.encodeComponent(query)}');
    
    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List docs = data['docs'] ?? [];
        
        return docs.map((item) {
          final title = item['title'] ?? '';
          final authors = (item['author_name'] as List?)?.join(', ') ?? '';
          final coverId = item['cover_i'];
          final imageUrl = coverId != null ? '$_imageBaseUrl/$coverId-L.jpg' : null;
          final key = item['key'];
          final infoLink = key != null ? 'https://openlibrary.org$key' : null;
          
          return Activity(
            id: DateTime.now().millisecondsSinceEpoch.toString(), // Temporary ID
            title: title,
            description: authors.isNotEmpty ? 'Author(s): $authors' : 'No description available.',
            imageUrl: imageUrl,
            url: infoLink,
            type: ActivityType.book,
            status: ActivityStatus.ongoing,
          );
        }).toList();
      }
    } catch (e) {
      // Error handling
    }
    return [];
  }
}
