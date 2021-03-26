import 'package:flutter/material.dart';

class ZSearch {
  final bool enable;
  final ValueChanged? searchCallback;
  final List lookAt;
  final ZSearchType type;
  ZSearch({this.enable = false, this.searchCallback, required this.lookAt, required this.type});
}

class ZSearchType{
  final bool isObject;
  final String? keyToCheck;
  ZSearchType({this.isObject = false, this.keyToCheck});
}