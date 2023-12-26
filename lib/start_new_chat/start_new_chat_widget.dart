import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/default_empty_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'start_new_chat_model.dart';
export 'start_new_chat_model.dart';

class StartNewChatWidget extends StatefulWidget {
  const StartNewChatWidget({super.key});

  @override
  _StartNewChatWidgetState createState() => _StartNewChatWidgetState();
}

class _StartNewChatWidgetState extends State<StartNewChatWidget> {
  late StartNewChatModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StartNewChatModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.selectedUserRefs = [];
        _model.unrelatedUserList = [];
      });
      setState(() {
        _model.isLoaded = false;
        _model.addToSelectedUserRefs(currentUserReference!);
      });
      _model.userWorkspace = await queryWorkspacesRecordOnce(
        queryBuilder: (workspacesRecord) => workspacesRecord.where(
          'members',
          arrayContains: currentUserReference,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      _model.allRelatedChats = await queryChatsRecordOnce(
        queryBuilder: (chatsRecord) => chatsRecord
            .where(
              'users',
              arrayContains: currentUserReference,
            )
            .where(
              'chat_type',
              isEqualTo: 'DM',
            ),
      );
      setState(() {
        _model.unrelatedUserList = functions
            .getListOfUnrelatedUsers(_model.userWorkspace!.members.toList(),
                _model.allRelatedChats!.toList())!
            .toList()
            .cast<DocumentReference>();
      });
      setState(() {
        _model.isLoaded = true;
      });
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: Align(
            alignment: const AlignmentDirectional(-1.0, 1.0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: Icon(
                Icons.chevron_left_outlined,
                color: FlutterFlowTheme.of(context).darkGrey,
                size: 25.0,
              ),
              onPressed: () async {
                context.safePop();
              },
            ),
          ),
          actions: const [],
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Start new chat',
              textAlign: TextAlign.start,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Inter',
                    fontSize: 17.0,
                  ),
            ),
            centerTitle: false,
            expandedTitleScale: 1.0,
          ),
          toolbarHeight: 75.0,
          elevation: 1.0,
        ),
        body: Builder(
          builder: (context) {
            if (_model.isLoaded == true) {
              return Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          if (_model.unrelatedUserList.isNotEmpty) {
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5.0, 25.0, 5.0, 0.0),
                                  child: FutureBuilder<List<UsersRecord>>(
                                    future: queryUsersRecordOnce(
                                      queryBuilder: (usersRecord) =>
                                          usersRecord.whereIn('user_ref',
                                              _model.unrelatedUserList),
                                    ),
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
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      List<UsersRecord>
                                          listViewUsersRecordList = snapshot
                                              .data!
                                              .where((u) =>
                                                  u.uid != currentUserUid)
                                              .toList();
                                      return ListView.separated(
                                        padding: EdgeInsets.zero,
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            listViewUsersRecordList.length,
                                        separatorBuilder: (_, __) =>
                                            const SizedBox(height: 2.5),
                                        itemBuilder: (context, listViewIndex) {
                                          final listViewUsersRecord =
                                              listViewUsersRecordList[
                                                  listViewIndex];
                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              setState(() {
                                                _model.isUserSelected = true;
                                              });
                                              setState(() {
                                                _model.addToSelectedUserRefs(
                                                    listViewUsersRecord
                                                        .reference);
                                              });

                                              var chatsRecordReference =
                                                  ChatsRecord.collection.doc();
                                              await chatsRecordReference.set({
                                                ...createChatsRecordData(
                                                  userA: currentUserReference,
                                                  userB: listViewUsersRecord
                                                      .reference,
                                                  chatType: 'DM',
                                                  workspaceId:
                                                      _model.userWorkspace?.id,
                                                  workspaceRef: _model
                                                      .userWorkspace?.reference,
                                                  lastMessageTime:
                                                      getCurrentTimestamp,
                                                ),
                                                ...mapToFirestore(
                                                  {
                                                    'users':
                                                        _model.selectedUserRefs,
                                                  },
                                                ),
                                              });
                                              _model.createdChatDoc =
                                                  ChatsRecord
                                                      .getDocumentFromData({
                                                ...createChatsRecordData(
                                                  userA: currentUserReference,
                                                  userB: listViewUsersRecord
                                                      .reference,
                                                  chatType: 'DM',
                                                  workspaceId:
                                                      _model.userWorkspace?.id,
                                                  workspaceRef: _model
                                                      .userWorkspace?.reference,
                                                  lastMessageTime:
                                                      getCurrentTimestamp,
                                                ),
                                                ...mapToFirestore(
                                                  {
                                                    'users':
                                                        _model.selectedUserRefs,
                                                  },
                                                ),
                                              }, chatsRecordReference);

                                              await _model
                                                  .createdChatDoc!.reference
                                                  .update(createChatsRecordData(
                                                chatRef: _model
                                                    .createdChatDoc?.reference,
                                              ));
                                              if (Navigator.of(context)
                                                  .canPop()) {
                                                context.pop();
                                              }
                                              context.pushNamed(
                                                'ChatBox',
                                                queryParameters: {
                                                  'chatUser': serializeParam(
                                                    listViewUsersRecord,
                                                    ParamType.Document,
                                                  ),
                                                  'chatRef': serializeParam(
                                                    _model.createdChatDoc
                                                        ?.reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  'chatUser':
                                                      listViewUsersRecord,
                                                },
                                              );

                                              setState(() {});
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              height: 40.0,
                                              decoration: const BoxDecoration(
                                                color: Colors.transparent,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3.0),
                                                      child: Image.network(
                                                        listViewUsersRecord
                                                            .photoUrl,
                                                        width: 25.0,
                                                        height: 25.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          listViewUsersRecord
                                                              .displayName
                                                              .maybeHandleOverflow(
                                                            maxChars: 18,
                                                            replacement: '…',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                                if (_model.isUserSelected == true)
                                  Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBtnText,
                                    ),
                                    child: Align(
                                      alignment: const AlignmentDirectional(0.0, 0.0),
                                      child: SizedBox(
                                        width: 100.0,
                                        height: 100.0,
                                        child: custom_widgets.FFlowSpinner(
                                          width: 100.0,
                                          height: 100.0,
                                          backgroundColor: Colors.transparent,
                                          spinnerColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 100.0, 0.0, 0.0),
                              child: wrapWithModel(
                                model: _model.defaultEmptyComponentModel,
                                updateCallback: () => setState(() {}),
                                child: const DefaultEmptyComponentWidget(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBtnText,
                ),
                child: Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: custom_widgets.FFlowSpinner(
                      width: 100.0,
                      height: 100.0,
                      backgroundColor: Colors.transparent,
                      spinnerColor: FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
