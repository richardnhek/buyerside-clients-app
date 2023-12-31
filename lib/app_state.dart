import 'package:flutter/material.dart';
import '/backend/backend.dart';
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

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  DocumentReference? _currentChatRef;
  DocumentReference? get currentChatRef => _currentChatRef;
  set currentChatRef(DocumentReference? value) {
    _currentChatRef = value;
  }

  DocumentReference? _currentChatUserRef;
  DocumentReference? get currentChatUserRef => _currentChatUserRef;
  set currentChatUserRef(DocumentReference? value) {
    _currentChatUserRef = value;
  }

  String _currentMainView = '';
  String get currentMainView => _currentMainView;
  set currentMainView(String value) {
    _currentMainView = value;
  }

  DocumentReference? _selectedMembers;
  DocumentReference? get selectedMembers => _selectedMembers;
  set selectedMembers(DocumentReference? value) {
    _selectedMembers = value;
  }

  String _mainNavView = '';
  String get mainNavView => _mainNavView;
  set mainNavView(String value) {
    _mainNavView = value;
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
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
