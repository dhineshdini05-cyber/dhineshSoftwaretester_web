import 'package:flutter/material.dart';
import 'package:portfolio/models/project_model.dart';

// ==================== COLORS & PATHS ====================
Color kGradient1 = Colors.blueAccent;
Color kGradient2 = Colors.indigo;
String imagePath = "assets/images/dhinesh.jpg"; // Ensure this matches pubspec.yaml

// ==================== BASIC INFO ====================
String name = "Dhinesh Kumar";
String username = "QA Engineer | Software Tester";
String contactEmail = "your.real.email@gmail.com";
String resumeLink = "https://drive.google.com/file/d/1uZPqMWva6pZxzQxsR_ILLZ_FxJr24QeY/view?usp=sharing";
String location = "Coimbatore, Tamil Nadu, India (Native: Tiruppur)";

// ==================== SUMMARIES ====================
String aboutWorkExperience = '''
🏢 Halcyen Information Technology – QA Engineer (Current • 1 Year)
• Manual & Automation Testing (Selenium)
• API (Postman) & Performance Testing (JMeter)

🏢 Spark IT Tech – Manual Tester (2.5 Years)
• End-to-End Manual Testing
• Mobile & Tablet View Testing

🏢 Regent Info Solution – Software Tester (1 Year)
• Manual Testing & Bug Reporting
''';

String aboutMeSummary = '''
QA Engineer with 4.5 years of experience in Software Testing.
Expertise in Manual Testing and hands-on experience in Automation, API, and Performance Testing.
Proficient in Selenium WebDriver, Postman, JMeter, Jira, and Azure DevOps.
''';

// ==================== SKILLS DATA ====================
Map<String, double> skills = {
  "Manual Testing": 0.95,
  "Selenium Automation": 0.80,
  "API Testing (Postman)": 0.85,
  "Performance Testing (JMeter)": 0.75,
  "Jira & Azure DevOps": 0.90,
  "Cross-Browser & Mobile Testing": 0.88,
  "Test Case Design": 0.92,
  "Functional & Regression": 0.95,
};

// ==================== PROJECTS LIST ====================
final List<Project> workedProjects = [
  Project(
    companyName: "Halcyen Information Technology",
    title: "GHRMS & Global HRMS",
    description: "Web & Mobile (Android & iOS) testing for Global HR Management System.",
    role: "Full Stack QA Engineer",
    techStack: ["Manual", "Automation", "API", "Performance"],
    icon: Icons.groups_rounded,
  ),
  Project(
    companyName: "Halcyen Information Technology",
    title: "Visit Track & Task Management",
    description: "Visitor Management System and internal task tracking workflow.",
    role: "End-to-End Tester",
    techStack: ["Manual", "Mobile App", "Jira"],
    icon: Icons.assignment_turned_in_rounded,
  ),
  Project(
    companyName: "Spark IT Tech",
    title: "E-Commerce & Vendor Portal",
    description: "Online Ordering Portal and Supply Chain Management testing.",
    role: "Mobile App & Web Tester",
    techStack: ["Android", "iOS", "Web Apps", "Tablet View"],
    icon: Icons.shopping_cart_checkout_rounded,
  ),
  Project(
    companyName: "Regent Info Solution",
    title: "Billing & Payroll Suite",
    description: "Complete ERP solution including Billing, Payroll, and Accounting.",
    role: "Manual Tester & Bug Reporting",
    techStack: ["Manual Testing", "Accounting Domain", "Validation"],
    icon: Icons.calculate_rounded,
  ),
];

// ==================== COMPANY WISE DATA ====================
class CompanyExperience {
  final String name;
  final String role;
  final String duration;
  final List<String> projects;
  final List<String> tech;
  final IconData icon;

  CompanyExperience({
    required this.name,
    required this.role,
    required this.duration,
    required this.projects,
    required this.tech,
    required this.icon,
  });
}

final List<CompanyExperience> companyExperienceList = [
  CompanyExperience(
    name: "Halcyen Information Technology",
    role: "Software QA Engineer",
    duration: "2024 - Present",
    icon: Icons.biotech_rounded,
    projects: ["GHRMS", "Visit Track", "Meet Plus","Shree Devarayam Matrimony", "Task Management", "Job Portal", "Message Matrix"],
    tech: ["Selenium", "Postman", "JMeter", "Azure Devops", "JMeter"],
  ),
  CompanyExperience(
    name: "Spark IT Tech",
    role: "Manual Tester",
    duration: "2.5 Years",
    icon: Icons.mobile_friendly_rounded,
    projects: ["Online Ordering Portal","Back Office","Supplier Chain Management", "Smart Document" "BI Reports", "Vendor Portal"],
    tech: ["Mobile Testing", "Web Apps", "Azure DevOps", "JMeter"],
  ),
  CompanyExperience(
    name: "Regent Info Solution",
    role: "Software Tester",
    duration: "1 Year",
    icon: Icons.inventory_2_rounded,
    projects: ["Billing Software","HRDMS","Stock Management","E-time Track", "Payroll", "Accounting"],
    tech: ["Manual Testing", "Test Case Prep", "Validation"],
  ),
];