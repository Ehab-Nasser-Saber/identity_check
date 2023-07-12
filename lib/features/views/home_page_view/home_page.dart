import '../../widgets/exports/home_page_imports.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController landLineController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();

  bool validateFirstName = false;
  bool validateLastName = false;
  bool validateLandline = false;
  bool validateId = false;

  String validateFirstNameText = "";
  String validateLastNameText = "";
  String validateLandlineText = "";
  String validateIdText = "";
  String? value;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    landLineController.dispose();
    phoneNumberController.dispose();
    nationalIdController.dispose();
    super.dispose();
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
            'Please Enter Your Info',
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: true,
        body: Stack(
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
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    CustomTextFieldValidation(
                      validate: validateFirstName,
                      textEditingController: firstNameController,
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      hintText: "Your First Name",
                      labelText: "First Name",
                      errorText: validateFirstName ? validateFirstNameText : "",
                      onEditingComplete: () async {
                        FocusScope.of(context).unfocus();
                      },
                      onChanged: (value) {
                        firstNameCheck();
                      },
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    CustomTextFieldValidation(
                      validate: validateLastName,
                      textEditingController: lastNameController,
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      hintText: "Your Last Name",
                      labelText: "Last Name",
                      errorText: validateLastName ? validateLastNameText : "",
                      onEditingComplete: () async {
                        FocusScope.of(context).unfocus();
                      },
                      onChanged: (value) {
                        lastNameCheck();
                      },
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    CustomTextFieldValidation(
                      validate: validateId,
                      textEditingController: nationalIdController,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      hintText: "Your ID",
                      labelText: "National ID",
                      errorText: validateId ? validateIdText : "",
                      onEditingComplete: () async {
                        FocusScope.of(context).unfocus();
                      },
                      onChanged: (value) {
                        idCheck();
                      },
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    CustomTextFieldValidation(
                      validate: validateLandline,
                      textEditingController: landLineController,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      hintText: "Your Number",
                      labelText: "Landline Number",
                      errorText: validateLandline ? validateLandlineText : "",
                      onEditingComplete: () async {
                        FocusScope.of(context).unfocus();
                      },
                      onChanged: (value) {
                        landLineCheck();
                      },
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    CustomTextFieldValidation(
                      textEditingController: addressController,
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      hintText: "Enter Address",
                      labelText: "Address",
                      onEditingComplete: () async {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      width: screenWidth * 0.9,
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryColor, width: 1)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: value,
                          items: cities.map(buildMenuItem).toList(),
                          onChanged: (value) =>
                              setState(() => this.value = value),
                          isExpanded: true,
                          menuMaxHeight: 300,
                          hint: const Text("Area"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    SizedBox(
                      width: screenWidth * 0.9,
                      child: IntlPhoneField(
                        controller: phoneNumberController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        languageCode: "en",
                        initialCountryCode: "EG",
                        onChanged: (phone) {},
                        onCountryChanged: (country) {},
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    LoginButton(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        title: "Save & Continue",
                        onPressed: firstNameController.text.isNotEmpty &&
                                lastNameController.text.isNotEmpty &&
                                addressController.text.isNotEmpty &&
                                landLineController.text.isNotEmpty &&
                                phoneNumberController.text.isNotEmpty &&
                                value != null
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CaptureIdView(
                                            firstName:
                                                firstNameController.text.trim(),
                                            lastName:
                                                lastNameController.text.trim(),
                                            landline: landLineController.text,
                                            address:
                                                addressController.text.trim(),
                                            phoneNumber:
                                                phoneNumberController.text,
                                            area: value.toString(),
                                            nationalId:
                                                nationalIdController.text,
                                          )),
                                );
                              }
                            : null),
                    SizedBox(
                      height: screenHeight * 0.02,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
      );

  //validation
  void firstNameCheck() {
    if (firstNameController.text.isEmpty) {
      setState(() {
        validateFirstName = true;
        validateFirstNameText = "field is empty";
      });
    } else if (!firstNameController.text.isValidName) {
      setState(() {
        validateFirstName = true;
        validateFirstNameText = "Please enter a valid name";
      });
    } else if (firstNameController.text.isValidName) {
      setState(() {
        validateFirstName = false;
        validateFirstNameText = "";
      });
    } else {
      setState(() {
        validateFirstName = false;
        validateFirstNameText = "";
      });
    }
  }

  void lastNameCheck() {
    if (lastNameController.text.isEmpty) {
      setState(() {
        validateLastName = true;
        validateLastNameText = "field is empty";
      });
    } else if (!lastNameController.text.isValidName) {
      setState(() {
        validateLastName = true;
        validateLastNameText = "Please enter a valid name";
      });
    } else if (lastNameController.text.isValidName) {
      setState(() {
        validateLastName = false;
        validateLastNameText = "";
      });
    } else {
      setState(() {
        validateLastName = false;
        validateLastNameText = "";
      });
    }
  }

  void landLineCheck() {
    if (landLineController.text.isEmpty) {
      setState(() {
        validateLandline = true;
        validateLandlineText = "field is empty";
      });
    } else if (!landLineController.text.isValidLandline) {
      setState(() {
        validateLandline = true;
        validateLandlineText = "Please enter a valid number";
      });
    } else if (landLineController.text.isValidLandline) {
      setState(() {
        validateLandline = false;
        validateLandlineText = "";
      });
    } else {
      setState(() {
        validateLandline = false;
        validateLandlineText = "";
      });
    }
  }

  void idCheck() {
    if (nationalIdController.text.isEmpty) {
      setState(() {
        validateId = true;
        validateIdText = "field is empty";
      });
    } else if (!nationalIdController.text.isValidId) {
      setState(() {
        validateId = true;
        validateIdText = "Please enter a valid Id";
      });
    } else if (nationalIdController.text.isValidId) {
      setState(() {
        validateId = false;
        validateIdText = "";
      });
    } else {
      setState(() {
        validateId = false;
        validateIdText = "";
      });
    }
  }
}
