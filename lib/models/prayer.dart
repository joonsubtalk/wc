import 'package:scoped_model/scoped_model.dart';
import 'package:wc/utils/database_helper.dart';
import './category.dart';
import './request.dart';

class Prayer {
  int _id;
  String _title = '';
  Category _category;
  List<Request> _requests = [];

  Prayer(this._id, this._title, this._category);

  int get id => _id;
  String get title => _title;
  List<Request> get requests => _requests;
  String get category => _category.toString();

  void setTitle(String title) {
    this._title = title;
  }

  void setRequest(requests) {
    this._requests.add(requests);
  }

  void setId(int id) {
    this._id = id;
  }

  @override
  String toString() {
    return _title + '::' + _category.toString();
  }
}

class PrayerModel extends Model {
  List<Prayer> _prayers = [];

  String _title = '';
  Category _category;

  List<Prayer> get prayers => _prayers;

  String get title => _title;

  Category get category => _category;

  final dbHelper = DatabaseHelper.instance;

  void setCategory(Category category) {
    this._category = category;
    notifyListeners();
  }

  void setTitle(String title) {
    this._title = title;
    notifyListeners();
  }

  void clearPrayers() {
    this._prayers.clear();
    notifyListeners();
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows(DatabaseHelper.prayerTable);
    print('queried!');
    allRows.forEach((prayer) {
      print(prayer);
      add(Prayer(
          prayer['_id'], prayer['title'], CATEGORY_LIST[prayer['category']]));
      getRequests(prayer['_id']);
    });
    notifyListeners();
  }

  void getRequests(prayerId) async {
    List<Map<String, dynamic>> requests = await dbHelper.getResult(prayerId);
    print('>>> $requests $prayerId');
    requests.forEach(
      (request) => {
        _prayers[prayerId - 1].setRequest(Request(
            DateTime.tryParse(request['created']),
            request['lastEdited'] != null
                ? DateTime.tryParse(request['lastEdited'])
                : null,
            request['completed'] != null
                ? DateTime.tryParse(request['completed'])
                : null,
            request['content'],
            request['prayCount'],
            request['isStarred'] == 0 ? false : true,
            request['isActive'] == 0 ? false : true))
      },
    );
    notifyListeners();
  }

  void addRequest(content, prayerId) async {
    String dateTime = DateTime.now().toIso8601String();
    Map<String, dynamic> row = {
      DatabaseHelper.requestCreated: dateTime,
      DatabaseHelper.requestLastEdited: null,
      DatabaseHelper.requestCompleted: null,
      DatabaseHelper.requestContent: content,
      DatabaseHelper.requestPrayCount: 0,
      DatabaseHelper.requestIsStarred: 0,
      DatabaseHelper.requestIsActive: 0,
    };

    int reqId = await dbHelper.insert(DatabaseHelper.requestTable, row);

    Map<String, dynamic> lookup = {
      DatabaseHelper.lookupPrayerId: prayerId,
      DatabaseHelper.lookupRequestId: reqId,
    };

    int lookId = await dbHelper.insert(DatabaseHelper.lookupTable, lookup);

    // List<Map<String, dynamic>> request = await dbHelper.getResult(prayerId);

    // Request req = Request(this._created, this._lastEdited, this._completed,
    //     this._content, this._prayCount, this._isStarred, this._isActive);

    // selects the prayer
    _prayers[prayerId - 1].setRequest(Request(
        DateTime.parse(dateTime),
        DateTime.parse(dateTime),
        DateTime.parse(dateTime),
        content,
        0,
        false,
        false));

    print(_prayers[prayerId - 1]);
    notifyListeners();
  }

  // Future<List<Request>> queryRequest(int prayerId) async {
  //   final allRows = await dbHelper.getResult(prayerId);
  //   return allRows;
  //   // print('allRows: $allRows');
  // }

  void deletePrayers() async {
    this._prayers.clear();
    await dbHelper.reset(DatabaseHelper.prayerTable);
    notifyListeners();
  }

  void init() {
    clearPrayers();
    _query();
    notifyListeners();
  }

  PrayerModel() {
    init();
  }

  List<Prayer> getPrayer() {
    return _prayers;
  }

  void add(prayer) {
    _prayers.add(prayer);

    notifyListeners();
  }

  @override
  String toString() {
    return _prayers[0].toString();
  }
}
