import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _totalMl = prefs.getDouble('ff_totalMl') ?? _totalMl;
    });
    _safeInit(() {
      _lastDrinkTimeStampMs =
          prefs.getInt('ff_lastDrinkTimeStampMs') ?? _lastDrinkTimeStampMs;
    });
    _safeInit(() {
      _currentBAC = prefs.getDouble('ff_currentBAC') ?? _currentBAC;
    });
    _safeInit(() {
      _bacRatio = prefs.getDouble('ff_bacRatio') ?? _bacRatio;
    });
    _safeInit(() {
      _ratioMl = prefs.getDouble('ff_ratioMl') ?? _ratioMl;
    });
    _safeInit(() {
      _weightLbs = prefs.getInt('ff_weightLbs') ?? _weightLbs;
    });
    _safeInit(() {
      _sex = prefs.getString('ff_sex') ?? _sex;
    });
    _safeInit(() {
      _bacLimit = prefs.getDouble('ff_bacLimit') ?? _bacLimit;
    });
    _safeInit(() {
      _volumeLimit = prefs.getDouble('ff_volumeLimit') ?? _volumeLimit;
    });
    _safeInit(() {
      _units = prefs.getString('ff_units') ?? _units;
    });
    _safeInit(() {
      _drinkEvents = prefs
              .getStringList('ff_drinkEvents')
              ?.map((x) {
                try {
                  return DrinkEventStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _drinkEvents;
    });
    _safeInit(() {
      _currentBACGuest =
          prefs.getDouble('ff_currentBACGuest') ?? _currentBACGuest;
    });
    _safeInit(() {
      _darkMode = prefs.getBool('ff_darkMode') ?? _darkMode;
    });
    _safeInit(() {
      _guestId = prefs.getString('ff_guestId') ?? _guestId;
    });
    _safeInit(() {
      _guestCreatedAtMs =
          prefs.getInt('ff_guestCreatedAtMs') ?? _guestCreatedAtMs;
    });
    _safeInit(() {
      _guestDailyLogs =
          prefs.getStringList('ff_guestDailyLogs') ?? _guestDailyLogs;
    });
    _safeInit(() {
      _notifOn = prefs.getBool('ff_notifOn') ?? _notifOn;
    });
    _safeInit(() {
      _listOfNumberStrings =
          prefs.getStringList('ff_listOfNumberStrings') ?? _listOfNumberStrings;
    });
    _safeInit(() {
      _isGuest = prefs.getBool('ff_isGuest') ?? _isGuest;
    });
    _safeInit(() {
      _subscribed = prefs.getBool('ff_subscribed') ?? _subscribed;
    });
    _safeInit(() {
      _limitType = prefs.getString('ff_limitType') ?? _limitType;
    });
    _safeInit(() {
      _totalCost = prefs.getDouble('ff_totalCost') ?? _totalCost;
    });
    _safeInit(() {
      _totalCalories = prefs.getInt('ff_totalCalories') ?? _totalCalories;
    });
    _safeInit(() {
      _email = prefs.getString('ff_email') ?? _email;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  double _totalMl = 0.0;
  double get totalMl => _totalMl;
  set totalMl(double value) {
    _totalMl = value;
    prefs.setDouble('ff_totalMl', value);
  }

  int _lastDrinkTimeStampMs = 0;
  int get lastDrinkTimeStampMs => _lastDrinkTimeStampMs;
  set lastDrinkTimeStampMs(int value) {
    _lastDrinkTimeStampMs = value;
    prefs.setInt('ff_lastDrinkTimeStampMs', value);
  }

  double _currentBAC = 0.0;
  double get currentBAC => _currentBAC;
  set currentBAC(double value) {
    _currentBAC = value;
    prefs.setDouble('ff_currentBAC', value);
  }

  double _bacRatio = 0.0;
  double get bacRatio => _bacRatio;
  set bacRatio(double value) {
    _bacRatio = value;
    prefs.setDouble('ff_bacRatio', value);
  }

  double _ratioMl = 0.0;
  double get ratioMl => _ratioMl;
  set ratioMl(double value) {
    _ratioMl = value;
    prefs.setDouble('ff_ratioMl', value);
  }

  bool _backgroundBlur = false;
  bool get backgroundBlur => _backgroundBlur;
  set backgroundBlur(bool value) {
    _backgroundBlur = value;
  }

  /// guest weight
  int _weightLbs = 0;
  int get weightLbs => _weightLbs;
  set weightLbs(int value) {
    _weightLbs = value;
    prefs.setInt('ff_weightLbs', value);
  }

  /// guest gender
  String _sex = '';
  String get sex => _sex;
  set sex(String value) {
    _sex = value;
    prefs.setString('ff_sex', value);
  }

  double _bacLimit = 0.0;
  double get bacLimit => _bacLimit;
  set bacLimit(double value) {
    _bacLimit = value;
    prefs.setDouble('ff_bacLimit', value);
  }

  double _volumeLimit = 0.0;
  double get volumeLimit => _volumeLimit;
  set volumeLimit(double value) {
    _volumeLimit = value;
    prefs.setDouble('ff_volumeLimit', value);
  }

  String _units = '';
  String get units => _units;
  set units(String value) {
    _units = value;
    prefs.setString('ff_units', value);
  }

  List<DrinkEventStruct> _drinkEvents = [];
  List<DrinkEventStruct> get drinkEvents => _drinkEvents;
  set drinkEvents(List<DrinkEventStruct> value) {
    _drinkEvents = value;
    prefs.setStringList(
        'ff_drinkEvents', value.map((x) => x.serialize()).toList());
  }

  void addToDrinkEvents(DrinkEventStruct value) {
    drinkEvents.add(value);
    prefs.setStringList(
        'ff_drinkEvents', _drinkEvents.map((x) => x.serialize()).toList());
  }

  void removeFromDrinkEvents(DrinkEventStruct value) {
    drinkEvents.remove(value);
    prefs.setStringList(
        'ff_drinkEvents', _drinkEvents.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromDrinkEvents(int index) {
    drinkEvents.removeAt(index);
    prefs.setStringList(
        'ff_drinkEvents', _drinkEvents.map((x) => x.serialize()).toList());
  }

  void updateDrinkEventsAtIndex(
    int index,
    DrinkEventStruct Function(DrinkEventStruct) updateFn,
  ) {
    drinkEvents[index] = updateFn(_drinkEvents[index]);
    prefs.setStringList(
        'ff_drinkEvents', _drinkEvents.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInDrinkEvents(int index, DrinkEventStruct value) {
    drinkEvents.insert(index, value);
    prefs.setStringList(
        'ff_drinkEvents', _drinkEvents.map((x) => x.serialize()).toList());
  }

  double _currentBACGuest = 0.0;
  double get currentBACGuest => _currentBACGuest;
  set currentBACGuest(double value) {
    _currentBACGuest = value;
    prefs.setDouble('ff_currentBACGuest', value);
  }

  bool _darkMode = false;
  bool get darkMode => _darkMode;
  set darkMode(bool value) {
    _darkMode = value;
    prefs.setBool('ff_darkMode', value);
  }

  int _volumeLimitFromString = 0;
  int get volumeLimitFromString => _volumeLimitFromString;
  set volumeLimitFromString(int value) {
    _volumeLimitFromString = value;
  }

  String _guestId = '';
  String get guestId => _guestId;
  set guestId(String value) {
    _guestId = value;
    prefs.setString('ff_guestId', value);
  }

  int _guestCreatedAtMs = 0;
  int get guestCreatedAtMs => _guestCreatedAtMs;
  set guestCreatedAtMs(int value) {
    _guestCreatedAtMs = value;
    prefs.setInt('ff_guestCreatedAtMs', value);
  }

  List<String> _guestDailyLogs = [];
  List<String> get guestDailyLogs => _guestDailyLogs;
  set guestDailyLogs(List<String> value) {
    _guestDailyLogs = value;
    prefs.setStringList('ff_guestDailyLogs', value);
  }

  void addToGuestDailyLogs(String value) {
    guestDailyLogs.add(value);
    prefs.setStringList('ff_guestDailyLogs', _guestDailyLogs);
  }

  void removeFromGuestDailyLogs(String value) {
    guestDailyLogs.remove(value);
    prefs.setStringList('ff_guestDailyLogs', _guestDailyLogs);
  }

  void removeAtIndexFromGuestDailyLogs(int index) {
    guestDailyLogs.removeAt(index);
    prefs.setStringList('ff_guestDailyLogs', _guestDailyLogs);
  }

  void updateGuestDailyLogsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    guestDailyLogs[index] = updateFn(_guestDailyLogs[index]);
    prefs.setStringList('ff_guestDailyLogs', _guestDailyLogs);
  }

  void insertAtIndexInGuestDailyLogs(int index, String value) {
    guestDailyLogs.insert(index, value);
    prefs.setStringList('ff_guestDailyLogs', _guestDailyLogs);
  }

  bool _notifOn = false;
  bool get notifOn => _notifOn;
  set notifOn(bool value) {
    _notifOn = value;
    prefs.setBool('ff_notifOn', value);
  }

  List<String> _listOfNumberStrings = [];
  List<String> get listOfNumberStrings => _listOfNumberStrings;
  set listOfNumberStrings(List<String> value) {
    _listOfNumberStrings = value;
    prefs.setStringList('ff_listOfNumberStrings', value);
  }

  void addToListOfNumberStrings(String value) {
    listOfNumberStrings.add(value);
    prefs.setStringList('ff_listOfNumberStrings', _listOfNumberStrings);
  }

  void removeFromListOfNumberStrings(String value) {
    listOfNumberStrings.remove(value);
    prefs.setStringList('ff_listOfNumberStrings', _listOfNumberStrings);
  }

  void removeAtIndexFromListOfNumberStrings(int index) {
    listOfNumberStrings.removeAt(index);
    prefs.setStringList('ff_listOfNumberStrings', _listOfNumberStrings);
  }

  void updateListOfNumberStringsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    listOfNumberStrings[index] = updateFn(_listOfNumberStrings[index]);
    prefs.setStringList('ff_listOfNumberStrings', _listOfNumberStrings);
  }

  void insertAtIndexInListOfNumberStrings(int index, String value) {
    listOfNumberStrings.insert(index, value);
    prefs.setStringList('ff_listOfNumberStrings', _listOfNumberStrings);
  }

  List<double> _listOfPrices = [];
  List<double> get listOfPrices => _listOfPrices;
  set listOfPrices(List<double> value) {
    _listOfPrices = value;
  }

  void addToListOfPrices(double value) {
    listOfPrices.add(value);
  }

  void removeFromListOfPrices(double value) {
    listOfPrices.remove(value);
  }

  void removeAtIndexFromListOfPrices(int index) {
    listOfPrices.removeAt(index);
  }

  void updateListOfPricesAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    listOfPrices[index] = updateFn(_listOfPrices[index]);
  }

  void insertAtIndexInListOfPrices(int index, double value) {
    listOfPrices.insert(index, value);
  }

  bool _tookPicture = false;
  bool get tookPicture => _tookPicture;
  set tookPicture(bool value) {
    _tookPicture = value;
  }

  bool _isThinking = false;
  bool get isThinking => _isThinking;
  set isThinking(bool value) {
    _isThinking = value;
  }

  String _drinkSizeType = '';
  String get drinkSizeType => _drinkSizeType;
  set drinkSizeType(String value) {
    _drinkSizeType = value;
  }

  double _totalMl2 = 0.0;
  double get totalMl2 => _totalMl2;
  set totalMl2(double value) {
    _totalMl2 = value;
  }

  bool _isGuest = false;
  bool get isGuest => _isGuest;
  set isGuest(bool value) {
    _isGuest = value;
    prefs.setBool('ff_isGuest', value);
  }

  bool _subscribed = false;
  bool get subscribed => _subscribed;
  set subscribed(bool value) {
    _subscribed = value;
    prefs.setBool('ff_subscribed', value);
  }

  String _limitType = '';
  String get limitType => _limitType;
  set limitType(String value) {
    _limitType = value;
    prefs.setString('ff_limitType', value);
  }

  double _totalCost = 0.0;
  double get totalCost => _totalCost;
  set totalCost(double value) {
    _totalCost = value;
    prefs.setDouble('ff_totalCost', value);
  }

  int _totalCalories = 0;
  int get totalCalories => _totalCalories;
  set totalCalories(int value) {
    _totalCalories = value;
    prefs.setInt('ff_totalCalories', value);
  }

  String _email = '';
  String get email => _email;
  set email(String value) {
    _email = value;
    prefs.setString('ff_email', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
