import 'package:flutter/material.dart';

import 'icon_style.dart';
import 'setting_util.dart';

class SettingsItem extends StatelessWidget {
  final IconData icons;
  final IconStyle? iconStyle;
  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const SettingsItem(
      {super.key,
      required this.icons,
      this.iconStyle,
      required this.title,
      this.titleStyle,
      this.subtitle,
      this.subtitleStyle,
      this.backgroundColor,
      this.trailing,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: ListTile(
        onTap: onTap,
        leading: (iconStyle != null && iconStyle!.withBackground!)
            ? Container(
                decoration: BoxDecoration(
                  color: iconStyle!.backgroundColor,
                  borderRadius: BorderRadius.circular(iconStyle!.borderRadius!),
                ),
                padding: const EdgeInsets.all(5),
                child: Icon(
                  icons,
                  size: SettingsUtils.settingsGroupIconSize,
                  color: iconStyle!.iconsColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(5),
                child: Icon(
                  icons,
                  size: SettingsUtils.settingsGroupIconSize,
                ),
              ),
        title: Text(
          title,
          style: titleStyle ?? const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: (subtitle != null)
            ? Text(
                subtitle!,
                style: subtitleStyle ?? Theme.of(context).textTheme.bodyMedium!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: (trailing != null) ? trailing : const Icon(Icons.arrow_forward_ios_sharp, size: 15, color: Colors.grey,),
      ),
    );
  }
}
