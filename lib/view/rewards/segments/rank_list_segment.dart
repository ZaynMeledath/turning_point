import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final rankList = [
  'Sam',
  'Karen',
  'Anastasia',
  'Jacob',
  'Mathew',
  'Annie',
  'Cindy',
  'Eva',
  'Eden',
  'Sam',
  'Karen',
  'Anastasia',
  'Jacob',
  'Mathew',
  'Annie',
  'Cindy',
  'Eva',
  'Eden',
];

Widget rankListSegment({
  required Size screenSize,
  required int index,
}) {
  return Column(
    children: [
      ListTile(
        contentPadding: EdgeInsets.symmetric(
          vertical: screenSize.height * .014,
          horizontal: screenSize.width * .061,
        ),
        horizontalTitleGap: screenSize.width * .04,
        leading: Text(
          '#${index + 4}',
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .036,
            fontWeight: FontWeight.w500,
          ),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
            SizedBox(width: screenSize.width * .04),
            Text(
              rankList[index],
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .035,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        trailing: Container(
          width: screenSize.width * .17,
          height: screenSize.height * .03,
          padding: const EdgeInsets.only(
            left: 2,
            right: 6,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromRGBO(255, 215, 0, 1),
                Color.fromRGBO(255, 238, 141, 1),
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/icons/coin_icon.png',
                width: 29,
              ),
              Text(
                '100',
                style: GoogleFonts.inter(
                  fontSize: screenSize.width * .031,
                  fontWeight: FontWeight.w800,
                ),
              )
            ],
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(
          left: screenSize.width * .18,
          right: screenSize.width * .064,
        ),
        decoration: BoxDecoration(
            border: Border.all(
                width: .5, color: const Color.fromRGBO(199, 199, 199, 1))),
      ),
    ],
  );
}
