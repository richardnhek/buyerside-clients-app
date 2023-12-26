import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'direct_message_button_model.dart';
export 'direct_message_button_model.dart';

class DirectMessageButtonWidget extends StatefulWidget {
  const DirectMessageButtonWidget({
    super.key,
    required this.userRef,
  });

  final DocumentReference? userRef;

  @override
  _DirectMessageButtonWidgetState createState() =>
      _DirectMessageButtonWidgetState();
}

class _DirectMessageButtonWidgetState extends State<DirectMessageButtonWidget> {
  late DirectMessageButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DirectMessageButtonModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<List<UsersRecord>>(
      future: queryUsersRecordOnce(
        queryBuilder: (usersRecord) => usersRecord.where(
          'user_ref',
          isEqualTo: widget.userRef,
        ),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  FlutterFlowTheme.of(context).primary,
                ),
              ),
            ),
          );
        }
        List<UsersRecord> containerUsersRecordList =
            snapshot.data!.where((u) => u.uid != currentUserUid).toList();
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final containerUsersRecord = containerUsersRecordList.isNotEmpty
            ? containerUsersRecordList.first
            : null;
        return Container(
          width: double.infinity,
          height: 40.0,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(3.0),
                  child: Image.network(
                    containerUsersRecord!.photoUrl,
                    width: 25.0,
                    height: 25.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                    child: Text(
                      containerUsersRecord.displayName.maybeHandleOverflow(
                        maxChars: 18,
                        replacement: '…',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
