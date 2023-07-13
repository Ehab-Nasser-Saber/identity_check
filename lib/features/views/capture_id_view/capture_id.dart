import 'dart:developer';
import 'package:identity_check/features/widgets/capture_id_widgets/google_sheet_button.dart';
import '../../widgets/exports/capture_id_imports.dart';

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
                  const Text("Please Scan the front/back ID In order"),
                  Center(
                    child: ElevatedButton(
                      onPressed:
                          imagePathFrontId != null && imagePathBackId != null
                              ? null
                              : getImageFromCamera,
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
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  GoogleSheetButton(
                      address: widget.address,
                      area: widget.area,
                      firstName: widget.firstName,
                      phoneNumber: widget.phoneNumber,
                      landline: widget.landline,
                      lastName: widget.lastName,
                      nationalId: widget.nationalId,
                      imagePathFrontId: imagePathFrontId,
                      imagePathBackId: imagePathBackId)
                  // LoginButton(
                  //     padding: const EdgeInsets.symmetric(horizontal: 30),
                  //     screenHeight: screenHeight,
                  //     screenWidth: screenWidth,
                  //     title: "Submit GoogleSheet",
                  //     onPressed:
                  //         imagePathFrontId != null && imagePathBackId != null
                  //             ? () {
                  //                 getSheets(
                  // address: widget.address,
                  // area: widget.area,
                  // firstName: widget.firstName,
                  // phoneNumber: widget.phoneNumber,
                  // landline: widget.landline,
                  // lastName: widget.lastName,
                  // nationalId: widget.nationalId);
                  //                 // Navigator.push(
                  //                 //   context,
                  //                 //   MaterialPageRoute(
                  //                 //       builder: (context) =>
                  //                 //           const HomePageView()),
                  //                 // );
                  //               }
                  //             : null),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Functions
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

    try {
      bool success = await EdgeDetection.detectEdge(
        imagePath,
        canUseGallery: true,
        androidScanTitle: 'Scanning',
        androidCropTitle: 'Crop',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );
      log("success: $success");
    } catch (e) {
      rethrow;
    }

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
  }
}
