import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  String _selectedSection = 'Home';
  final ScrollController _scrollController = ScrollController();

  // QA Engineer Data
  final String name = 'Dhinesh Kumar';
  final String role = 'QA Engineer';
  final String profileImage = 'assets/images/profile.jpg'; // உங்க image path

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final showSidebar = width > 1024;

    return Scaffold(
      body: Row(
        children: [
          if (showSidebar) _buildSidebar(),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  _buildHeroSection(),
                  _buildAboutSection(),
                  _buildProjectsSection(),
                  _buildContactSection(),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    final items = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.person, 'label': 'About'},
      {'icon': Icons.work, 'label': 'Projects'},
      {'icon': Icons.email, 'label': 'Contact'},
    ];

    return Container(
      width: 80,
      color: const Color(0xFF1A1F2E),
      child: Column(
        children: [
          const SizedBox(height: 40),
          // Logo/Avatar - DK initials
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.cyan.shade400, Colors.purple.shade400],
              ),
            ),
            child: const Center(
              child: Text(
                'DK',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          // Navigation Items
          ...items.map((item) => _buildNavItem(
            item['icon'] as IconData,
            item['label'] as String,
          )),
          const Spacer(),
          // Social Icons
          _buildSocialIcon(Icons.work_outline),
          const SizedBox(height: 20),
          _buildSocialIcon(Icons.code),
          const SizedBox(height: 20),
          _buildSocialIcon(Icons.bug_report),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label) {
    final isSelected = _selectedSection == label;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => setState(() => _selectedSection = label),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.cyan.shade400.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.cyan.shade400 : Colors.grey,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Icon(icon, color: Colors.grey, size: 20),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 700,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hello,',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  "I'm $name",
                  style: GoogleFonts.poppins(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  role,
                  style: GoogleFonts.poppins(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    _buildButton('Download Resume', true),
                    const SizedBox(width: 20),
                    _buildButton('My Projects', false),
                  ],
                ),
              ],
            ),
          ),
          // Profile Image
          Stack(
            alignment: Alignment.center,
            children: [
              // Circular background
              Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.cyan.shade400.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.cyan.shade400,
                    width: 3,
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade800,
                        child: Icon(
                          Icons.person,
                          size: 100,
                          color: Colors.cyan.shade400,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, bool isPrimary) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          gradient: isPrimary
              ? LinearGradient(
            colors: [Colors.cyan.shade400, Colors.purple.shade400],
          )
              : null,
          color: isPrimary ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isPrimary ? Colors.transparent : Colors.white,
            width: 2,
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.all(80),
      color: const Color(0xFF1A1F2E),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About me',
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "I'm a passionate QA Engineer with 4.5+ years of experience in software testing and quality assurance. I specialize in automation testing, manual testing, and ensuring high-quality software delivery. Proficient in Selenium, Postman, JMeter, and modern testing frameworks.",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.8,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    _buildStatBox('500+', 'Test Cases'),
                    const SizedBox(width: 30),
                    _buildStatBox('50+', 'Projects'),
                    const SizedBox(width: 30),
                    _buildStatBox('4.5+', 'Years Exp'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 60),
          Expanded(
            child: Column(
              children: [
                _buildSkillItem('Automation Testing', Icons.smart_toy),
                _buildSkillItem('Manual Testing', Icons.rule),
                _buildSkillItem('API Testing', Icons.api),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.cyan.shade400,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillItem(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF252B3B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.cyan.shade400.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.cyan.shade400, size: 24),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsSection() {
    return Container(
      padding: const EdgeInsets.all(80),
      child: Column(
        children: [
          Text(
            'Projects & Experience',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 60),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 30,
            crossAxisSpacing: 30,
            childAspectRatio: 1.3,
            children: [
              _buildProjectCard(
                'Aeries - Student Information System',
                'Comprehensive testing of student management platform with automated test scripts...',
                ['Selenium', 'Java', 'TestNG'],
                'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=400',
              ),
              _buildProjectCard(
                'E-Commerce Platform Testing',
                'End-to-end testing of online shopping platform including payment gateway integration...',
                ['Postman', 'JMeter', 'SQL'],
                'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=400',
              ),
              _buildProjectCard(
                'Mobile App QA',
                'Manual and automated testing for iOS and Android applications with focus on UX...',
                ['Appium', 'Selenium', 'Python'],
                'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=400',
              ),
              _buildProjectCard(
                'API Testing Framework',
                'Developed comprehensive API testing framework with automated regression suite...',
                ['REST Assured', 'Postman', 'Newman'],
                'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=400',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(
      String title,
      String description,
      List<String> tags,
      String imageUrl,
      ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1F2E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.network(
                imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.white60,
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: tags
                        .map((tag) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.cyan.shade400.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.cyan.shade400.withOpacity(0.5),
                        ),
                      ),
                      child: Text(
                        tag,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: Colors.cyan.shade300,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      padding: const EdgeInsets.all(80),
      color: const Color(0xFF1A1F2E),
      child: Column(
        children: [
          Text(
            'Have a QA project?',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Let's talk!",
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: 600,
            child: Column(
              children: [
                _buildTextField('Name'),
                const SizedBox(height: 20),
                _buildTextField('Email'),
                const SizedBox(height: 20),
                _buildTextField('Message', maxLines: 4),
                const SizedBox(height: 30),
                _buildButton('Submit', true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white60),
        filled: true,
        fillColor: const Color(0xFF252B3B),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(Icons.language),
              const SizedBox(width: 20),
              _buildSocialIcon(Icons.code),
              const SizedBox(width: 20),
              _buildSocialIcon(Icons.email),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            '© 2025 Dhinesh Kumar. All rights reserved.',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}