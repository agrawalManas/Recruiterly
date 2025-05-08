import 'package:talent_mesh/common/utils/extensions/context_extensions.dart';
import 'package:talent_mesh/common/utils/extensions/enum_extensions.dart';
import 'package:talent_mesh/common/widgets/divider/custom_divider.dart';
import 'package:talent_mesh/common/widgets/textfield/textfield_with_search_and_cross_icon.dart';
import 'package:talent_mesh/styles/app_colors.dart';
import 'package:talent_mesh/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchableDropdown<T> extends StatefulWidget {
  final String? label;
  final List<T> items;
  final T? initiallySelectedItem;

  /// getLabel() method corresponds to the values that needs to be shown as list item
  final String Function(T) getLabel;

  final void Function(T?) onChanged;

  /// onNetworkSearch() corresponds to the network search via api call
  final Future<List<T>> Function(String value)? onNetworkSearch;

  final String searchHint;
  final String noResultsText;
  final Color fillColor;
  final bool isRequired;
  final bool hideSearch;
  final bool showDropdownMenu;
  final double elevation;
  final EdgeInsets? padding;

  const SearchableDropdown({
    this.label,
    required this.items,
    this.initiallySelectedItem,
    required this.getLabel,
    required this.onChanged,
    this.searchHint = 'Search',
    this.noResultsText = 'No results found',
    this.fillColor = AppColors.surface,
    this.isRequired = false,
    this.elevation = 1,
    this.hideSearch = false,
    this.onNetworkSearch,
    this.showDropdownMenu = true,
    this.padding,
    super.key,
  });

  @override
  State<SearchableDropdown<T>> createState() => _SearchableDropdownState<T>();
}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<bool> _isOpen = ValueNotifier<bool>(false);
  final ValueNotifier<List<T>> _filteredItems = ValueNotifier<List<T>>([]);
  final ValueNotifier<T?> _selectedItem = ValueNotifier<T?>(null);

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
      return widget
          .getLabel(item)
          .toLowerCase()
          .contains(_searchController.text.toLowerCase());
    }).toList();

    if (_filteredItems.value.isEmpty && widget.onNetworkSearch != null) {
      widget.onNetworkSearch!(_searchController.text);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _isOpen.dispose();
    _filteredItems.dispose();
    super.dispose();
  }

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

        GestureDetector(
          onTap: () {
            if (widget.showDropdownMenu) {
              _isOpen.value = !_isOpen.value;
              if (_isOpen.value) {
                _focusNode.requestFocus();
              }
            }
          },
          child: ValueListenableBuilder<bool>(
            valueListenable: _isOpen,
            builder: (context, isOpen, child) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: widget.fillColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.r),
                  ),
                  border: Border.all(
                    color: AppColors.textSecondary.withValues(alpha: 0.2),
                  ),
                ),
                child: Padding(
                  padding: widget.padding ??
                      EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ValueListenableBuilder<T?>(
                          valueListenable: _selectedItem,
                          builder: (context, value, child) {
                            return Text(
                              value != null ? widget.getLabel(value) : 'Select',
                              style: AppTextStyles.body3Regular14(
                                color: value != null
                                    ? AppColors.textPrimary
                                    : AppColors.disabledText,
                              ),
                            );
                          },
                        ),
                      ),
                      if (widget.showDropdownMenu)
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
        ),
        4.verticalSpace,

        //-----------LIST-OF-ITEMS----------
        ValueListenableBuilder<bool>(
          valueListenable: _isOpen,
          builder: (context, isOpen, child) {
            final borderColor = context.userRole.accentColor;
            if (!isOpen) return const SizedBox.shrink();
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: widget.fillColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border(
                        left: BorderSide(
                          color: borderColor,
                          width: 0.5,
                        ),
                        right: BorderSide(
                          color: borderColor,
                          width: 0.5,
                        ),
                        bottom: BorderSide(
                          color: borderColor,
                          width: 0.4,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: borderColor.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        8.verticalSpace,
                        //---------SEARCH-FIELD----------
                        if (!widget.hideSearch) ...[
                          TextFieldWithSearchAndCrossIcon(
                            controller: _searchController,
                            hintText: widget.searchHint,
                            showPrefix: false,
                            fillColor: widget.fillColor,
                            onCrossIconTapped: () {
                              if (_searchController.text.trim().isNotEmpty) {
                                _searchController.clear();
                              }
                            },
                          ),
                          CustomDivider(
                            height: 8.h,
                            color: AppColors.disabledButton,
                          ),
                          8.verticalSpace,
                        ],

                        //-----------ITEMS---------
                        ValueListenableBuilder<List<T>>(
                          valueListenable: _filteredItems,
                          builder: (context, items, child) {
                            return items.isEmpty
                                ? Padding(
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
                                  )
                                : Container(
                                    constraints:
                                        BoxConstraints(maxHeight: 120.h),
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                      ),
                                      itemCount: items.length,
                                      separatorBuilder: (_, index) {
                                        return CustomDivider(
                                          height: 16.h,
                                          color: AppColors.disabledButton,
                                        );
                                      },
                                      itemBuilder: (context, index) {
                                        final item = items[index];
                                        return InkWell(
                                          onTap: () {
                                            widget.onChanged(item);
                                            _isOpen.value = false;
                                            _selectedItem.value = item;
                                            _searchController.clear();
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              bottom: index == items.length - 1
                                                  ? 8.h
                                                  : 0,
                                            ),
                                            child: Text(
                                              widget.getLabel(item),
                                              style: AppTextStyles
                                                  .body3Regular14(),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
