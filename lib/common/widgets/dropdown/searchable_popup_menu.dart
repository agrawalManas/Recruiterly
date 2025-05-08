import 'package:talent_mesh/common/widgets/divider/custom_divider.dart';
import 'package:talent_mesh/common/widgets/textfield/textfield_with_search_and_cross_icon.dart';
import 'package:talent_mesh/styles/app_colors.dart';
import 'package:talent_mesh/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchablePopupMenu<T> extends StatefulWidget {
  final String? label;
  final List<T> items;
  final T? initiallySelectedItem;
  final String Function(T) getLabel;
  final void Function(T?) onChanged;

  final Future<List<T>> Function(String value)? onNetworkSearch;
  final String searchHint;
  final String noResultsText;
  final Color fillColor;
  final bool isRequired;
  final bool hideSearch;
  final bool showMenu;
  final double elevation;
  final double menuElevation;
  final bool autoFocus;
  final Offset offset;
  final EdgeInsets? padding;

  const SearchablePopupMenu({
    this.label,
    required this.items,
    this.initiallySelectedItem,
    required this.getLabel,
    required this.onChanged,
    this.searchHint = 'Search',
    this.noResultsText = 'No results found',
    this.fillColor = AppColors.surface,
    this.isRequired = false,
    this.hideSearch = false,
    this.onNetworkSearch,
    this.padding,
    this.elevation = 1.0,
    this.menuElevation = 4.0,
    this.showMenu = true,
    this.autoFocus = true,
    this.offset = Offset.zero,
    super.key,
  });

  @override
  State<SearchablePopupMenu<T>> createState() => _SearchablePopupMenuState<T>();
}

class _SearchablePopupMenuState<T> extends State<SearchablePopupMenu<T>> {
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<List<T>> _filteredItems = ValueNotifier<List<T>>([]);
  final ValueNotifier<T?> _selectedItem = ValueNotifier<T?>(null);
  final ValueNotifier<bool> _isOpen = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _filteredItems.value = widget.items;
    if (widget.initiallySelectedItem != null) {
      _selectedItem.value = widget.initiallySelectedItem;
    }
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    _filteredItems.value = widget.items.where((item) {
      final items = widget
          .getLabel(item)
          .toLowerCase()
          .contains(_searchController.text.toLowerCase());
      return items;
    }).toList();
  }

  // @override
  // void dispose() {
  //   _searchController.dispose();
  //   _filteredItems.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //----------LABEL----------
        if (widget.label != null) ...[
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Row(
              children: [
                Text(
                  widget.label!,
                  style: AppTextStyles.body4Medium12(),
                ),
                if (widget.isRequired == true)
                  Text(
                    '*',
                    style: AppTextStyles.body4Medium12(
                      color: AppColors.error,
                    ),
                  ),
              ],
            ),
          ),
          4.verticalSpace,
        ],

        ValueListenableBuilder<List<T>>(
          valueListenable: _filteredItems,
          builder: (context, value, child) {
            return PopupMenuButton<T>(
              padding: EdgeInsets.zero,
              color: AppColors.surface,
              elevation: widget.menuElevation,
              position: PopupMenuPosition.under,
              // position: MediaQuery.of(context).viewInsets.bottom != 0
              //     ? PopupMenuPosition.over
              //     : PopupMenuPosition.under,
              offset: widget.offset,
              // offset: MediaQuery.of(context).viewInsets.bottom != 0
              //     ?
              //     const Offset(0, -200)
              //     : Offset.zero,
              constraints: BoxConstraints(
                maxWidth: 356.w,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.r),
                ),
              ),
              onOpened: () {
                _isOpen.value = true;
              },
              onCanceled: () {
                _isOpen.value = false;
                _searchController.clear();
              },
              onSelected: (value) {
                widget.onChanged(value);
                _isOpen.value = false;
                _selectedItem.value = value;
                _searchController.clear();
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  enabled: false,
                  padding: EdgeInsets.zero,
                  child: ValueListenableBuilder<List<T>>(
                    valueListenable: _filteredItems,
                    builder: (context, value, child) {
                      return SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!widget.hideSearch) ...[
                              TextFieldWithSearchAndCrossIcon(
                                controller: _searchController,
                                hintText: widget.searchHint,
                                showPrefix: false,
                                fillColor: widget.fillColor,
                                onCrossIconTapped: () {
                                  if (_searchController.text
                                      .trim()
                                      .isNotEmpty) {
                                    _searchController.clear();
                                  }
                                },
                              ),
                              CustomDivider(
                                height: 8.h,
                                color: AppColors.disabledButton,
                              ),
                              // 8.verticalSpace,
                            ],
                            if (value.isEmpty) ...[
                              PopupMenuItem(
                                enabled: false,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 16.h,
                                  ),
                                  child: Center(
                                    child: Text(
                                      widget.noResultsText,
                                      style: AppTextStyles.body3Regular14(),
                                    ),
                                  ),
                                ),
                              ),
                            ] else
                              SizedBox(
                                width: double.maxFinite,
                                height: 130.h,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: value.length,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    return PopupMenuItem(
                                      value: value[index],
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.w,
                                        ),
                                        child: Text(
                                          widget.getLabel(
                                            _filteredItems.value[index],
                                          ),
                                          style: AppTextStyles.body3Regular14(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
              child: ValueListenableBuilder<bool>(
                valueListenable: _isOpen,
                builder: (context, isOpen, child) {
                  return Card(
                    elevation: widget.elevation,
                    borderOnForeground: false,
                    color: widget.fillColor,
                    child: Padding(
                      padding: widget.padding ??
                          EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 11.1.h,
                          ),
                      child: Row(
                        children: [
                          Expanded(
                            child: ValueListenableBuilder<T?>(
                                valueListenable: _selectedItem,
                                builder: (context, value, child) {
                                  return Text(
                                    value != null
                                        ? widget.getLabel(value)
                                        : 'Select',
                                    style: AppTextStyles.body3Regular14(),
                                  );
                                }),
                          ),
                          if (widget.showMenu)
                            Icon(
                              isOpen
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: AppColors.textPrimary,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
