import 'dart:convert';
import 'package:album_manager/models/album.dart';
import 'package:album_manager/models/photo.dart';
import 'package:album_manager/models/user.dart';
import 'package:http/http.dart' as http;

class NetworkManager {
  Future<List<Album>> getAlbums() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Album.fromJson(data)).toList();
    } else {
      throw Exception('Errore: ${response.statusCode}');
    }
  }

  Future<List<Album>> getAlbumsByUser(int userId) async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<Album> albums = jsonResponse.map((data) => Album.fromJson(data)).toList();
      return albums.where((album) => album.userId == userId).toList();
    } else {
      throw Exception('Errore: ${response.statusCode}');
    }
  }

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => User.fromJson(data)).toList();
    } else {
      throw Exception('Errore: ${response.statusCode}');
    }
  }

  Future<User> getUserById(int id) async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/$id'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Errore: ${response.statusCode}');
    }
  }

  Future<List<Photo>> getAlbumPhotos(int albumId) async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<Photo> photos = jsonResponse.map((data) => Photo.fromJson(data)).toList();
      return photos.where((photo) => photo.albumId == albumId).toList();
    } else {
      throw Exception('Errore: ${response.statusCode}');
    }
  }
}
