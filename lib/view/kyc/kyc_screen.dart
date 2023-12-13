import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/text_field_segment.dart';
import 'package:turning_point/view/kyc/segments/kyc_page_title.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _mobileController;
  late final TextEditingController _emailController;
  late final TextEditingController _pinController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _mobileController = TextEditingController();
    _emailController = TextEditingController();
    _pinController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          reverse: true,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(255, 252, 248, 1),
                        Color.fromRGBO(212, 231, 255, 1),
                      ]),
                ),
                child: Column(
                  children: [
//====================Header Segment width Back Button, Title and Doodle ====================//
                    SizedBox(height: screenSize.height * .009),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * .03),
                      child: Row(
                        children: [
                          Hero(
                            tag: 'back_button',
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                size: screenSize.height * .033,
                              ),
                              onPressed: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          SizedBox(width: screenSize.width * .041),
                          Hero(
                            tag: 'KYC',
                            child: Text(
                              'KYC',
                              style: GoogleFonts.inter(
                                fontSize: screenSize.width * .041,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * .1),
                      child: Image.asset('assets/images/kyc_doodle.png'),
                    ),
                    SizedBox(height: screenSize.height * .03),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height * .024),

//====================Page Titles Segment====================//
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * .041),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    kycPageTitle(
                      screenSize: screenSize,
                      title: 'Personal Details',
                      isDoneOrActive: true,
                    ),
                    kycPageTitle(
                      screenSize: screenSize,
                      title: 'ID Proof',
                      isDoneOrActive: false,
                    ),
                    kycPageTitle(
                      screenSize: screenSize,
                      title: 'Bank Details',
                      isDoneOrActive: false,
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height * .038),

//====================TextField Segment====================//
              textFieldSegment(
                screenSize: screenSize,
                controller: _nameController,
                title: 'Name',
              ),
              SizedBox(height: screenSize.height * .037),
              textFieldSegment(
                screenSize: screenSize,
                controller: _mobileController,
                title: 'Mobile Number',
              ),
              SizedBox(height: screenSize.height * .037),
              textFieldSegment(
                screenSize: screenSize,
                controller: _emailController,
                title: 'Email',
              ),
              SizedBox(height: screenSize.height * .037),
              textFieldSegment(
                screenSize: screenSize,
                controller: _pinController,
                title: 'Pincode',
              ),
              SizedBox(height: screenSize.height * .065),
              Container(
                width: screenSize.width * .38,
                height: screenSize.width * .102,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black,
                ),
                child: Center(
                  child: Text(
                    'Next',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: screenSize.width * .036,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
