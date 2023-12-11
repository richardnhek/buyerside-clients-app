// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

Future saveFile(String? filePath) async {
  var client;
  if (filePath == null || filePath.isEmpty) {
    throw 'File path cannot be null or empty';
  }

  try {
    // Create an HTTP client
    client = http.Client();

    // Make a request to download the file
    var response = await client.get(Uri.parse(filePath));

    if (response.statusCode == 200) {
      // Find a local path for download
      var directory = await getApplicationDocumentsDirectory();
      var file = File('${directory.path}/${filePath.split('/').last}');

      // Write the file
      await file.writeAsBytes(response.bodyBytes);
      return file.path;
    } else {
      throw 'Failed to download file: Server responded with status code ${response.statusCode}';
    }
  } catch (e) {
    throw 'An error occurred while downloading the file: $e';
  } finally {
    client.close();
  }
}
