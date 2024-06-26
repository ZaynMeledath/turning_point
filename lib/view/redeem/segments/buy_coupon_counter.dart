part of '../redeem_screen.dart';

Widget buyCouponCounter({required int contestIndex}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        children: [
          InkWell(
            onTap: () => contestBloc
                .add(ContestEntryDecrementEvent(contestIndex: contestIndex)),
            child: Container(
              width: screenSize.width * .068,
              height: screenSize.width * .068,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Colors.black.withOpacity(.15),
                ),
              ),
              child: Center(
                child: Text(
                  '-',
                  style: GoogleFonts.poppins(
                    fontSize: screenSize.width * .036,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: screenSize.width * .015),
          InkWell(
            onTap: () => contestBloc
                .add(ContestEntryIncrementEvent(contestIndex: contestIndex)),
            child: Container(
              width: screenSize.width * .068,
              height: screenSize.width * .068,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Colors.black.withOpacity(.15),
                ),
              ),
              child: Center(
                child: Text(
                  '+',
                  style: GoogleFonts.poppins(
                    fontSize: screenSize.width * .036,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: screenSize.height * .005),
      BlocBuilder<ContestBloc, ContestState>(builder: (context, state) {
        return Container(
          width: screenSize.width * .14,
          height: screenSize.width * .042,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.black.withOpacity(.15),
            ),
          ),
          child: Center(
            child: Text(
              state.entryCounter[contestIndex].toString(),
              style: GoogleFonts.poppins(
                fontSize: screenSize.width * .028,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        );
      }),
    ],
  );
}
