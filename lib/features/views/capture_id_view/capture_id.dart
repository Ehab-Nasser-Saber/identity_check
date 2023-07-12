import 'package:edge_detection/edge_detection.dart';
import 'package:identity_check/services/google_sheet_services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../widgets/exports/capture_id_imports.dart';
import 'dart:async';

class CaptureIdView extends StatefulWidget {
  const CaptureIdView(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.address,
      required this.landline,
      required this.phoneNumber,
      required this.area,
      required this.nationalId})
      : super(key: key);
  final String firstName,
      lastName,
      address,
      landline,
      phoneNumber,
      area,
      nationalId;

  @override
  State<CaptureIdView> createState() => _CaptureIdViewState();
}

class _CaptureIdViewState extends State<CaptureIdView> {
  String? imagePathFrontId;
  String? imagePathBackId;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getImageFromCamera() async {
    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted =
          await Permission.camera.request() == PermissionStatus.granted;
    }

    if (!isCameraGranted) {
      // Have not permission to camera
      return;
    }

    // Generate filepath for saving
    String imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");
    print("this is img before:$imagePath");

    try {
      //Make sure to await the call to detectEdge.
      bool success = await EdgeDetection.detectEdge(
        imagePath,
        canUseGallery: true,
        androidScanTitle: 'Scanning', // use custom localizations for android
        androidCropTitle: 'Crop',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );
      print("success: $success");
    } catch (e) {
      print(e);
    }
    print("this is img after:$imagePath");

    if (!mounted) return;
    if (imagePathFrontId == null) {
      setState(() {
        imagePathFrontId = imagePath;
      });
      PhotoService.submitData(imagePathFrontId, true, widget.firstName);
    } else if (imagePathBackId == null) {
      setState(() {
        imagePathBackId = imagePath;
      });
      PhotoService.submitData(imagePathBackId, false, widget.firstName);
    }
    print("this front:$imagePathFrontId");
    print("this back:$imagePathBackId");
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: secondaryColor,
          title: const Text(
            'Capture Id',
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: 100,
                right: -200,
                child: Center(
                  child: Image.asset(
                    "assets/images/Fingerprint.png",
                    height: screenHeight * 0.7,
                    width: screenWidth * 0.95,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: ElevatedButton(
                      onPressed: getImageFromCamera,
                      child: Text(imagePathFrontId == null
                          ? 'Scan FrontId'
                          : 'Scan BackId'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Cropped image path:'),
                  if (imagePathFrontId != null) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
                      child: Text(
                        imagePathFrontId.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14),
                      ),
                    )
                  ],
                  Visibility(
                    visible: imagePathFrontId != null,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        File(imagePathFrontId ?? ''),
                      ),
                    ),
                  ),
                  if (imagePathBackId != null) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
                      child: Text(
                        imagePathBackId.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14),
                      ),
                    )
                  ],
                  Visibility(
                    visible: imagePathBackId != null,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        File(imagePathBackId ?? ''),
                      ),
                    ),
                  ),
                  LoginButton(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      title: "Submit GoogleSheet",
                      onPressed:
                          imagePathFrontId != null && imagePathBackId != null
                              ? () {
                                  getSheets(
                                      address: widget.address,
                                      area: widget.area,
                                      firstName: widget.firstName,
                                      phoneNumber: widget.phoneNumber,
                                      landline: widget.landline,
                                      lastName: widget.lastName,
                                      nationalId: widget.nationalId);
                                }
                              : null),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Functions
  // Future submitData(img, bool isFrontId) async {
  //   final googleSignIn =
  //       signIn.GoogleSignIn.standard(scopes: [drive.DriveApi.driveScope]);
  //   var account = await googleSignIn.signIn();

  //   final authHeaders = await account!.authHeaders;
  //   final authenticateClient = GoogleAuthClient(authHeaders);
  //   final driveApi = drive.DriveApi(authenticateClient);
  //   if (img != null) {
  //     File file = File(img);
  //     try {
  //       var driveFile = drive.File();
  //       if (isFrontId) {
  //         driveFile.name = "${widget.firstName}_frontImg";
  //       } else {
  //         driveFile.name = "${widget.firstName}_backImg";
  //       }
  //       final result = await driveApi.files.create(driveFile,
  //           uploadMedia: drive.Media(file.openRead(), file.lengthSync()));
  //       print("Upload result: $result");
  //     } catch (e) {
  //       rethrow;
  //     }
  //   }
  // }
  //submit info.
  // final data = {
  //   SheetsColumn.firstName: widget.firstName,
  //   SheetsColumn.lastName: widget.lastName.trim(),
  //   SheetsColumn.address: widget.address.trim(),
  //   SheetsColumn.area: widget.area,
  //   SheetsColumn.landline: widget.landline,
  //   SheetsColumn.mobile: widget.phoneNumber,
  //   SheetsColumn.nationalId: widget.nationalId,
  //   // SheetsColumn.nationalId: cnicTEController.text,
  // };
  // try {
  //   await FlutterSheets.insert([data]);
  // } catch (e) {
  //   rethrow;
  // }
  Future getSheets(
      {required String firstName,
      required String lastName,
      required String address,
      required String area,
      required String landline,
      required String phoneNumber,
      required String nationalId}) async {
    final data = {
      SheetsColumn.firstName: firstName,
      SheetsColumn.lastName: lastName,
      SheetsColumn.address: address,
      SheetsColumn.area: area,
      SheetsColumn.landline: landline,
      SheetsColumn.mobile: phoneNumber,
      SheetsColumn.nationalId: nationalId,
      SheetsColumn.frontImg: "${firstName}_frontImg",
      SheetsColumn.backImg: "${firstName}_backImg",
    };
    try {
      await FlutterSheets.insert([data]);
    } catch (e) {
      rethrow;
    }
  }
}
