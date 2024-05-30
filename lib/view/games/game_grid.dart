part of 'games_home_screen.dart';

Widget gameGrid({
  required int gameIndex,
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: () {
      CustomNavigator.push(
        context: context,
        child: Games.gameModelList[gameIndex].gameWidget,
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            blurStyle: BlurStyle.outer,
          )
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                Games.gameModelList[gameIndex].thumbnailPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenSize.width * .011),
            child: Text(
              Games.gameModelList[gameIndex].name,
              style: GoogleFonts.poppins(
                fontSize: screenSize.width * .034,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
