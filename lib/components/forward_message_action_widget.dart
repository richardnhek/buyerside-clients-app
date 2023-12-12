import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/channel_button_widget.dart';
import '/components/empty_chat_widget_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'forward_message_action_model.dart';
export 'forward_message_action_model.dart';

class ForwardMessageActionWidget extends StatefulWidget {
  const ForwardMessageActionWidget({
    super.key,
    required this.forwardMessageRef,
  });

  final DocumentReference? forwardMessageRef;

  @override
  _ForwardMessageActionWidgetState createState() =>
      _ForwardMessageActionWidgetState();
}

class _ForwardMessageActionWidgetState
    extends State<ForwardMessageActionWidget> {
  late ForwardMessageActionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ForwardMessageActionModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: 350.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBtnText,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            fontSize: 16.0,
                            lineHeight: 1.2,
                          ),
                    ),
                  ),
                ),
                Text(
                  'Forward Message',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                        lineHeight: 1.5,
                      ),
                ),
                if ((FFAppState().forwardToRef != null) &&
                    (_model.textController.text != ''))
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        _model.forwardMessageDoc =
                            await queryChatMessagesRecordOnce(
                          queryBuilder: (chatMessagesRecord) =>
                              chatMessagesRecord.where(
                            'chat_message_ref',
                            isEqualTo: widget.forwardMessageRef,
                          ),
                          singleRecord: true,
                        ).then((s) => s.firstOrNull);
                        _model.fwdUserDoc = await queryUsersRecordOnce(
                          queryBuilder: (usersRecord) => usersRecord.where(
                            'user_ref',
                            isEqualTo: _model.forwardMessageDoc?.user,
                          ),
                          singleRecord: true,
                        ).then((s) => s.firstOrNull);

                        var chatMessagesRecordReference =
                            ChatMessagesRecord.collection.doc();
                        await chatMessagesRecordReference
                            .set(createChatMessagesRecordData(
                          user: currentUserReference,
                          chat: FFAppState().forwardToRef,
                          text: functions.fullFwdMessage(
                              'From ${_model.fwdUserDoc?.displayName} : ${_model.forwardMessageDoc?.text}',
                              _model.textController.text),
                          timestamp: getCurrentTimestamp,
                        ));
                        _model.createdFwdMessage =
                            ChatMessagesRecord.getDocumentFromData(
                                createChatMessagesRecordData(
                                  user: currentUserReference,
                                  chat: FFAppState().forwardToRef,
                                  text: functions.fullFwdMessage(
                                      'From ${_model.fwdUserDoc?.displayName} : ${_model.forwardMessageDoc?.text}',
                                      _model.textController.text),
                                  timestamp: getCurrentTimestamp,
                                ),
                                chatMessagesRecordReference);

                        await _model.createdFwdMessage!.reference
                            .update(createChatMessagesRecordData(
                          chatMessageRef: _model.createdFwdMessage?.reference,
                        ));

                        setState(() {});
                      },
                      child: Text(
                        'Send',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              fontSize: 16.0,
                              lineHeight: 1.2,
                            ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Divider(
            height: 20.0,
            thickness: 1.0,
            color: FlutterFlowTheme.of(context).darkGrey3,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
            child: TextFormField(
              controller: _model.textController,
              focusNode: _model.textFieldFocusNode,
              autofocus: true,
              obscureText: false,
              decoration: InputDecoration(
                labelStyle: FlutterFlowTheme.of(context).labelMedium,
                hintText: 'Type a message here, if you’d like',
                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Inter',
                      color: FlutterFlowTheme.of(context).darkGrey2,
                    ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
              style: FlutterFlowTheme.of(context).bodyMedium,
              validator: _model.textControllerValidator.asValidator(context),
            ),
          ),
          Divider(
            height: 20.0,
            thickness: 1.0,
            color: FlutterFlowTheme.of(context).darkGrey3,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
              child: FutureBuilder<List<ChatsRecord>>(
                future: queryChatsRecordOnce(
                  queryBuilder: (chatsRecord) => chatsRecord
                      .where(
                        'users',
                        arrayContains: currentUserReference,
                      )
                      .orderBy('last_message_time', descending: true),
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
                  List<ChatsRecord> listViewChatsRecordList = snapshot.data!;
                  if (listViewChatsRecordList.isEmpty) {
                    return const Center(
                      child: EmptyChatWidgetWidget(),
                    );
                  }
                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewChatsRecordList.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 5.0),
                    itemBuilder: (context, listViewIndex) {
                      final listViewChatsRecord =
                          listViewChatsRecordList[listViewIndex];
                      return Builder(
                        builder: (context) {
                          if (listViewChatsRecord.chatType == 'DM') {
                            return FutureBuilder<UsersRecord>(
                              future: UsersRecord.getDocumentOnce(
                                  listViewChatsRecord.users
                                      .where((e) => e != currentUserReference)
                                      .toList()
                                      .first),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                final containerUsersRecord = snapshot.data!;
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    FFAppState().update(() {
                                      FFAppState().forwardToRef =
                                          listViewChatsRecord.reference;
                                    });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 40.0,
                                    decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 30.0,
                                          height: 30.0,
                                          decoration: const BoxDecoration(),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(3.0),
                                            child: Image.network(
                                              containerUsersRecord.photoUrl,
                                              width: 25.0,
                                              height: 25.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              containerUsersRecord.displayName
                                                  .maybeHandleOverflow(
                                                maxChars: 18,
                                                replacement: '…',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.normal,
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
                          } else {
                            return InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                FFAppState().update(() {
                                  FFAppState().forwardToRef =
                                      listViewChatsRecord.reference;
                                });
                              },
                              child: ChannelButtonWidget(
                                key: Key(
                                    'Keyafj_${listViewIndex}_of_${listViewChatsRecordList.length}'),
                                channelName: listViewChatsRecord.channelName,
                                isRead: true,
                                isPinned: false,
                              ),
                            );
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
