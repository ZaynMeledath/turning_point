part of 'edit_profile_screen.dart';

class ProfilePictureView extends StatelessWidget {
  const ProfilePictureView({super.key});

  // final loadingOverlay = OverlayEntry(builder: (_) {
  //   return const Positioned(
  //     right: 100,
  //     top: 50,
  //     child: CupertinoActivityIndicator(
  //       radius: 14,
  //       color: Colors.blue,
  //     ),
  //   );
  // });

  @override
  Widget build(BuildContext context) {
    // CloseDialog? closeDialogHandle;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        switch (state) {
          case ProfileLoadingState():
            return CupertinoActivityIndicator(
              radius: screenSize.width * .036,
              color: Colors.blue,
            );

          case ProfileInactiveState():
            return ProfileInactiveScreen();

          case ProfileLoadErrorState():
            return CupertinoActivityIndicator(
              radius: screenSize.width * .036,
              color: Colors.blue,
            );

          case ProfileLoadedState():
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black.withOpacity(.5),
                title: Text(
                  'Profile Image',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: screenSize.width * .041,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                centerTitle: true,
                actions: [
                  !state.isLoading
                      ? GestureDetector(
                          onTap: () {
                            context
                                .read<ProfileBloc>()
                                .add(ProfilePictureUpdateEvent());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              'Edit',
                              style: GoogleFonts.roboto(
                                fontSize: screenSize.width * .041,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: CupertinoActivityIndicator(
                            radius: 12,
                            color: Colors.blue,
                          ),
                        ),
                ],
              ),
              body: Column(
                children: [
                  SizedBox(
                      height: screenSize.height * .4 - screenSize.width * .5),
                  SizedBox(
                    width: screenSize.width,
                    height: screenSize.width,
                    child: Hero(
                      tag: 'profile_picture',
                      child: PhotoView(
                        imageProvider: NetworkImage(state.userModel!.image!),
                      ),
                    ),
                  ),
                ],
              ),
            );
        }
      },
    );
  }
}
