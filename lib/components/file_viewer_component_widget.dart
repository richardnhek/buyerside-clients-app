import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'file_viewer_component_model.dart';
export 'file_viewer_component_model.dart';

class FileViewerComponentWidget extends StatefulWidget {
  const FileViewerComponentWidget({
    super.key,
    required this.fileThumbnail,
  });

  final String? fileThumbnail;

  @override
  _FileViewerComponentWidgetState createState() =>
      _FileViewerComponentWidgetState();
}

class _FileViewerComponentWidgetState extends State<FileViewerComponentWidget> {
  late FileViewerComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FileViewerComponentModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(0.0),
      child: Image.network(
        widget.fileThumbnail!,
        width: 300.0,
        height: 300.0,
        fit: BoxFit.contain,
      ),
    );
  }
}
