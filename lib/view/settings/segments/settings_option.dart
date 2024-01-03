part of '../settings_screen.dart';

Widget settingsOption({
  required String iconPath,
  required String title,
  bool? isEnabled,
}) {
  return SizedBox(
    height: screenSize.height * .06,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              iconPath,
              width: screenSize.width * .06,
            ),
            SizedBox(width: screenSize.width * .051),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: screenSize.width * .04,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Visibility(
          visible: isEnabled != null,
          child: Transform.scale(
            scale: .8,
            child: Switch.adaptive(
              value: isEnabled ?? false,
              onChanged: (value) {},
            ),
          ),
        )
      ],
    ),
  );
}
