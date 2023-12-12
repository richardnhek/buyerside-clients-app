import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'forward_message_action_widget.dart' show ForwardMessageActionWidget;
import 'package:flutter/material.dart';

class ForwardMessageActionModel
    extends FlutterFlowModel<ForwardMessageActionWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in Text widget.
  ChatMessagesRecord? forwardMessageDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in Text widget.
  UsersRecord? fwdUserDoc;
  // Stores action output result for [Backend Call - Create Document] action in Text widget.
  ChatMessagesRecord? createdFwdMessage;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
