import 'package:flutter/material.dart';

class Project {
  final String companyName;
  final String title;
  final String description;
  final String role;
  final List<String> techStack;
  final IconData? icon;

  Project({
    required this.companyName,
    required this.title,
    required this.description,
    required this.role,
    required this.techStack,
    this.icon,
  });
}