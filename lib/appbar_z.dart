import 'package:scaffold_z/packed/appbar_exporter.dart';

class ZAppbar {
  final double elevation;
  final Color? bgColor;
  final List<Widget>? actions;
  final Widget title;
  final EdgeInsets padding;
  final Color? iconColor;
  final Widget? leading;
  final DrawerZ? drawer;
  final ZSearch? search;
  ZAppbar({
    this.leading,
    this.iconColor,
    this.elevation = -3,
    this.drawer,
    this.bgColor,
    this.actions,
    required this.title,
    this.padding = const EdgeInsets.symmetric(horizontal: 10),
    this.search
  });
}