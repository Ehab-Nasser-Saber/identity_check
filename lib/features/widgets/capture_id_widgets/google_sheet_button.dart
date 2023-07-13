import 'package:flutter/material.dart';

import '../../../flutter_sheets/flutter_sheets.dart';
import '../../../flutter_sheets/sheets_column.dart';
import '../../../util/snackbar_message.dart';
import '../../views/home_page_view/home_page.dart';
import '../home_page_widgets/login_button.dart';

class GoogleSheetButton extends StatelessWidget {
  final String? firstName,
      lastName,
      address,
      landline,
      phoneNumber,
      area,
      nationalId,
      imagePathFrontId,
      imagePathBackId;
  const GoogleSheetButton(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.address,
      required this.landline,
      required this.phoneNumber,
      required this.area,
      required this.nationalId,
      required this.imagePathFrontId,
      required this.imagePathBackId});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return LoginButton(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        title: "Submit GoogleSheet",
        onPressed: imagePathFrontId != null && imagePathBackId != null
            ? () {
                getSheets(
                    address: address!,
                    area: area!,
                    firstName: firstName!,
                    phoneNumber: phoneNumber!,
                    landline: landline!,
                    lastName: lastName!,
                    nationalId: nationalId!,
                    context: context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePageView()),
                );
              }
            : null);
  }

  Future getSheets(
      {required String firstName,
      required String lastName,
      required String address,
      required String area,
      required String landline,
      required String phoneNumber,
      required String nationalId,
      required context}) async {
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
      SnackBarMessage().showSuccessSnackBar(
          message: "You've Submitted Your Info Successfully!",
          context: context);
    } catch (e) {
      SnackBarMessage()
          .showErrorSnackBar(message: "Something Went Wrong", context: context);
      rethrow;
    }
  }
}
