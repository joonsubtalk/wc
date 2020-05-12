import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Category {
  final int _id;
  final String _title;
  final String _description;

  int get id => _id;
  String get title => _title;
  String get description => _description;

  Category(this._id, this._title, this._description);

  @override
  String toString() {
    return '${this._id} ${this._title} ${this._description}';
  }
}

final CATEGORY_LIST = [
  Category(0, 'Praise', 'God\'s attribute'),
  Category(1, 'Confession', 'Confessing of sins'),
  Category(2, 'Give Thanks', 'Thanking God'),
  Category(3, 'Petition', 'For my own life'),
  Category(4, 'Intercession', 'For other\'s life'),
  Category(5, 'Missions', 'For missionaries'),
  Category(6, 'Church', 'Ministries involved'),
  Category(7, 'Evangelism', 'Opportunities'),
  Category(8, 'Family', 'Pray for your family'),
  Category(9, 'Meditating', 'Focus on a passage'),
  Category(10, 'Scripture', 'Focused meditation'),
  Category(11, 'Song/Hymn', 'Pray through hymns'),
];
