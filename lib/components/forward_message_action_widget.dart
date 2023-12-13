import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/channel_button_widget.dart';
import '/components/empty_chat_widget_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'forward_message_action_model.dart';
export 'forward_message_action_model.dart';

class ForwardMessageActionWidget extends StatefulWidget {
  const ForwardMessageActionWidget({
    Key? key,
    required this.forwardMessageRef,
  }) : super(key: key);

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
      height: 350,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBtnText,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                  child: Container(
                    width: 75.0,
                    decoration: const BoxDecoration(),
                    child: Align(
                      alignment: const AlignmentDirectional(0.00, 0.00),
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
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    fontSize: 16.0,
                                    lineHeight: 1.2,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  'Forward Message',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        lineHeight: 1.5,
                      ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                  child: Container(
                    width: 75.0,
                    decoration: const BoxDecoration(),
                    child: Visibility(
                      visible: (FFAppState().forwardToRef != null) &&
                          (_model.textController.text != ''),
                      child: Align(
                        alignment: const AlignmentDirectional(0.00, 0.00),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.forwardMessageDoc =
                                await ChatMessagesRecord.getDocumentOnce(
                                    widget.forwardMessageRef!);
                            _model.fwdUserDoc = await queryUsersRecordOnce(
                              queryBuilder: (usersRecord) => usersRecord.where(
                                'user_ref',
                                isEqualTo: _model.forwardMessageDoc?.user,
                              ),
                              singleRecord: true,
                            ).then((s) => s.firstOrNull);

                            var chatMessagesRecordReference2 =
                                ChatMessagesRecord.collection.doc();
                            await chatMessagesRecordReference2
                                .set(createChatMessagesRecordData(
                              user: currentUserReference,
                              chat: FFAppState().forwardToRef,
                              text: functions.fullFwdMessage(
                                  'From ${_model.fwdUserDoc?.displayName} : ${_model.forwardMessageDoc?.text}',
                                  _model.textController.text),
                              timestamp: getCurrentTimestamp,
                              isForward: true,
                              fwdMessageRef: widget.forwardMessageRef,
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
                                      isForward: true,
                                      fwdMessageRef: widget.forwardMessageRef,
                                    ),
                                    chatMessagesRecordReference2);

                            await _model.createdFwdMessage!.reference
                                .update(createChatMessagesRecordData(
                              chatMessageRef:
                                  _model.createdFwdMessage?.reference,
                            ));
                            Navigator.pop(context);

                            context.goNamed('AllChats');

                            setState(() {});
                          },
                          child: Text(
                            'Send',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  fontSize: 16.0,
                                  lineHeight: 1.2,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 20,
            thickness: 1,
            color: FlutterFlowTheme.of(context).darkGrey3,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
            child: SizedBox(
              width: double.infinity,
              child: TextFormField(
                controller: _model.textController,
                focusNode: _model.textFieldFocusNode,
                onChanged: (_) => EasyDebounce.debounce(
                  '_model.textController',
                  const Duration(milliseconds: 100),
                  () => setState(() {}),
                ),
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
          ),
          Divider(
            height: 20,
            thickness: 1,
            color: FlutterFlowTheme.of(context).darkGrey3,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
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
                        width: 50,
                        height: 50,
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
                    return Center(
                      child: EmptyChatWidgetWidget(),
                    );
                  }
                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewChatsRecordList.length,
                    separatorBuilder: (_, __) => SizedBox(height: 5),
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
                                      width: 50,
                                      height: 50,
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
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Chat selected',
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                        duration:
                                            const Duration(milliseconds: 1000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            child: Image.network(
                                              containerUsersRecord.photoUrl,
                                              width: 25,
                                              height: 25,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 0, 0, 0),
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
                                                        fontSize: 16,
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
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Chat selected',
                                      style: GoogleFonts.getFont(
                                        'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryText,
                                  ),
                                );
                              },
                              child: ChannelButtonWidget(
                                key: Key(
                                    'Keyafj_${listViewIndex}_of_${listViewChatsRecordList.length}'),
                                channelName: listViewChatsRecord.channelName,
                                isRead: true,
                                isPinned: false,
                                lastMsg: listViewChatsRecord.lastMessage,
                                lastMsgTime:
                                    listViewChatsRecord.lastMessageTime!,
                                lastMsgSentBy:
                                    listViewChatsRecord.lastMessageSentBy!,
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
