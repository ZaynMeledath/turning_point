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
          GestureDetector(
            onTap: () {
              context.read<ProfileBloc>().add(ProfilePictureUpdateEvent());
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
          ),
        ],
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoadedState) {
            // final closeDialog = closeDialogHandle;
            // if (state.isLoading && closeDialog == null) {
            //   closeDialogHandle = showLoadingDialog(context: context);
            // } else if (!state.isLoading && closeDialog != null) {
            //   closeDialog();
            //   closeDialogHandle = null;
            // }
            // if (state.isLoading) {
            //   Overlay.of(context).insert(loadingOverlay);
            // } else {
            //   loadingOverlay.remove();
            // }
          }
        },
        builder: (context, state) {
          if (state is ProfileLoadedState) {
            return Center(
              child: SizedBox(
                width: screenSize.width,
                height: screenSize.width,
                child: Hero(
                  tag: 'profile_picture',
                  child: PhotoView(
                    imageProvider: NetworkImage(state.userModel.image!),
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CupertinoActivityIndicator(
                radius: 14,
              ),
            );
          }
        },
      ),
    );
  }
}
