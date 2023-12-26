import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/channel_button_widget.dart';
import '/components/empty_chat_widget_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'all_chats_model.dart';
export 'all_chats_model.dart';

class AllChatsWidget extends StatefulWidget {
  const AllChatsWidget({super.key});

  @override
  _AllChatsWidgetState createState() => _AllChatsWidgetState();
}

class _AllChatsWidgetState extends State<AllChatsWidget> {
  late AllChatsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllChatsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.allUserChats = await queryChatsRecordOnce(
        queryBuilder: (chatsRecord) => chatsRecord.where(
          'users',
          arrayContains: currentUserReference,
        ),
      );
      setState(() {
        FFAppState().pinnedChatRef = _model.allUserChats
            ?.where((e) => e.pinnedBy.contains(currentUserReference) == true)
            .toList()
            .first
            .reference;
      });
      setState(() {
        _model.allChatRefs = _model.allUserChats!
            .map((e) => e.reference)
            .toList()
            .where((e) => e != FFAppState().pinnedChatRef)
            .toList()
            .toList()
            .cast<DocumentReference>();
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

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 75.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(-1.0, 1.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 0.0, 15.0),
                        child: Text(
                          'Chats',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    fontSize: 17.0,
                                    lineHeight: 1.5,
                                  ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 15.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed('StartNewChat');
                        },
                        child: Container(
                          width: 25.0,
                          height: 25.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFF32176D),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          child: Icon(
                            Icons.add_rounded,
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            size: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1.0,
                thickness: 1.0,
                color: FlutterFlowTheme.of(context).darkGrey3,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (FFAppState().pinnedChatRef != null)
                          StreamBuilder<ChatsRecord>(
                            stream: ChatsRecord.getDocument(
                                FFAppState().pinnedChatRef!),
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
                              final containerChatsRecord = snapshot.data!;
                              return Container(
                                decoration: const BoxDecoration(),
                                child: Builder(
                                  builder: (context) {
                                    if (containerChatsRecord.chatType == 'DM') {
                                      return FutureBuilder<UsersRecord>(
                                        future: UsersRecord.getDocumentOnce(
                                            containerChatsRecord.users
                                                .where((e) =>
                                                    e != currentUserReference)
                                                .toList()
                                                .first),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 50.0,
                                                height: 50.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          final containerUsersRecord =
                                              snapshot.data!;
                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                'ChatBox',
                                                queryParameters: {
                                                  'chatUser': serializeParam(
                                                    containerUsersRecord,
                                                    ParamType.Document,
                                                  ),
                                                  'chatRef': serializeParam(
                                                    containerChatsRecord
                                                        .reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  'chatUser':
                                                      containerUsersRecord,
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              height: 60.0,
                                              decoration: BoxDecoration(
                                                color: containerChatsRecord
                                                            .lastMessageSeenBy
                                                            .contains(
                                                                currentUserReference) ==
                                                        false
                                                    ? const Color(0x1AFF6B78)
                                                    : Colors.transparent,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 5.0, 15.0, 5.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                            width: 35.0,
                                                            height: 35.0,
                                                            decoration:
                                                                const BoxDecoration(),
                                                            child: Stack(
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4.0),
                                                                  child: Image
                                                                      .network(
                                                                    containerUsersRecord
                                                                        .photoUrl,
                                                                    width: 30.0,
                                                                    height:
                                                                        30.0,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                if (containerChatsRecord
                                                                        .lastMessageSeenBy
                                                                        .contains(
                                                                            currentUserReference) ==
                                                                    false)
                                                                  Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            0.8,
                                                                            0.8),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          10.0,
                                                                      height:
                                                                          10.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: const Color(
                                                                            0xFFFF2B37),
                                                                        borderRadius:
                                                                            BorderRadius.circular(2.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          2.5,
                                                                          10.0,
                                                                          0.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            AutoSizeText(
                                                                          containerUsersRecord
                                                                              .displayName
                                                                              .maybeHandleOverflow(
                                                                            maxChars:
                                                                                18,
                                                                            replacement:
                                                                                '…',
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Inter',
                                                                                fontSize: 16.0,
                                                                                fontWeight: FontWeight.w500,
                                                                                lineHeight: 1.0,
                                                                              ),
                                                                          minFontSize:
                                                                              12.0,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        functions
                                                                            .getMessageTime(containerChatsRecord.lastMessageTime)
                                                                            .maybeHandleOverflow(
                                                                              maxChars: 20,
                                                                              replacement: '…',
                                                                            ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Inter',
                                                                              color: FlutterFlowTheme.of(context).darkGrey4,
                                                                              fontSize: 12.0,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Expanded(
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Padding(
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                5.0,
                                                                                0.0),
                                                                            child:
                                                                                AutoSizeText(
                                                                              containerChatsRecord.lastMessage.maybeHandleOverflow(
                                                                                maxChars: 32,
                                                                                replacement: '…',
                                                                              ),
                                                                              maxLines: 1,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Inter',
                                                                                    color: FlutterFlowTheme.of(context).darkGrey4,
                                                                                    fontSize: 14.0,
                                                                                    fontWeight: FontWeight.normal,
                                                                                  ),
                                                                              minFontSize: 10.0,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              5.0,
                                                                              0.0),
                                                                          child:
                                                                              Icon(
                                                                            Icons.push_pin_rounded,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).darkGrey,
                                                                            size:
                                                                                16.0,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ].divide(const SizedBox(
                                                                    height:
                                                                        5.0)),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                                          context.pushNamed(
                                            'ChatBox',
                                            queryParameters: {
                                              'chatRef': serializeParam(
                                                containerChatsRecord.reference,
                                                ParamType.DocumentReference,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        child: wrapWithModel(
                                          model: _model.channelButtonModel1,
                                          updateCallback: () => setState(() {}),
                                          updateOnChange: true,
                                          child: ChannelButtonWidget(
                                            channelName: containerChatsRecord
                                                .channelName,
                                            isRead: containerChatsRecord
                                                    .lastMessageSeenBy
                                                    .contains(
                                                        currentUserReference) ==
                                                true,
                                            isPinned: true,
                                            lastMsg: containerChatsRecord
                                                .lastMessage,
                                            lastMsgTime: containerChatsRecord
                                                .lastMessageTime!,
                                            lastMsgSentBy: containerChatsRecord
                                                .lastMessageSentBy!,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        StreamBuilder<List<ChatsRecord>>(
                          stream: queryChatsRecord(
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
                            List<ChatsRecord> containerChatsRecordList =
                                snapshot.data!;
                            return Container(
                              decoration: const BoxDecoration(),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: Builder(
                                  builder: (context) {
                                    final filteredChatDocs =
                                        containerChatsRecordList
                                            .where((e) =>
                                                e.reference !=
                                                FFAppState().pinnedChatRef)
                                            .toList();
                                    if (filteredChatDocs.isEmpty) {
                                      return const Center(
                                        child: EmptyChatWidgetWidget(),
                                      );
                                    }
                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: filteredChatDocs.length,
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(height: 5.0),
                                      itemBuilder:
                                          (context, filteredChatDocsIndex) {
                                        final filteredChatDocsItem =
                                            filteredChatDocs[
                                                filteredChatDocsIndex];
                                        return Builder(
                                          builder: (context) {
                                            if (filteredChatDocsItem.chatType ==
                                                'DM') {
                                              return FutureBuilder<UsersRecord>(
                                                future: UsersRecord.getDocumentOnce(
                                                    filteredChatDocsItem.users
                                                        .where((e) =>
                                                            e !=
                                                            currentUserReference)
                                                        .toList()
                                                        .first),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        child:
                                                            CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                  Color>(
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  final containerUsersRecord =
                                                      snapshot.data!;
                                                  return InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      context.pushNamed(
                                                        'ChatBox',
                                                        queryParameters: {
                                                          'chatUser':
                                                              serializeParam(
                                                            containerUsersRecord,
                                                            ParamType.Document,
                                                          ),
                                                          'chatRef':
                                                              serializeParam(
                                                            filteredChatDocsItem
                                                                .reference,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String,
                                                            dynamic>{
                                                          'chatUser':
                                                              containerUsersRecord,
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 60.0,
                                                      decoration: BoxDecoration(
                                                        color: filteredChatDocsItem
                                                                    .lastMessageSeenBy
                                                                    .contains(
                                                                        currentUserReference) ==
                                                                false
                                                            ? const Color(0x1AFF6B78)
                                                            : Colors
                                                                .transparent,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    15.0,
                                                                    5.0,
                                                                    15.0,
                                                                    5.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Container(
                                                              width: 35.0,
                                                              height: 35.0,
                                                              decoration:
                                                                  const BoxDecoration(),
                                                              child: Stack(
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4.0),
                                                                    child: Image
                                                                        .network(
                                                                      containerUsersRecord
                                                                          .photoUrl,
                                                                      width:
                                                                          30.0,
                                                                      height:
                                                                          30.0,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                  if (filteredChatDocsItem
                                                                          .lastMessageSeenBy
                                                                          .contains(
                                                                              currentUserReference) ==
                                                                      false)
                                                                    Align(
                                                                      alignment:
                                                                          const AlignmentDirectional(
                                                                              0.8,
                                                                              0.8),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            10.0,
                                                                        height:
                                                                            10.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              const Color(0xFFFF2B37),
                                                                          borderRadius:
                                                                              BorderRadius.circular(2.0),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        2.5,
                                                                        10.0,
                                                                        0.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              AutoSizeText(
                                                                            containerUsersRecord.displayName.maybeHandleOverflow(
                                                                              maxChars: 18,
                                                                              replacement: '…',
                                                                            ),
                                                                            maxLines:
                                                                                1,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Inter',
                                                                                  fontSize: 16.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  lineHeight: 1.0,
                                                                                ),
                                                                            minFontSize:
                                                                                12.0,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          functions
                                                                              .getMessageTime(filteredChatDocsItem.lastMessageTime)
                                                                              .maybeHandleOverflow(
                                                                                maxChars: 20,
                                                                                replacement: '…',
                                                                              ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Inter',
                                                                                color: FlutterFlowTheme.of(context).darkGrey4,
                                                                                fontSize: 12.0,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                AutoSizeText(
                                                                              filteredChatDocsItem.lastMessage.maybeHandleOverflow(
                                                                                maxChars: 32,
                                                                                replacement: '…',
                                                                              ),
                                                                              maxLines: 1,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Inter',
                                                                                    color: FlutterFlowTheme.of(context).darkGrey4,
                                                                                    fontSize: 14.0,
                                                                                    fontWeight: FontWeight.normal,
                                                                                  ),
                                                                              minFontSize: 10.0,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ].divide(const SizedBox(
                                                                      height:
                                                                          5.0)),
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
                                            } else {
                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context.pushNamed(
                                                    'ChatBox',
                                                    queryParameters: {
                                                      'chatRef': serializeParam(
                                                        filteredChatDocsItem
                                                            .reference,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                },
                                                child: ChannelButtonWidget(
                                                  key: Key(
                                                      'Key4eo_${filteredChatDocsIndex}_of_${filteredChatDocs.length}'),
                                                  channelName:
                                                      filteredChatDocsItem
                                                          .channelName,
                                                  isRead: filteredChatDocsItem
                                                          .lastMessageSeenBy
                                                          .contains(
                                                              currentUserReference) ==
                                                      true,
                                                  isPinned: false,
                                                  lastMsg: filteredChatDocsItem
                                                      .lastMessage,
                                                  lastMsgTime:
                                                      filteredChatDocsItem
                                                          .lastMessageTime!,
                                                  lastMsgSentBy:
                                                      filteredChatDocsItem
                                                          .lastMessageSentBy!,
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
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0, 20.0, 0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed('StartNewChat');
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF32176D),
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  child: Icon(
                                    Icons.add_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    size: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'New chat',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
