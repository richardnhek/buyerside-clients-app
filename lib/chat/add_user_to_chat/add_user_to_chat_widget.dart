import '/components/default_empty_component_widget.dart';
import '/flutter_flow/chat/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'add_user_to_chat_model.dart';
export 'add_user_to_chat_model.dart';

class AddUserToChatWidget extends StatefulWidget {
  const AddUserToChatWidget({
    super.key,
    required this.chatRef,
  });

  final DocumentReference? chatRef;

  @override
  _AddUserToChatWidgetState createState() => _AddUserToChatWidgetState();
}

class _AddUserToChatWidgetState extends State<AddUserToChatWidget> {
  late AddUserToChatModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddUserToChatModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.isLoaded = false;
      });
      _model.currentChatRef = await queryChatsRecordOnce(
        queryBuilder: (chatsRecord) => chatsRecord.where(
          'chat_ref',
          isEqualTo: widget.chatRef,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      _model.availableUsers = await queryUsersRecordOnce(
        queryBuilder: (usersRecord) =>
            usersRecord.whereNotIn('user_ref', _model.currentChatRef?.users),
      );
      setState(() {
        _model.availableUserDocs =
            _model.availableUsers!.toList().cast<UsersRecord>();
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
              'Add people to conversation',
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
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(-1.0, -1.0),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Builder(
                        builder: (context) {
                          final addedUserList = _model.addedUsersUID.toList();
                          if (addedUserList.isEmpty) {
                            return const Center(
                              child: DefaultEmptyComponentWidget(),
                            );
                          }
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(addedUserList.length,
                                  (addedUserListIndex) {
                                final addedUserListItem =
                                    addedUserList[addedUserListIndex];
                                return FutureBuilder<List<UsersRecord>>(
                                  future: queryUsersRecordOnce(
                                    queryBuilder: (usersRecord) =>
                                        usersRecord.where(
                                      'uid',
                                      isEqualTo: addedUserListItem,
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
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<UsersRecord> containerUsersRecordList =
                                        snapshot.data!;
                                    // Return an empty Container when the item does not exist.
                                    if (snapshot.data!.isEmpty) {
                                      return Container();
                                    }
                                    final containerUsersRecord =
                                        containerUsersRecordList.isNotEmpty
                                            ? containerUsersRecordList.first
                                            : null;
                                    return Container(
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            child: Image.network(
                                              containerUsersRecord!.photoUrl,
                                              width: 40.0,
                                              height: 40.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 10.0, 0.0),
                                            child: Text(
                                              containerUsersRecord.email,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        lineHeight: 1.0,
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 10.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                setState(() {
                                                  _model
                                                      .removeFromAddedUsersUID(
                                                          addedUserListItem);
                                                });
                                                _model.removedUserDoc =
                                                    await queryUsersRecordOnce(
                                                  queryBuilder: (usersRecord) =>
                                                      usersRecord.where(
                                                    'uid',
                                                    isEqualTo:
                                                        addedUserListItem,
                                                  ),
                                                  singleRecord: true,
                                                ).then((s) => s.firstOrNull);
                                                setState(() {
                                                  _model.addToAvailableUserDocs(
                                                      _model.removedUserDoc!);
                                                });

                                                setState(() {});
                                              },
                                              child: Icon(
                                                Icons.close_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 18.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }).divide(const SizedBox(width: 10.0)),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  if (_model.availableUsers!.isNotEmpty)
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                      child: FlutterFlowDropDown<String>(
                        controller: _model.dropDownValueController ??=
                            FormFieldController<String>(
                          _model.dropDownValue ??=
                              _model.availableUserDocs.first.uid,
                        ),
                        options: List<String>.from(_model.availableUserDocs
                            .map((e) => e.uid)
                            .toList()),
                        optionLabels: _model.availableUserDocs
                            .map((e) => e.email)
                            .toList(),
                        onChanged: (val) async {
                          setState(() => _model.dropDownValue = val);
                          setState(() {
                            _model.addToAddedUsersUID(_model.dropDownValue!);
                          });
                          _model.selectedUserDoc = await queryUsersRecordOnce(
                            queryBuilder: (usersRecord) => usersRecord.where(
                              'uid',
                              isEqualTo: _model.dropDownValue,
                            ),
                            singleRecord: true,
                          ).then((s) => s.firstOrNull);
                          setState(() {
                            _model.removeFromAvailableUserDocs(
                                _model.selectedUserDoc!);
                          });

                          setState(() {});
                        },
                        width: double.infinity,
                        height: 50.0,
                        searchHintTextStyle:
                            FlutterFlowTheme.of(context).labelMedium,
                        textStyle: FlutterFlowTheme.of(context).bodyMedium,
                        hintText: 'Please select...',
                        searchHintText: 'Search for an item...',
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        fillColor: FlutterFlowTheme.of(context).primaryBtnText,
                        elevation: 2.0,
                        borderColor: FlutterFlowTheme.of(context).darkGrey2,
                        borderWidth: 1.0,
                        borderRadius: 4.0,
                        margin: const EdgeInsetsDirectional.fromSTEB(
                            8.0, 10.0, 8.0, 10.0),
                        hidesUnderline: true,
                        isSearchable: true,
                        isMultiSelect: false,
                      ),
                    ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20.0, 40.0, 20.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: _model.addedUsersUID.isEmpty
                          ? null
                          : () async {
                              _model.specificChatDoc =
                                  await queryChatsRecordOnce(
                                queryBuilder: (chatsRecord) =>
                                    chatsRecord.where(
                                  'chat_ref',
                                  isEqualTo: widget.chatRef,
                                ),
                                singleRecord: true,
                              ).then((s) => s.firstOrNull);
                              _model.addedUserDocList =
                                  await queryUsersRecordOnce(
                                queryBuilder: (usersRecord) => usersRecord
                                    .whereIn('uid', _model.addedUsersUID),
                              );
                              _model.groupChat =
                                  await FFChatManager.instance.addGroupMembers(
                                _model.specificChatDoc!,
                                _model.addedUserDocList!
                                    .map((e) => e.reference)
                                    .toList(),
                              );

                              var chatMessagesRecordReference =
                                  ChatMessagesRecord.collection.doc();
                              await chatMessagesRecordReference
                                  .set(createChatMessagesRecordData(
                                user: currentUserReference,
                                chat: widget.chatRef,
                                text: functions.createWelcomeMessage(_model
                                    .addedUserDocList!
                                    .map((e) => e.displayName)
                                    .toList()),
                                timestamp: getCurrentTimestamp,
                              ));
                              _model.createdChatDoc =
                                  ChatMessagesRecord.getDocumentFromData(
                                      createChatMessagesRecordData(
                                        user: currentUserReference,
                                        chat: widget.chatRef,
                                        text: functions.createWelcomeMessage(
                                            _model.addedUserDocList!
                                                .map((e) => e.displayName)
                                                .toList()),
                                        timestamp: getCurrentTimestamp,
                                      ),
                                      chatMessagesRecordReference);

                              await _model.createdChatDoc!.reference
                                  .update(createChatMessagesRecordData(
                                chatMessageRef:
                                    _model.createdChatDoc?.reference,
                              ));
                              context.safePop();

                              setState(() {});
                            },
                      text: 'Confirm',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 50.0,
                        padding: const EdgeInsets.all(0.0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).accent1,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                ),
                        elevation: 0.0,
                        borderSide: const BorderSide(
                          color: Color(0x49105035),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        disabledColor: FlutterFlowTheme.of(context).darkGrey4,
                      ),
                    ),
                  ),
                ].addToEnd(const SizedBox(height: 75.0)),
              );
            } else {
              return SizedBox(
                width: 50.0,
                height: 50.0,
                child: custom_widgets.FFlowSpinner(
                  width: 50.0,
                  height: 50.0,
                  backgroundColor: Colors.transparent,
                  spinnerColor: FlutterFlowTheme.of(context).primary,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
