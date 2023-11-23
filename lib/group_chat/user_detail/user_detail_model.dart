import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'user_detail_widget.dart' show UserDetailWidget;
import 'package:flutter/material.dart';

class UserDetailModel extends FlutterFlowModel<UserDetailWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<ChatsRecord>? relatedChatRefs;

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
