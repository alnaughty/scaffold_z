import 'package:scaffold_z/items.dart';
import 'package:flutter/material.dart';
import 'package:scaffold_z/drawer_children/widget.dart';

class DrawerZ{
  final List<DrawerItem>? items;
  final Color? drawerColor;
  final Colorization? unselectedColor, selectedColor;
  DrawerZ({this.items, this.drawerColor, this.selectedColor, this.unselectedColor});
}