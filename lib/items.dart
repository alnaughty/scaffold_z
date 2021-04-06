import 'package:flutter/material.dart';
class DrawerItem {
  final IconData? icon;
  final Text title;
  final Widget? content;
  final List<DrawerItem>? sub_content;
  DrawerItem({this.icon, required this.title, this.content, this.sub_content});
}