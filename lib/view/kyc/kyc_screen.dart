import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/kyc/kyc_bloc.dart';
import 'package:turning_point/dialog/show_generic_dialog.dart';
import 'package:turning_point/dialog/show_loading_dialog.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/kyc/kyc_submitted_screen.dart';
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
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController pinController;
  late final TextEditingController accNameController;
  late final TextEditingController accNumController;
  late final TextEditingController confirmAccNumController;
  late final TextEditingController ifscController;
  late final TabController _tabController;

  dynamic closeDialogHandle;

  @override
  void initState() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
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
    phoneController.dispose();
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
    kycBloc.add(KycLoadEvent(tabIndex: 0));
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<KycBloc, KycState>(
          listener: (context, state) {
            if (state is KycLoadedState) {
              if (state.isLoading && closeDialogHandle == null) {
                closeDialogHandle = showLoadingDialog(context: context);
              }
            } else if (state is KycSubmittedState &&
                closeDialogHandle != null) {
              Navigator.pop(context);
              closeDialogHandle = null;
            }
          },
          builder: (context, state) {
            switch (state) {
//====================Loading State====================//
              case KycLoadingState():
                return const Center(
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 5,
                  ),
                );

//====================Loaded State====================//
              case KycSubmittedState():
                return const KycSubmittedScreen();

//====================Loaded State====================//
              case KycLoadedState():
                nameController.text = state.name!;
                phoneController.text = state.phone!;
                emailController.text = state.email!;
                pinController.text = state.pincode!;
                // accNameController.text = state.

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                  child: Column(
                    children: [
                      Column(
                        children: [
//====================Header Segment with Back Button, Title and Doodle ====================//
                          customAppBar(
                            context: context,
                            title: 'KYC',
                          ),
                          SizedBox(height: screenSize.height * .01),
                          Image.asset(
                            'assets/images/kyc_doodle.png',
                            width: screenSize.width * .45,
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * .02),

//===================================Body Container===================================//
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenSize.width * .031),
                        padding: EdgeInsets.symmetric(
                            vertical: screenSize.height * .019),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(
                            color: const Color.fromRGBO(226, 226, 226, 1),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    onTap: (index) {
                                      if (index > state.tabIndex) {
                                        _tabController.index = state.tabIndex;
                                      } else {
                                        context
                                            .read<KycBloc>()
                                            .add(KycLoadEvent(tabIndex: index));
                                      }
                                    },
                                    overlayColor:
                                        const MaterialStatePropertyAll(
                                            Colors.transparent),
                                    tabs: [
                                      kycPageTitle(
                                          screenSize: screenSize,
                                          title: 'Personal Details',
                                          titleNumber: '1',
                                          isDoneOrActive: true),
                                      kycPageTitle(
                                        screenSize: screenSize,
                                        title: 'ID Proof',
                                        titleNumber: '2',
                                        isDoneOrActive:
                                            state.tabIndex > 0 ? true : false,
                                      ),
                                      kycPageTitle(
                                        screenSize: screenSize,
                                        title: 'Bank Details',
                                        titleNumber: '3',
                                        isDoneOrActive:
                                            state.tabIndex > 1 ? true : false,
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    left: screenSize.width * .18,
                                    top: screenSize.width * .019,
                                    child: Container(
                                        width: screenSize.width * .18,
                                        height: 1,
                                        color: const Color.fromRGBO(
                                            199, 199, 199, 1)),
                                  ),
                                  Positioned(
                                    left: screenSize.width * .45,
                                    top: screenSize.width * .019,
                                    child: Container(
                                        width: screenSize.width * .18,
                                        height: 1,
                                        color: const Color.fromRGBO(
                                            199, 199, 199, 1)),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: screenSize.height * .035),

                            //====================TabBarView Segment====================//
                            SizedBox(
                              width: double.infinity,
                              height: screenSize.height * .4,
                              child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: _tabController,
                                children: [
                                  kycPersonalDetails(
                                    screenSize: screenSize,
                                    nameController: nameController,
                                    mobileController: phoneController,
                                    emailController: emailController,
                                    pinController: pinController,
                                  ),
                                  kycIdProof(screenSize: screenSize),
                                  kycBankDetails(
                                    screenSize: screenSize,
                                    accNameController: accNameController,
                                    accNumController: accNumController,
                                    confirmAccNumController:
                                        confirmAccNumController,
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
                          if (_tabController.index == 1 &&
                              (state.idFrontImage == null ||
                                  state.idBackImage == null)) {
                            return;
                          }
                          if (_tabController.index < 2) {
                            _tabController.animateTo(
                              state.tabIndex + 1,
                              curve: Curves.bounceInOut,
                              duration: const Duration(milliseconds: 200),
                            );
                            kycBloc.add(KycLoadEvent(
                              tabIndex: _tabController.index,
                              name: nameController.text,
                              email: emailController.text,
                              pincode: pinController.text,
                            ));
                          } else {
                            if (validate()) {
                              kycBloc.add(
                                KycUpdateEvent(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  pincode: pinController.text,
                                  isSavings: state.isSavings,
                                  accName: accNameController.text,
                                  accNum: accNumController.text,
                                  ifsc: ifscController.text,
                                ),
                              );
                            } else {
                              showGenericDialog(
                                context: context,
                                title: 'Fields Empty',
                                content: 'Please fill up all the fields',
                                options: {'Dismiss': null},
                              );
                            }
                          }
                        },
                        child: Container(
                          width: screenSize.width * .38,
                          height: screenSize.width * .102,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color.fromRGBO(0, 99, 255, 1),
                          ),
                          child: Center(
                            child: Text(
                              _tabController.index == 2 ? 'Submit' : 'Next',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: screenSize.width * .036,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * .018)
                    ],
                  ),
                );

              default:
                return Center(
                  child: Text(
                    'Something Went Wrong',
                    style: GoogleFonts.poppins(
                      fontSize: screenSize.width * .05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  bool validate() {
    if (nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        pinController.text.isNotEmpty &&
        accNameController.text.isNotEmpty &&
        accNumController.text.isNotEmpty &&
        ifscController.text.isNotEmpty &&
        confirmAccNumController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
