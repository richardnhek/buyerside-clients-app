import '/flutter_flow/flutter_flow_util.dart';
import 'all_chats_widget.dart' show AllChatsWidget;
import 'package:expandable/expandable.dart';
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

  ///  State fields for stateful widgets in this page.

  // State field(s) for Expandable widget.
  late ExpandableController expandableController1;

  // State field(s) for Expandable widget.
  late ExpandableController expandableController2;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    expandableController1.dispose();
    expandableController2.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
