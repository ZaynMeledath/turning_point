part of '../carpenters_list_screen.dart';

Widget carpenterCard({required CarpenterModel carpenterModel}) {
  return Container(
    margin: EdgeInsets.only(bottom: screenSize.height * .018),
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .026),
    height: screenSize.height * .07,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, 1),
          blurRadius: 4,
          color: Colors.black.withOpacity(.07),
        )
      ],
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: screenSize.width * .05,
          backgroundImage: const AssetImage('assets/images/avatar.jpg'),
        ),
        SizedBox(width: screenSize.width * .05),
        Expanded(
          child: Text(
            'Zayn Meledath',
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: screenSize.width * .036,
              fontWeight: FontWeight.w500,
              color: const Color(0xff000B18),
            ),
          ),
        ),
        Container(
          height: screenSize.height * .03,
          padding: const EdgeInsets.only(
            left: 2,
            right: 6,
            top: 3,
            bottom: 3,
          ),
          margin: EdgeInsets.only(
            right: screenSize.width * .015,
            left: screenSize.width * .02,
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
                '760',
                style: GoogleFonts.inter(
                  fontSize: screenSize.width * .031,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
