import 'package:flutter/material.dart';
class DrawerItem {
  final IconData? icon;
  final Text title;
<<<<<<< HEAD
  final Widget? content;
  final List<DrawerItem>? sub_content;
  DrawerItem({this.icon, required this.title, this.content, this.sub_content});
=======
  final Widget content;
  DrawerItem({this.icon, required this.title, required this.content});
>>>>>>> b642b10 (search fix)
}