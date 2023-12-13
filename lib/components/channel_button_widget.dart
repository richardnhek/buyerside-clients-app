import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'channel_button_model.dart';
export 'channel_button_model.dart';

class ChannelButtonWidget extends StatefulWidget {
  const ChannelButtonWidget({
    super.key,
    required this.channelName,
    required this.isRead,
    bool? isPinned,
    required this.lastMsgTime,
    required this.lastMsg,
    required this.lastMsgSentBy,
  })  : isPinned = isPinned ?? false;

  final String? channelName;
  final bool? isRead;
  final bool isPinned;
  final DateTime? lastMsgTime;
  final String? lastMsg;
  final DocumentReference? lastMsgSentBy;

  @override
  _ChannelButtonWidgetState createState() => _ChannelButtonWidgetState();
}

class _ChannelButtonWidgetState extends State<ChannelButtonWidget> {
  late ChannelButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChannelButtonModel());
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
      height: 60.0,
      decoration: BoxDecoration(
        color: widget.isRead == false ? const Color(0x1AFF6B78) : Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 15.0, 5.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 35.0,
              height: 35.0,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Stack(
                children: [
                  Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB253),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                  if (widget.isRead == false)
                    Align(
                      alignment: const AlignmentDirectional(0.80, 0.80),
                      child: Container(
                        width: 10.0,
                        height: 10.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF2B37),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 2.5, 10.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AutoSizeText(
                            valueOrDefault<String>(
                              widget.channelName,
                              'N/A',
                            ).maybeHandleOverflow(
                              maxChars: 18,
                              replacement: '…',
                            ),
                            maxLines: 1,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  lineHeight: 1.0,
                                ),
                            minFontSize: 12.0,
                          ),
                        ),
                        Text(
                          functions
                              .getMessageTime(widget.lastMsgTime)
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
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 5.0, 0.0),
                              child: FutureBuilder<UsersRecord>(
                                future: UsersRecord.getDocumentOnce(
                                    widget.lastMsgSentBy!),
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
                                  final textUsersRecord = snapshot.data!;
                                  return AutoSizeText(
                                    '${textUsersRecord.displayName}: ${widget.lastMsg}'
                                        .maybeHandleOverflow(
                                      maxChars: 32,
                                      replacement: '…',
                                    ),
                                    maxLines: 1,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: FlutterFlowTheme.of(context)
                                              .darkGrey4,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    minFontSize: 10.0,
                                  );
                                },
                              ),
                            ),
                          ),
                          if (widget.isPinned == true)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 5.0, 0.0),
                              child: Icon(
                                Icons.push_pin_rounded,
                                color: FlutterFlowTheme.of(context).darkGrey,
                                size: 16.0,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ].divide(const SizedBox(height: 5.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
