import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import 'login_model.dart';
export 'login_model.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late LoginModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginModel());

    _model.phoneNumberController ??= TextEditingController();
    _model.phoneNumberFocusNode ??= FocusNode();

    authManager.handlePhoneAuthStateChanges(context);
    authManager.handlePhoneAuthStateChanges(context);
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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 39.0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: const AlignmentDirectional(-1.0, -1.0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 35,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 30,
                  thickness: 1,
                  color: FlutterFlowTheme.of(context).darkGrey3,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    alignment: const AlignmentDirectional(0.0, -1.0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 50),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome Back',
                                    style: FlutterFlowTheme.of(context)
                                        .displaySmall
                                        .override(
                                          fontFamily: 'Inter',
                                          fontSize: 23,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 15, 0, 0),
                                    child: Text(
                                      'Please enter your phone number to verify and join the workspace.',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: FlutterFlowTheme.of(context)
                                                .darkGrey,
                                            fontSize: 15,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 40, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                          alignment: const AlignmentDirectional(
                                              -1.0, -1.0),
                                          child: Text(
                                            'Phone number',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  lineHeight: 1.5,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 8, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: TextFormField(
                                                    controller: _model
                                                        .phoneNumberController,
                                                    focusNode: _model
                                                        .phoneNumberFocusNode,
                                                    onChanged: (_) =>
                                                        EasyDebounce.debounce(
                                                      '_model.phoneNumberController',
                                                      const Duration(
                                                          milliseconds: 100),
                                                      () => setState(() {}),
                                                    ),
                                                    onFieldSubmitted:
                                                        (_) async {
                                                      final phoneNumberVal = _model
                                                          .phoneNumberController
                                                          .text;
                                                      if (phoneNumberVal == null ||
                                                          phoneNumberVal
                                                              .isEmpty ||
                                                          !phoneNumberVal
                                                              .startsWith(
                                                                  '+')) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                                'Phone Number is required and has to start with +.'),
                                                          ),
                                                        );
                                                        return;
                                                      }
                                                      await authManager
                                                          .beginPhoneAuth(
                                                        context: context,
                                                        phoneNumber:
                                                            phoneNumberVal,
                                                        onCodeSent:
                                                            (context) async {
                                                          context.goNamedAuth(
                                                            'VerificationPage',
                                                            context.mounted,
                                                            queryParameters: {
                                                              'phoneNumber':
                                                                  serializeParam(
                                                                _model
                                                                    .phoneNumberController
                                                                    .text,
                                                                ParamType
                                                                    .String,
                                                              ),
                                                            }.withoutNulls,
                                                            ignoreRedirect:
                                                                true,
                                                          );
                                                        },
                                                      );
                                                    },
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                color: Colors
                                                                    .transparent,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                      hintText:
                                                          '+1(204) 204-2056',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .darkGrey,
                                                                fontSize: 16,
                                                                lineHeight: 1.5,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .darkGrey3,
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .darkGrey3,
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0x00000000),
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0x00000000),
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      filled: true,
                                                      fillColor: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 16,
                                                        ),
                                                    maxLines: null,
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    validator: _model
                                                        .phoneNumberControllerValidator
                                                        .asValidator(context),
                                                    inputFormatters: [
                                                      _model.phoneNumberMask
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                            child: FFButtonWidget(
                              onPressed: _model.phoneNumberController.text ==
                                          null ||
                                      _model.phoneNumberController.text == ''
                                  ? null
                                  : () async {
                                      final phoneNumberVal =
                                          _model.phoneNumberController.text;
                                      if (phoneNumberVal == null ||
                                          phoneNumberVal.isEmpty ||
                                          !phoneNumberVal.startsWith('+')) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Phone Number is required and has to start with +.'),
                                          ),
                                        );
                                        return;
                                      }
                                      await authManager.beginPhoneAuth(
                                        context: context,
                                        phoneNumber: phoneNumberVal,
                                        onCodeSent: (context) async {
                                          context.goNamedAuth(
                                            'VerificationPage',
                                            context.mounted,
                                            queryParameters: {
                                              'phoneNumber': serializeParam(
                                                _model
                                                    .phoneNumberController.text,
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                            ignoreRedirect: true,
                                          );
                                        },
                                      );
                                    },
                              text: 'Continue',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 50,
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                iconPadding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Inter',
                                      color: Colors.white,
                                    ),
                                elevation: 0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 0,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                disabledColor:
                                    FlutterFlowTheme.of(context).darkGrey,
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
      ),
    );
  }
}
