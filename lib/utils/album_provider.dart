import 'package:album_manager/models/album.dart';
import 'package:flutter/material.dart';

class AlbumProvider extends ChangeNotifier {
  Album? _selectedAlbum;

  Album? get selectedAlbum => _selectedAlbum;

  void setSelectedAlbum(Album album) {
    _selectedAlbum = album;
    notifyListeners();
  }
}
