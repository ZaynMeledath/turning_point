import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/view/kyc/segments/kyc_bank_details.dart';
import 'package:turning_point/view/kyc/segments/kyc_id_proof.dart';
import 'package:turning_point/view/kyc/segments/kyc_page_title.dart';
import 'package:turning_point/view/kyc/segments/kyc_personal_details.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen>
    with SingleTickerProviderStateMixin {
  late final TextEditingController nameController;
  late final TextEditingController mobileController;
  late final TextEditingController emailController;
  late final TextEditingController pinController;
  late final TextEditingController accNameController;
  late final TextEditingController accNumController;
  late final TextEditingController confirmAccNumController;
  late final TextEditingController ifscController;
  late final TabController _tabController;

  @override
  void initState() {
    nameController = TextEditingController();
    mobileController = TextEditingController();
    emailController = TextEditingController();
    pinController = TextEditingController();
    accNameController = TextEditingController();
    accNumController = TextEditingController();
    confirmAccNumController = TextEditingController();
    ifscController = TextEditingController();
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    pinController.dispose();
    accNameController.dispose();
    accNumController.dispose();
    confirmAccNumController.dispose();
    ifscController.dispose();
    _tabController.dispose();
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
              Column(
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
                        horizontal: screenSize.width * .12),
                    child: Image.asset('assets/images/kyc_doodle.png'),
                  ),
                  SizedBox(height: screenSize.height * .03),
                ],
              ),
              SizedBox(height: screenSize.height * .015),

//====================Body Container====================//
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: screenSize.width * .041),
                padding:
                    EdgeInsets.symmetric(vertical: screenSize.width * .041),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(
                    color: const Color.fromRGBO(226, 226, 226, 1),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * .051),
                      child: Stack(
                        children: [
                          TabBar(
                            controller: _tabController,
                            indicator: const BoxDecoration(),
                            isScrollable: false,
                            labelColor: Colors.black,
                            dividerColor: Colors.transparent,
                            physics: const NeverScrollableScrollPhysics(),
                            onTap: (index) {
                              setState(() {});
                            },
                            overlayColor: const MaterialStatePropertyAll(
                                Colors.transparent),
                            tabs: [
                              kycPageTitle(
                                screenSize: screenSize,
                                title: 'Personal Details',
                                titleNumber: '1',
                                isDoneOrActive: _tabController.index == 0 ||
                                        _tabController.index == 1 ||
                                        _tabController.index == 2
                                    ? true
                                    : false,
                              ),
                              kycPageTitle(
                                screenSize: screenSize,
                                title: 'ID Proof',
                                titleNumber: '2',
                                isDoneOrActive: _tabController.index == 1 ||
                                        _tabController.index == 2
                                    ? true
                                    : false,
                              ),
                              kycPageTitle(
                                screenSize: screenSize,
                                title: 'Bank Details',
                                titleNumber: '3',
                                isDoneOrActive:
                                    _tabController.index == 2 ? true : false,
                              ),
                            ],
                          ),
                          Positioned(
                            left: screenSize.width * .18,
                            top: screenSize.width * .019,
                            child: Container(
                                width: screenSize.width * .18,
                                height: 1,
                                color: const Color.fromRGBO(199, 199, 199, 1)),
                          ),
                          Positioned(
                            left: screenSize.width * .45,
                            top: screenSize.width * .019,
                            child: Container(
                                width: screenSize.width * .18,
                                height: 1,
                                color: const Color.fromRGBO(199, 199, 199, 1)),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: screenSize.height * .035),

//====================TabBarView Segment====================//
                    SizedBox(
                      width: double.infinity,
                      height: screenSize.height * .37,
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: [
                          kycPersonalDetails(
                            screenSize: screenSize,
                            nameController: nameController,
                            mobileController: mobileController,
                            emailController: emailController,
                            pinController: pinController,
                          ),
                          kycIdProof(screenSize: screenSize),
                          kycBankDetails(
                            screenSize: screenSize,
                            accNameController: accNameController,
                            accNumController: accNumController,
                            confirmAccNumController: confirmAccNumController,
                            ifscController: ifscController,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height * .02),
              GestureDetector(
                onTap: () {
                  _tabController.animateTo(
                    _tabController.index + 1,
                    curve: Curves.bounceInOut,
                    duration: const Duration(milliseconds: 200),
                  );
                  setState(() {});
                },
                child: Container(
                  width: screenSize.width * .38,
                  height: screenSize.width * .102,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color.fromRGBO(0, 189, 190, 1),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
