import 'dart:io';

import 'package:googleapis/drive/v3.dart' as drive;
// ignore: library_prefixes
import 'package:google_sign_in/google_sign_in.dart' as signIn;

import '../../../services/google_helper.dart';

import 'dart:async';

class PhotoService {
  static Future submitData(img, bool isFrontId, String firstName) async {
    final googleSignIn =
        signIn.GoogleSignIn.standard(scopes: [drive.DriveApi.driveScope]);
    var account = await googleSignIn.signIn();

    final authHeaders = await account!.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);
    final driveApi = drive.DriveApi(authenticateClient);
    if (img != null) {
      File file = File(img);
      try {
        var driveFile = drive.File();
        if (isFrontId) {
          driveFile.name = "${firstName}_frontImg";
        } else {
          driveFile.name = "${firstName}_backImg";
        }
        final result = await driveApi.files.create(driveFile,
            uploadMedia: drive.Media(file.openRead(), file.lengthSync()));
        // ignore: avoid_print
        print("Upload result: $result");
      } catch (e) {
        rethrow;
      }
    }
  }
}
