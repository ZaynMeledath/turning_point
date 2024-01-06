part of '../sign_up_screen.dart';

Widget signUpTextField({
  required TextEditingController controller,
  required String title,
  required String iconPath,
}) {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: screenSize.width * .036,
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(.9),
          ),
        ),
        SizedBox(height: screenSize.height * .01),
        //====================TextField Container====================//
        Container(
          width: double.infinity,
          height: screenSize.height * .056,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            // color: const Color.fromRGBO(246, 246, 246, 1),
            borderRadius: BorderRadius.circular(8.5),
            border: Border.all(
              color: Colors.black.withOpacity(.25),
              width: .8,
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(-2, 2),
                blurRadius: 2,
                color: Colors.black.withOpacity(.25),
                blurStyle: BlurStyle.normal,
              ),
            ],
          ),
          //====================TextField====================//
          child: Row(
            children: [
              Image.asset(
                iconPath,
                width: screenSize.width * .04,
              ),
              SizedBox(width: screenSize.width * .031),
              Flexible(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
