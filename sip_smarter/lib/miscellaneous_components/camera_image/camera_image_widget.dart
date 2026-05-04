import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'camera_image_model.dart';
export 'camera_image_model.dart';

class CameraImageWidget extends StatefulWidget {
  const CameraImageWidget({super.key});

  @override
  State<CameraImageWidget> createState() => _CameraImageWidgetState();
}

class _CameraImageWidgetState extends State<CameraImageWidget> {
  late CameraImageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CameraImageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 5.0,
      shape: const CircleBorder(),
      child: Container(
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(
              'assets/images/Screenshot_2025-12-24_005258.png',
            ).image,
          ),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
