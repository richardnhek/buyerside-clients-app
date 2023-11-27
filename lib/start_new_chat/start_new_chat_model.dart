import '/backend/backend.dart';
import '/components/default_empty_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'start_new_chat_widget.dart' show StartNewChatWidget;
import 'package:flutter/material.dart';

class StartNewChatModel extends FlutterFlowModel<StartNewChatWidget> {
  ///  Local state fields for this page.

  bool isLoaded = false;

  List<DocumentReference> unrelatedUserList = [];
  void addToUnrelatedUserList(DocumentReference item) =>
      unrelatedUserList.add(item);
  void removeFromUnrelatedUserList(DocumentReference item) =>
      unrelatedUserList.remove(item);
  void removeAtIndexFromUnrelatedUserList(int index) =>
      unrelatedUserList.removeAt(index);
  void insertAtIndexInUnrelatedUserList(int index, DocumentReference item) =>
      unrelatedUserList.insert(index, item);
  void updateUnrelatedUserListAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      unrelatedUserList[index] = updateFn(unrelatedUserList[index]);

  List<DocumentReference> selectedUserRefs = [];
  void addToSelectedUserRefs(DocumentReference item) =>
      selectedUserRefs.add(item);
  void removeFromSelectedUserRefs(DocumentReference item) =>
      selectedUserRefs.remove(item);
  void removeAtIndexFromSelectedUserRefs(int index) =>
      selectedUserRefs.removeAt(index);
  void insertAtIndexInSelectedUserRefs(int index, DocumentReference item) =>
      selectedUserRefs.insert(index, item);
  void updateSelectedUserRefsAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      selectedUserRefs[index] = updateFn(selectedUserRefs[index]);

  bool isUserSelected = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in StartNewChat widget.
  WorkspacesRecord? userWorkspace;
  // Stores action output result for [Firestore Query - Query a collection] action in StartNewChat widget.
  List<ChatsRecord>? allRelatedChats;
  // Stores action output result for [Backend Call - Create Document] action in Container widget.
  ChatsRecord? createdChatDoc;
  // Model for DefaultEmptyComponent component.
  late DefaultEmptyComponentModel defaultEmptyComponentModel;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    defaultEmptyComponentModel =
        createModel(context, () => DefaultEmptyComponentModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    defaultEmptyComponentModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
