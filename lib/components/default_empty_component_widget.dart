import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'default_empty_component_model.dart';
export 'default_empty_component_model.dart';

class DefaultEmptyComponentWidget extends StatefulWidget {
  const DefaultEmptyComponentWidget({super.key});

  @override
  _DefaultEmptyComponentWidgetState createState() =>
      _DefaultEmptyComponentWidgetState();
}

class _DefaultEmptyComponentWidgetState
    extends State<DefaultEmptyComponentWidget> {
  late DefaultEmptyComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DefaultEmptyComponentModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: const AlignmentDirectional(0.00, 0.00),
      child: Text(
        'Empty',
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Inter',
              color: FlutterFlowTheme.of(context).darkGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              lineHeight: 1.5,
            ),
      ),
    );
  }
}
