import 'package:flutter/material.dart';

class ProjectCardWidgetData{
  final String title;
  final String description;
  final String? url;
  final String? route;
  TextTheme? textTheme;

  ProjectCardWidgetData({required this.title, required this.description, this.url, this.route, this.textTheme});
}