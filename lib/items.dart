import 'package:flutter/material.dart';
class DrawerItem {
  final IconData? icon;
  final Text title;
  final Widget content;
  DrawerItem({this.icon, required this.title, required this.content});
}