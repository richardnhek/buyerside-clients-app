import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/file_viewer_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'user_profile_model.dart';
export 'user_profile_model.dart';

class UserProfileWidget extends StatefulWidget {
  const UserProfileWidget({
    super.key,
    required this.userDoc,
    required this.chatRef,
  });

  final UsersRecord? userDoc;
  final DocumentReference? chatRef;

  @override
  _UserProfileWidgetState createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  late UserProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserProfileModel());
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
            alignment: const AlignmentDirectional(-1.00, 1.00),
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
          centerTitle: false,
          toolbarHeight: 75.0,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Divider(
                height: 1.0,
                thickness: 1.0,
                color: FlutterFlowTheme.of(context).darkGrey3,
              ),
              Align(
                alignment: const AlignmentDirectional(0.00, -1.00),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Image.network(
                          widget.userDoc!.photoUrl,
                          width: 40.0,
                          height: 40.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                        child: Text(
                          valueOrDefault<String>(
                            widget.userDoc?.displayName,
                            'N/A',
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    fontSize: 17.0,
                                  ),
                        ),
                      ),
                      Text(
                        '@${widget.userDoc?.displayName}',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20.0, 30.0, 20.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Builder(
                      builder: (context) {
                        if ((widget.chatRef != FFAppState().pinnedChatRef) &&
                            (_model.isProcessing == false)) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (FFAppState().pinnedChatRef == null) {
                                setState(() {
                                  _model.isProcessing = true;
                                });

                                await widget.chatRef!.update({
                                  ...mapToFirestore(
                                    {
                                      'pinnedBy': FieldValue.arrayUnion(
                                          [currentUserReference]),
                                    },
                                  ),
                                });
                                FFAppState().update(() {
                                  FFAppState().pinnedChatRef = widget.chatRef;
                                });
                                setState(() {
                                  _model.isProcessing = false;
                                });
                              } else {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Only 1 chat can be pinned at a time',
                                      style: GoogleFonts.getFont(
                                        'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    duration: const Duration(milliseconds: 1200),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryText,
                                  ),
                                );
                              }
                            },
                            child: Material(
                              color: Colors.transparent,
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                width: 110.0,
                                height: 70.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).darkGrey3,
                                  ),
                                ),
                                alignment: const AlignmentDirectional(0.00, 0.00),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 5.0),
                                      child: Icon(
                                        FFIcons.kpin,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 18.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 2.5, 0.0, 0.0),
                                      child: Text(
                                        'Pin',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else if ((widget.chatRef ==
                                FFAppState().pinnedChatRef) &&
                            (_model.isProcessing == false)) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              setState(() {
                                _model.isProcessing = true;
                              });

                              await widget.chatRef!.update({
                                ...mapToFirestore(
                                  {
                                    'pinnedBy': FieldValue.arrayRemove(
                                        [currentUserReference]),
                                  },
                                ),
                              });
                              FFAppState().update(() {
                                FFAppState().pinnedChatRef = null;
                              });
                              setState(() {
                                _model.isProcessing = false;
                              });
                            },
                            child: Material(
                              color: Colors.transparent,
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                width: 110.0,
                                height: 70.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).accent1,
                                  borderRadius: BorderRadius.circular(10.0),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: Colors.transparent,
                                    width: 0.0,
                                  ),
                                ),
                                alignment: const AlignmentDirectional(0.00, 0.00),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 5.0),
                                      child: Icon(
                                        FFIcons.kpin,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                        size: 18.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 2.5, 0.0, 0.0),
                                      child: Text(
                                        'Unpin',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBtnText,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            width: 110.0,
                            height: 70.0,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(0.00, 0.00),
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: custom_widgets.FFlowSpinner(
                                  width: 50.0,
                                  height: 50.0,
                                  spinnerWidth: 40.0,
                                  spinnerHeight: 40.0,
                                  backgroundColor: Colors.transparent,
                                  spinnerColor:
                                      FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    Material(
                      color: Colors.transparent,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        width: 110.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).darkGrey2,
                          borderRadius: BorderRadius.circular(10.0),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                        ),
                        alignment: const AlignmentDirectional(0.00, 0.00),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 2.5, 5.0),
                              child: Icon(
                                FFIcons.kmute,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 18.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 2.5, 0.0, 0.0),
                              child: Text(
                                'Mute',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Inter',
                                      color: Colors.black,
                                      fontSize: 14.0,
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
              Divider(
                height: 40.0,
                thickness: 1.0,
                color: FlutterFlowTheme.of(context).darkGrey3,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).darkGrey3,
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Files',
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: 'Inter',
                                color: FlutterFlowTheme.of(context).darkGrey5,
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                                lineHeight: 1.5,
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 15.0, 0.0, 0.0),
                          child: FutureBuilder<List<ChatMessagesRecord>>(
                            future: queryChatMessagesRecordOnce(
                              queryBuilder: (chatMessagesRecord) =>
                                  chatMessagesRecord.where(
                                'chat',
                                isEqualTo: widget.chatRef,
                              ),
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
                              List<ChatMessagesRecord>
                                  containerChatMessagesRecordList =
                                  snapshot.data!;
                              return Container(
                                constraints: const BoxConstraints(
                                  maxHeight: 250.0,
                                ),
                                decoration: const BoxDecoration(),
                                child: Builder(
                                  builder: (context) {
                                    final filesShared =
                                        containerChatMessagesRecordList
                                            .where((e) =>
                                                e.image != '')
                                            .toList();
                                    return SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children:
                                            List.generate(filesShared.length,
                                                (filesSharedIndex) {
                                          final filesSharedItem =
                                              filesShared[filesSharedIndex];
                                          return Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Builder(
                                                builder: (context) => InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    if ((functions.getFileExt(filesSharedItem.image) == 'jpg') ||
                                                        (functions.getFileExt(
                                                                filesSharedItem
                                                                    .image) ==
                                                            'png') ||
                                                        (functions.getFileExt(
                                                                filesSharedItem
                                                                    .image) ==
                                                            'jpeg')) {
                                                      await showAlignedDialog(
                                                        context: context,
                                                        isGlobal: true,
                                                        avoidOverflow: false,
                                                        targetAnchor:
                                                            const AlignmentDirectional(
                                                                    0.0, 0.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        followerAnchor:
                                                            const AlignmentDirectional(
                                                                    0.0, 0.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        builder:
                                                            (dialogContext) {
                                                          return Material(
                                                            color: Colors
                                                                .transparent,
                                                            child: WebViewAware(
                                                                child:
                                                                    GestureDetector(
                                                              onTap: () => _model
                                                                      .unfocusNode
                                                                      .canRequestFocus
                                                                  ? FocusScope.of(
                                                                          context)
                                                                      .requestFocus(
                                                                          _model
                                                                              .unfocusNode)
                                                                  : FocusScope.of(
                                                                          context)
                                                                      .unfocus(),
                                                              child:
                                                                  FileViewerComponentWidget(
                                                                fileThumbnail:
                                                                    filesSharedItem
                                                                        .image,
                                                              ),
                                                            )),
                                                          );
                                                        },
                                                      ).then((value) =>
                                                          setState(() {}));
                                                    } else if ((functions.getFileExt(
                                                                filesSharedItem
                                                                    .image) ==
                                                            'pdf') ||
                                                        (functions.getFileExt(
                                                                filesSharedItem
                                                                    .image) ==
                                                            'doc') ||
                                                        (functions.getFileExt(
                                                                filesSharedItem
                                                                    .image) ==
                                                            'docx') ||
                                                        (functions.getFileExt(
                                                                filesSharedItem
                                                                    .image) ==
                                                            'txt')) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .clearSnackBars();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Saving and opening file....',
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Inter',
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBtnText,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15.0,
                                                            ),
                                                          ),
                                                          duration: const Duration(
                                                              milliseconds:
                                                                  1200),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondaryText,
                                                        ),
                                                      );
                                                      await actions.saveFile(
                                                        filesSharedItem.image,
                                                      );
                                                    }
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                    child: Image.network(
                                                      filesSharedItem.image,
                                                      width: 40.0,
                                                      height: 40.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      valueOrDefault<String>(
                                                        functions.getFileName(
                                                            filesSharedItem
                                                                .image),
                                                        'File.png',
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            lineHeight: 1.5,
                                                          ),
                                                    ),
                                                    FutureBuilder<UsersRecord>(
                                                      future: UsersRecord
                                                          .getDocumentOnce(
                                                              filesSharedItem
                                                                  .user!),
                                                      builder:
                                                          (context, snapshot) {
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
                                                        final textUsersRecord =
                                                            snapshot.data!;
                                                        return Text(
                                                          'Shared by ${textUsersRecord.displayName} on ${dateTimeFormat(
                                                            'yMMMd',
                                                            filesSharedItem
                                                                .timestamp,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          )}',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .darkGrey5,
                                                                fontSize: 12.0,
                                                                lineHeight: 1.5,
                                                              ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        }).divide(const SizedBox(height: 15.0)),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4.0,
                        color: Color(0x1D000000),
                        offset: Offset(0.0, 2.0),
                      )
                    ],
                  ),
                  child: FFButtonWidget(
                    onPressed: () async {
                      var confirmDialogResponse = await showDialog<bool>(
                            context: context,
                            builder: (alertDialogContext) {
                              return WebViewAware(
                                  child: AlertDialog(
                                title: const Text('Close conversation'),
                                content: const Text(
                                    'Are you sure you want to close this conversation? It will be gone forever.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(
                                        alertDialogContext, false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext, true),
                                    child: const Text('Confirm'),
                                  ),
                                ],
                              ));
                            },
                          ) ??
                          false;
                      if (confirmDialogResponse) {
                        await widget.chatRef!.delete();

                        context.goNamed('AllChats');
                      }
                    },
                    text: 'Close conversation',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 45.0,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primaryBtnText,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Inter',
                                color: const Color(0xFFFB4A5E),
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                              ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).darkGrey3,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
            ].addToEnd(const SizedBox(height: 75.0)),
          ),
        ),
      ),
    );
  }
}
