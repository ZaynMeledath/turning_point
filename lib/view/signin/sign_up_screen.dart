import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/auth/auth_bloc.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_radio_button.dart';
import 'package:turning_point/view/signin/otp_verfication_screen.dart';

part 'segments/sign_up_text_field.dart';
part 'segments/sign_up_radio_button_segment.dart';

class SignUpScreen extends StatefulWidget {
  final bool isContractor;
  const SignUpScreen({
    required this.isContractor,
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late bool isContractor;
  int activeRadioNumber = 1;
  String? selectedValue;

  late final TextEditingController mobileController;
  late final TextEditingController businessController;
  late final TextEditingController searchController;

  @override
  void initState() {
    isContractor = widget.isContractor;
    mobileController = TextEditingController();
    businessController = TextEditingController();
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    mobileController.dispose();
    businessController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is OtpVerificationNeededState) {
          CustomNavigator.push(
            context: context,
            child: const OtpVerificationScreen(),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * .05),
              child: Column(
                children: [
                  SizedBox(height: screenSize.height * .13),

                  //====================Furnipart Logo====================//
                  Hero(
                    tag: 'furnipart_logo',
                    child: Image.asset(
                      'assets/images/furnipart_logo.png',
                      width: screenSize.width * .32,
                      height: screenSize.height * .086,
                    ),
                  ),
                  SizedBox(height: screenSize.height * .045),

                  //====================Title====================//
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sign up to start\nEarning...',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .084,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .015),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Join Our Community by Creating\nYour Personalized Account.',
                      style: GoogleFonts.inter(
                        fontSize: screenSize.width * .036,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(135, 135, 135, 1),
                      ),
                    ),
                  ),

                  //====================TextField Segment====================//
                  SizedBox(height: screenSize.height * .028),
                  signUpTextField(
                      controller: mobileController,
                      title: 'Mobile Number',
                      iconPath: 'assets/icons/sign_up_phone_icon.png'),
                  SizedBox(height: screenSize.height * .03),
                  isContractor
                      ? signUpTextField(
                          controller: businessController,
                          title: 'Business Name',
                          iconPath: 'assets/icons/sign_up_phone_icon.png')
                      : dropDownContainer(searchController: searchController),
                  Visibility(
                    visible: !isContractor,
                    child: Column(
                      children: [
                        SizedBox(height: screenSize.height * .035),

                        //====================Radio Button====================//
                        signUpRadioButtonSegment(
                            title: 'My contractor is not listed',
                            isActive: true),
                        SizedBox(height: screenSize.height * .02),
                        signUpRadioButtonSegment(
                            title: "I don't have a contractor",
                            isActive: false),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: screenSize.height * .05,
                  ),

                  //====================Sign Up Button====================//
                  GestureDetector(
                    onTap: () {
                      context.read<AuthBloc>().add(
                            SignUpEvent(mobileNumber: mobileController.text),
                          );
                    },
                    child: Hero(
                      tag: 'sign_in_sign_up_container',
                      child: Container(
                        width: double.infinity,
                        height: screenSize.width * .13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromRGBO(52, 110, 241, 1),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 1,
                              color: Color.fromRGBO(0, 0, 0, .17),
                            ),
                            BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 1,
                              color: Color.fromRGBO(0, 0, 0, .08),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.roboto(
                              fontSize: screenSize.width * .036,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .01),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//====================Contractor Drop Down====================//

  Widget dropDownContainer({required TextEditingController searchController}) {
    final contractorList = ['JOHN', 'JACOB', 'SEAN', 'ADHIL'];
    return Container(
      width: double.infinity,
      height: screenSize.height * .052,
      margin: EdgeInsets.symmetric(horizontal: screenSize.width * .005),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(-2, 2),
            blurRadius: 2,
            color: Colors.black.withOpacity(.25),
            blurStyle: BlurStyle.normal,
          ),
        ],
        border: Border.all(
          width: .8,
          color: const Color.fromRGBO(214, 214, 214, 1),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            'Select Contractor',
            style: GoogleFonts.roboto(
              fontSize: screenSize.width * .032,
              color: const Color.fromRGBO(16, 16, 16, .8),
            ),
          ),
          items: contractorList
              .map(
                (item) => DropdownMenuItem(
                  value: item.toUpperCase(),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 6,
                    ),
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      item.toUpperCase(),
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .036,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
          },
          buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * .041),
            width: 0,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: screenSize.height * .3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            height: screenSize.height * .047,
          ),
          dropdownSearchData: DropdownSearchData(
            searchController: searchController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 40,
              padding: EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: screenSize.width * .02,
                left: 8,
              ),
              margin: EdgeInsets.all(screenSize.width * .02),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 1,
                    color: Colors.black.withOpacity(.25),
                    blurStyle: BlurStyle.normal,
                  ),
                ],
              ),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: searchController,
                style: GoogleFonts.roboto(
                  fontSize: screenSize.width * .034,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  hintText: 'Search for the contractor...',
                  hintStyle: GoogleFonts.roboto(
                    fontSize: screenSize.width * .034,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              return item.value
                  .toString()
                  .toUpperCase()
                  .contains(searchValue.toUpperCase());
            },
          ),
          //This to clear the search value when you close the menu
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              searchController.clear();
            }
          },
        ),
      ),
    );
  }
}
