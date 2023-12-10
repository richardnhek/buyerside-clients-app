import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'all_chats_widget.dart' show AllChatsWidget;
import 'package:flutter/material.dart';

class AllChatsModel extends FlutterFlowModel<AllChatsWidget> {
  ///  Local state fields for this page.

  List<DocumentReference> allDMUserRefs = [];
  void addToAllDMUserRefs(DocumentReference item) => allDMUserRefs.add(item);
  void removeFromAllDMUserRefs(DocumentReference item) =>
      allDMUserRefs.remove(item);
  void removeAtIndexFromAllDMUserRefs(int index) =>
      allDMUserRefs.removeAt(index);
  void insertAtIndexInAllDMUserRefs(int index, DocumentReference item) =>
      allDMUserRefs.insert(index, item);
  void updateAllDMUserRefsAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      allDMUserRefs[index] = updateFn(allDMUserRefs[index]);

  DocumentReference? pinnedChatRef;

  List<DocumentReference> allChatRefs = [];
  void addToAllChatRefs(DocumentReference item) => allChatRefs.add(item);
  void removeFromAllChatRefs(DocumentReference item) =>
      allChatRefs.remove(item);
  void removeAtIndexFromAllChatRefs(int index) => allChatRefs.removeAt(index);
  void insertAtIndexInAllChatRefs(int index, DocumentReference item) =>
      allChatRefs.insert(index, item);
  void updateAllChatRefsAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      allChatRefs[index] = updateFn(allChatRefs[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in AllChats widget.
  List<ChatsRecord>? allUserChats;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
