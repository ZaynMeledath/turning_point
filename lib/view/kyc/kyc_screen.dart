import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/bloc/kyc/kyc_bloc.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/dialog/show_kyc_update_dialog.dart';
import 'package:turning_point/dialog/show_loading_dialog.dart';
import 'package:turning_point/utils/widget/custom_loading.dart';
import 'package:turning_point/utils/widget/my_app_bar.dart';
import 'package:turning_point/utils/screen_size.dart';
import 'package:turning_point/view/kyc/kyc_rejected_screen.dart';
import 'package:turning_point/view/kyc/kyc_submitted_screen.dart';
import 'package:turning_point/view/kyc/kyc_verified_screen.dart';
import 'package:turning_point/view/kyc/segments/kyc_bank_details.dart';
import 'package:turning_point/view/kyc/segments/kyc_id_proof.dart';
import 'package:turning_point/view/kyc/segments/kyc_page_title.dart';
import 'package:turning_point/view/kyc/segments/kyc_personal_details.dart';

class KycScreen extends StatefulWidget {
  final bool? avoidStatusCheck;
  const KycScreen({
    this.avoidStatusCheck,
    super.key,
  });

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
  final GlobalKey<FormState> _formKey = GlobalKey();

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
  void didChangeDependencies() {
    preloadBloc.add(ReelsScreenToggleEvent(isReelsVisible: false));
    if (preloadBloc.state.controllers.isNotEmpty) {
      preloadBloc.pauseCurrentController();
    }
    kycBloc.add(KycLoadEvent(
      tabIndex: 0,
      avoidStatusCheck: widget.avoidStatusCheck,
    ));
    super.didChangeDependencies();
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
    return BlocConsumer<KycBloc, KycState>(
      listener: (context, state) {
        if (state is KycLoadedState) {
          if (state.isLoading && closeDialogHandle == null) {
            closeDialogHandle = showLoadingDialog(context: context);
          }
        }
        if (state is KycLoadedState &&
            !state.isLoading &&
            closeDialogHandle != null) {
          Navigator.pop(context);
          closeDialogHandle = null;
        }
      },
      builder: (context, kycState) {
        switch (kycState) {
          //====================Loading State====================//
          case KycLoadingState():
            return Scaffold(
              body: spinningLinesLoading(),
            );

          //====================Error State====================//
          case KycErrorState():
            return Scaffold(
              appBar: myAppBar(context: context, title: 'KYC'),
              body: Center(
                child: Column(
                  children: [
                    SizedBox(height: screenSize.height * .2),
                    Lottie.asset(
                      'assets/lottie/no_internet_animation.json',
                      width: screenSize.width * .6,
                    ),
                    Text(
                      'Something Went Wrong',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .038,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            );

          //====================Submitted State====================//
          case KycSubmittedState():
            if (closeDialogHandle != null) {
              closeDialogHandle = null;
              Navigator.pop(context);
            }
            return const KycSubmittedScreen();

          //====================Verified State====================//
          case KycVerifiedState():
            return const KycVerifiedScreen();

          //====================Rejected State====================//
          case KycRejectedState():
            return const KycRejectedScreen();

          //====================Loaded State====================//
          case KycLoadedState():
            if (!kycState.isLoading) {
              nameController.text = kycState.name!;
              phoneController.text = kycState.phone!;
              emailController.text = kycState.email!;
              pinController.text = kycState.pincode!;
              if (profileBloc.state.userModel!.bankDetails != null &&
                  profileBloc.state.userModel!.bankDetails!.isNotEmpty &&
                  _tabController.index < 2) {
                final bankDetails =
                    profileBloc.state.userModel!.bankDetails![0];
                accNameController.text = bankDetails.accountName!;
                accNumController.text = bankDetails.accountNo!;
                ifscController.text = bankDetails.ifsc!;
              }
            }
            return Scaffold(
              appBar: myAppBar(
                context: context,
                title: 'KYC',
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                reverse: true,
                child: Column(
                  children: [
                    Column(
                      children: [
                        //====================Header Segment with Back Button, Title and Doodle ====================//

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
                          horizontal: realScreenSize.width * .031),
                      padding: EdgeInsets.only(
                        top: realScreenSize.height * .019,
                        bottom: realScreenSize.height * .015,
                      ),
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
                                horizontal: realScreenSize.width * .051),
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
                                    if (index > kycState.tabIndex) {
                                      _tabController.index = kycState.tabIndex;
                                    } else {
                                      context
                                          .read<KycBloc>()
                                          .add(KycLoadEvent(tabIndex: index));
                                    }
                                  },
                                  overlayColor: const MaterialStatePropertyAll(
                                      Colors.transparent),
                                  tabs: [
                                    kycPageTitle(
                                        title: 'Personal Details',
                                        titleNumber: '1',
                                        isDoneOrActive: true),
                                    kycPageTitle(
                                      title: 'ID Proof',
                                      titleNumber: '2',
                                      isDoneOrActive:
                                          kycState.tabIndex > 0 ? true : false,
                                    ),
                                    kycPageTitle(
                                      title: 'Bank Details',
                                      titleNumber: '3',
                                      isDoneOrActive:
                                          kycState.tabIndex > 1 ? true : false,
                                    ),
                                  ],
                                ),
                                Positioned(
                                  left: realScreenSize.width * .18,
                                  top: realScreenSize.width * .019,
                                  child: Container(
                                      width: realScreenSize.width * .18,
                                      height: 1,
                                      color: const Color.fromRGBO(
                                          199, 199, 199, 1)),
                                ),
                                Positioned(
                                  left: realScreenSize.width * .45,
                                  top: realScreenSize.width * .019,
                                  child: Container(
                                      width: realScreenSize.width * .18,
                                      height: 1,
                                      color: const Color.fromRGBO(
                                          199, 199, 199, 1)),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: realScreenSize.height * .03),

                          //====================TabBarView Segment====================//
                          Form(
                            key: _formKey,
                            child: SizedBox(
                              width: double.infinity,
                              height: screenSize.height * .385,
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
                                  kycIdProof(),
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
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenSize.height * .02),
                    GestureDetector(
                      onTap: () async {
                        if (_tabController.index == 1 &&
                            (kycState.idFrontImage == null ||
                                kycState.idBackImage == null)) {
                          return;
                        }
                        if (_formKey.currentState!.validate()) {
                          if (_tabController.index < 2) {
                            _tabController.animateTo(
                              kycState.tabIndex + 1,
                              curve: Curves.bounceInOut,
                              duration: const Duration(milliseconds: 200),
                            );
                            kycBloc.add(
                              KycLoadEvent(
                                tabIndex: _tabController.index,
                                name: nameController.text,
                                email: emailController.text,
                                pincode: pinController.text,
                              ),
                            );
                          } else {
                            final shouldUpdate =
                                await showKycUpdateDialog(context: context);
                            if (shouldUpdate == true) {
                              kycBloc.add(
                                KycUpdateEvent(
                                  isSavings: kycState.isSavings,
                                  accName: accNameController.text,
                                  accNum: accNumController.text,
                                  ifsc: ifscController.text,
                                ),
                              );
                            }
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
              ),
            );
        }
      },
    );
  }
}

  // bool validate() {
  //   if (nameController.text.isNotEmpty &&
  //       phoneController.text.isNotEmpty &&
  //       emailController.text.isNotEmpty &&
  //       pinController.text.isNotEmpty &&
  //       accNameController.text.isNotEmpty &&
  //       accNumController.text.isNotEmpty &&
  //       ifscController.text.isNotEmpty &&
  //       confirmAccNumController.text.isNotEmpty) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

