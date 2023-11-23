import '/flutter_flow/chat/index.dart';
import '/flutter_flow/form_field_controller.dart';
import 'add_user_to_chat_widget.dart' show AddUserToChatWidget;
import 'package:flutter/material.dart';

class AddUserToChatModel extends FlutterFlowModel<AddUserToChatWidget> {
  ///  Local state fields for this page.

  List<String> addedUsersUID = [];
  void addToAddedUsersUID(String item) => addedUsersUID.add(item);
  void removeFromAddedUsersUID(String item) => addedUsersUID.remove(item);
  void removeAtIndexFromAddedUsersUID(int index) =>
      addedUsersUID.removeAt(index);
  void insertAtIndexInAddedUsersUID(int index, String item) =>
      addedUsersUID.insert(index, item);
  void updateAddedUsersUIDAtIndex(int index, Function(String) updateFn) =>
      addedUsersUID[index] = updateFn(addedUsersUID[index]);

  List<UsersRecord> availableUserDocs = [];
  void addToAvailableUserDocs(UsersRecord item) => availableUserDocs.add(item);
  void removeFromAvailableUserDocs(UsersRecord item) =>
      availableUserDocs.remove(item);
  void removeAtIndexFromAvailableUserDocs(int index) =>
      availableUserDocs.removeAt(index);
  void insertAtIndexInAvailableUserDocs(int index, UsersRecord item) =>
      availableUserDocs.insert(index, item);
  void updateAvailableUserDocsAtIndex(
          int index, Function(UsersRecord) updateFn) =>
      availableUserDocs[index] = updateFn(availableUserDocs[index]);

  bool isLoaded = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in AddUserToChat widget.
  ChatsRecord? currentChatRef;
  // Stores action output result for [Firestore Query - Query a collection] action in AddUserToChat widget.
  List<UsersRecord>? availableUsers;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  UsersRecord? removedUserDoc;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Firestore Query - Query a collection] action in DropDown widget.
  UsersRecord? selectedUserDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  ChatsRecord? specificChatDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<UsersRecord>? addedUserDocList;
  // Stores action output result for [Group Chat Action] action in Button widget.
  ChatsRecord? groupChat;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
