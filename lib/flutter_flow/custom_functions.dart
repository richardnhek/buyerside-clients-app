import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

String? getFileName(String? imagePath) {
  if (imagePath == null || imagePath.isEmpty) {
    return null;
  }

  // Decode the URL to handle encoded characters
  var decodedUrl = Uri.decodeFull(imagePath);

  // Split the decoded string by '/' and get the last segment
  var segments = decodedUrl.split('/');
  return segments.isNotEmpty ? segments.last.split('?').first : null;
}
