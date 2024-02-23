part of '../sign_up_screen.dart';

Widget contractorDropDownContainer({
  required TextEditingController searchController,
  Color? color,
}) {
  return BlocBuilder<ContractorBloc, ContractorState>(
    builder: (context, contractorState) {
      return Align(
        alignment: Alignment.centerLeft,
        child: AbsorbPointer(
          absorbing: contractorState.contractorNotListed == true ||
              contractorState.haveNoContractor == true,
          child: Container(
            width: screenSize.width,
            height: screenSize.height * .052,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                color == null
                    ? const BoxShadow(
                        offset: Offset(-.5, .5),
                        blurRadius: 1,
                        color: Color.fromRGBO(214, 214, 214, 1),
                        blurStyle: BlurStyle.normal,
                      )
                    : BoxShadow(
                        offset: const Offset(-.5, .5),
                        blurRadius: .5,
                        color: Colors.black.withOpacity(.2),
                      ),
              ],
              border: color != null
                  ? Border.all(
                      width: .8,
                      color: Colors.black.withOpacity(.3),
                    )
                  : null,
            ),

            //====================Drop Down Button and decoration====================//
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                items: contractorState.contractorsList!
                    .map(
                      (item) => DropdownMenuItem(
                        value: '${item.name} - ${item.businessName}',
                        child: Text(
                          '${item.name} - ${item.businessName}',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .036,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                value: contractorState.selectedContractor,

                onChanged: (value) {
                  //ContractorSelectedEvent is called on change of value
                  context
                      .read<ContractorBloc>()
                      .add(ContractorSelectedEvent(value));
                },
                customButton: Container(
                  width: screenSize.width * .6,
                  decoration: BoxDecoration(
                    color: color ?? const Color.fromRGBO(246, 246, 246, 1),
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenSize.width * .028),
                        child: Text(
                          contractorState.haveNoContractor == true
                              ? DEFAULT_CONTRACTOR_STRING
                              : contractorState.selectedContractor ??
                                  'Select Contractor',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            letterSpacing: 1,
                            fontSize: screenSize.width * .034,
                            color: contractorState.contractorNotListed == true
                                ? Colors.grey.withOpacity(.5)
                                : const Color.fromRGBO(16, 16, 16, 1),
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
                                color: contractorState.contractorNotListed ==
                                            true ||
                                        contractorState.haveNoContractor == true
                                    ? Colors.grey.withOpacity(.5)
                                    : null,
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
        ),
      );
    },
  );
}
