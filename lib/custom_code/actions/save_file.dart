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
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

Future saveFile(String? filePath) async {
  http.Client? client; // Declare client as nullable

  if (filePath == null || filePath.isEmpty) {
    throw 'File path cannot be null or empty';
  }

  try {
    // Request permission to write to external storage
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      throw 'Storage permission not granted';
    }

    // Create an HTTP client
    client = http.Client();

    // Make a request to download the file
    var response = await client.get(Uri.parse(filePath));

    if (response.statusCode == 200) {
      // Find an external path for download (like Downloads folder)
      var directory = await getExternalStorageDirectory();
      String fileName = filePath
          .split('/')
          .last
          .split('?')
          .first; // Adjusted to remove URL parameters
      var file = File('${directory!.path}/$fileName');

      // Write the file
      await file.writeAsBytes(response.bodyBytes);
      print("Saved at ${file.path}");

      // Open the file
      await OpenFile.open(file.path);

      return file.path;
    } else {
      throw 'Failed to download file: Server responded with status code ${response.statusCode}';
    }
  } catch (e) {
    throw 'An error occurred while downloading the file: $e';
  } finally {
    if (client != null) {
      // Check if client is not null before closing
      client.close();
    }
  }
}