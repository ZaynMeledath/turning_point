part of '../sign_up_screen.dart';

Widget contractorDropDownContainer(
    {required TextEditingController searchController}) {
  final contractorList = ['JOHN', 'JACOB', 'SEAN', 'ADHIL'];
  return BlocBuilder<ContractorBloc, ContractorState>(
    builder: (context, state) {
      return Container(
        width: double.infinity,
        height: screenSize.height * .052,
        margin: EdgeInsets.symmetric(horizontal: screenSize.width * .005),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              offset: const Offset(-2, 2),
              blurRadius: 2,
              color: Colors.black.withOpacity(.25),
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
            hint: Text(
              'Select Contractor',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .032,
                color: const Color.fromRGBO(16, 16, 16, .8),
              ),
            ),
            items: contractorList
                .map(
                  (item) => DropdownMenuItem(
                    value: item.toUpperCase(),
                    child: Text(
                      item.toUpperCase(),
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .036,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                )
                .toList(),
            value: state.contractorName,
            onChanged: (value) {
              //ContractorSelectedEvent is called on change of value
              context
                  .read<ContractorBloc>()
                  .add(ContractorSelectedEvent(value));
            },
            buttonStyleData: ButtonStyleData(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * .041),
              width: 0,
            ),
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
                padding: EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: screenSize.width * .02,
                  left: 8,
                ),
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
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  controller: searchController,
                  style: GoogleFonts.roboto(
                    fontSize: screenSize.width * .034,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'Search for the contractor...',
                    hintStyle: GoogleFonts.roboto(
                      fontSize: screenSize.width * .034,
                    ),
                    border: InputBorder.none,
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
      );
    },
  );
}
