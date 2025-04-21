import 'package:cades_flutter_template/common/navigation/app_routes.dart';
import 'package:cades_flutter_template/common/utils/extensions/context_extensions.dart';
import 'package:cades_flutter_template/common/utils/extensions/enum_extensions.dart';
import 'package:cades_flutter_template/styles/app_colors.dart';
import 'package:cades_flutter_template/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? action;
  final bool backEnabled;
  final VoidCallback? onBack;
  final String title;
  final Color? backgroundColor;
  final Color? leadingColor;
  final TextStyle? titleStyle;
  final double elevation;
  final Color? shadowColor;
  const CustomAppBar({
    this.backEnabled = true,
    this.action,
    required this.title,
    this.onBack,
    this.backgroundColor,
    this.leadingColor,
    this.titleStyle,
    this.elevation = 0,
    this.shadowColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      shadowColor: shadowColor,
      backgroundColor: backgroundColor ?? context.userRole.accentColor,
      centerTitle: true,
      title: Text(
        title,
        style: titleStyle ??
            AppTextStyles.body1SemiBold18(
              color: AppColors.background,
            ),
      ),
      automaticallyImplyLeading: false,
      leading: backEnabled
          ? GestureDetector(
              onTap: onBack ??
                  () {
                    AppRoutes.appRouter.pop();
                  },
              child: const Icon(
                Icons.arrow_back_ios,
                size: 22,
                color: AppColors.background,
              ),
            )
          : const SizedBox.shrink(),
      actions: action,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
