import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/kyc/kyc_bloc.dart';
import 'package:turning_point/view/kyc/segments/kyc_text_field_segment.dart';

Widget kycBankDetails({
  required Size screenSize,
  required TextEditingController accNameController,
  required TextEditingController accNumController,
  required TextEditingController confirmAccNumController,
  required TextEditingController ifscController,
}) {
  return BlocBuilder<KycBloc, KycState>(
    builder: (context, state) {
      if (state is KycLoadedState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => context
                      .read<KycBloc>()
                      .add(KycAccountTypeTriggerEvent(isSavings: true)),
                  child: Container(
                    width: screenSize.width * .16,
                    height: screenSize.width * .056,
                    margin: EdgeInsets.only(left: screenSize.width * .041),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: state.isSavings ? const Color(0xff3769A5) : null,
                      border: Border.all(
                        color: const Color(0xff3769A5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Saving A/C',
                        style: GoogleFonts.roboto(
                          fontSize: screenSize.width * .021,
                          fontWeight: FontWeight.bold,
                          color: state.isSavings ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => context
                      .read<KycBloc>()
                      .add(KycAccountTypeTriggerEvent(isSavings: false)),
                  child: Container(
                    width: screenSize.width * .16,
                    height: screenSize.width * .056,
                    margin: EdgeInsets.only(left: screenSize.width * .031),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: state.isSavings ? null : const Color(0xff3769A5),
                      border: Border.all(
                        color: const Color(0xff3769A5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Current A/C',
                        style: GoogleFonts.roboto(
                          fontSize: screenSize.width * .021,
                          fontWeight: FontWeight.bold,
                          color: state.isSavings ? Colors.grey : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            kycTextFieldSegment(
              screenSize: screenSize,
              controller: accNameController,
              title: 'Account Name',
            ),
            SizedBox(height: screenSize.height * .03),
            kycTextFieldSegment(
              screenSize: screenSize,
              controller: accNumController,
              title: 'Account Number',
              isNum: true,
            ),
            SizedBox(height: screenSize.height * .03),
            kycTextFieldSegment(
              screenSize: screenSize,
              controller: confirmAccNumController,
              title: 'Confirm Account Number',
              isNum: true,
            ),
            SizedBox(height: screenSize.height * .03),
            kycTextFieldSegment(
              screenSize: screenSize,
              controller: ifscController,
              title: 'IFSC',
            ),
          ],
        );
      } else {
        return const Center(
          child: CircularProgressIndicator.adaptive(
            strokeWidth: 5,
          ),
        );
      }
    },
  );
}
