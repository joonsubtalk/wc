import 'package:scoped_model/scoped_model.dart';
import 'package:wc/utils/database_helper.dart';

class Request {
  int _id;
  DateTime _created;
  DateTime _lastEdited;
  DateTime _completed;
  String _content;
  int _prayCount;
  bool _isStarred;
  bool _isActive;

  Request(this._created, this._lastEdited, this._completed, this._content,
      this._prayCount, this._isStarred, this._isActive);

  @override
  String toString() {
    return _content;
  }
}

class RequestModel extends Model {
  List<Request> _requests = [];

  final dbHelper = DatabaseHelper.instance;

  List<Request> get requests => _requests;

  void addRequest(content, prayerId) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.requestCreated: DateTime.now().toIso8601String(),
      DatabaseHelper.requestLastEdited: null,
      DatabaseHelper.requestCompleted: null,
      DatabaseHelper.requestContent: content,
      DatabaseHelper.requestPrayCount: 0,
      DatabaseHelper.requestIsStarred: 0,
      DatabaseHelper.requestIsActive: 0,
    };
    int id = await dbHelper.insert(DatabaseHelper.requestTable, row);

    Map<String, dynamic> lookup = {
      DatabaseHelper.lookupPrayerId: prayerId,
      DatabaseHelper.lookupRequestId: id,
    };
    await dbHelper.insert(DatabaseHelper.lookupTable, lookup);
  }

  void query(id) async {
    final allRows = await dbHelper.getResult(id);
    allRows.forEach((request) {
      print(request);
    });
  }
}
