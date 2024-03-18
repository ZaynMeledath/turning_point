part of '../edit_profile_screen.dart';

Widget contractorDropDownLoadingStateContainer() {
  return Container(
    width: realScreenSize.width,
    height: realScreenSize.height * .052,
    margin: EdgeInsets.symmetric(horizontal: screenSize.width * .041),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          offset: const Offset(-.5, .5),
          blurRadius: .5,
          color: Colors.black.withOpacity(.2),
        ),
      ],
      border: Border.all(
        width: .8,
        color: const Color.fromRGBO(214, 214, 214, 1),
      ),
    ),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: screenSize.width * .028),
          child: Text(
            'Contractor List Loading...',
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
                letterSpacing: 1,
                fontSize: screenSize.width * .034,
                color: Colors.grey.withOpacity(.6)),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: screenSize.width * .1,
              height: screenSize.width * .12,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(8),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.grey.withOpacity(.6),
                  size: screenSize.width * .08,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
