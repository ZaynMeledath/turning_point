part of '../sign_up_screen.dart';

Widget contractorDropDownContainer(
    {required TextEditingController searchController}) {
  return BlocBuilder<ContractorBloc, ContractorState>(
    builder: (context, state) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: screenSize.width,
          height: screenSize.height * .052,
          // margin: EdgeInsets.symmetric(horizontal: screenSize.width * .005),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                offset: const Offset(-1.5, 1.5),
                blurRadius: 1.5,
                color: Colors.black.withOpacity(.2),
                blurStyle: BlurStyle.normal,
              ),
            ],
            border: Border.all(
              width: .8,
              color: const Color.fromRGBO(214, 214, 214, 1),
            ),
          ),

          //====================Drop Down Button and decoration====================//
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              items: state.contractorsList!
                  .map(
                    (item) => DropdownMenuItem(
                      value: '${item.name} - ${item.businessName}',
                      child: Text(
                        '${item.name} - ${item.businessName}',
                        style: GoogleFonts.roboto(
                          fontSize: screenSize.width * .036,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              value: state.selectedContractor,

              onChanged: (value) {
                //ContractorSelectedEvent is called on change of value
                context
                    .read<ContractorBloc>()
                    .add(ContractorSelectedEvent(value));
              },
              customButton: Container(
                width: screenSize.width * .6,
                decoration: BoxDecoration(
                  // color: const Color.fromRGBO(246, 246, 246, 1),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: screenSize.width * .028),
                      child: Text(
                        state.selectedContractor ?? 'Select Contractor',
                        style: GoogleFonts.roboto(
                          fontSize: screenSize.width * .032,
                          color: const Color.fromRGBO(16, 16, 16, .8),
                        ),
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
                              size: screenSize.width * .08,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // buttonStyleData: ButtonStyleData(
              //   padding:
              //       EdgeInsets.symmetric(horizontal: screenSize.width * .3),
              //   width: 0,
              // ),
              //====================DropDownMenu Decoration====================//
              dropdownStyleData: DropdownStyleData(
                maxHeight: screenSize.height * .3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              menuItemStyleData: MenuItemStyleData(
                height: screenSize.height * .047,
              ),
              dropdownSearchData: DropdownSearchData(
                searchController: searchController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 40,
                  margin: EdgeInsets.all(screenSize.width * .02),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 1),
                        blurRadius: 1,
                        color: Colors.black.withOpacity(.25),
                        blurStyle: BlurStyle.normal,
                      ),
                    ],
                  ),
                  child: Center(
                    child: TextFormField(
                      expands: false,
                      maxLines: null,
                      controller: searchController,
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .034,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        hintText: 'Search for the contractor...',
                        hintStyle: GoogleFonts.roboto(
                          fontSize: screenSize.width * .034,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value
                      .toString()
                      .toUpperCase()
                      .contains(searchValue.toUpperCase());
                },
              ),
              //This to clear the search value when you close the menu
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  searchController.clear();
                }
              },
            ),
          ),
        ),
      );
    },
  );
}
