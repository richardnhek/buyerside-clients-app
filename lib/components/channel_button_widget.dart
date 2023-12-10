import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
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
  })  : isPinned = isPinned ?? false;

  final String? channelName;
  final bool? isRead;
  final bool isPinned;

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
      height: 40.0,
      decoration: BoxDecoration(
        color: widget.isRead == false ? const Color(0x1AFF6B78) : Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 5.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 30.0,
              height: 30.0,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Stack(
                children: [
                  Container(
                    width: 25.0,
                    height: 25.0,
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
                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 4.0),
                child: Text(
                  widget.channelName!.maybeHandleOverflow(
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
            if (widget.isPinned == true)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                child: Icon(
                  FFIcons.kpin,
                  color: FlutterFlowTheme.of(context).darkGrey,
                  size: 16.0,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
