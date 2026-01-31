import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/constants/constants.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

// Web utility
import 'package:flutter/foundation.dart' show kIsWeb;
// Web டவுன்லோடிற்கு மட்டும் தேவைப்படும்
import 'dart:html' as html;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _particleController;
  bool _isDarkMode = true;
  final ScrollController _scrollController = ScrollController();

  // GlobalKey needed to open Drawer from a custom Header button
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _floatingController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this)
          ..repeat(reverse: true);
    _particleController =
        AnimationController(duration: const Duration(seconds: 20), vsync: this)
          ..repeat();
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _particleController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // --- Dynamic Styles ---
  Color get _bgColor =>
      _isDarkMode ? const Color(0xFF0F1219) : const Color(0xFFF5F7FA);

  Color get _textColor => _isDarkMode ? Colors.white : const Color(0xFF1A1A2E);

  Color get _subtextColor => _isDarkMode ? Colors.white70 : Colors.black54;

  Color get _cardBg =>
      _isDarkMode ? Colors.white.withOpacity(0.03) : Colors.white;

  void _scrollToSection(double offset) {
    _scrollController.animateTo(
        offset, duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut);
  }

  // Common URL Launcher
  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  // --- RESUME DOWNLOAD FUNCTION (FIXED) ---
  void _downloadResume() {
    // FIXED: GitHub Pages-il 'assets/assets/' endru path irukkum.
    // Unga file 'images' folder-il illamal direct-ah 'assets' il iruppathaal
    // 'assets/assets/Filename.pdf' endru kodukka vendum.
    const String assetPath = 'assets/assets/Dhinesh_Kumar_Senior_Software_Tester_4_Years_Exp.pdf';
    
    if (kIsWeb) {
      html.AnchorElement anchorElement = html.AnchorElement(href: assetPath);
      anchorElement.download = "Dhinesh_Kumar_Senior_Software_Tester_4_Years_Exp.pdf";
      anchorElement.click();
    } else {
      _launchURL(resumeLink);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: _bgColor,
      // Drawer for Mobile View (slides from left)
      drawer: width < 1024 ? _buildDrawer() : null,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildHeaderNavigation(width),
                _buildHeroHeader(width, height),
                const SizedBox(height: 80),
                _buildStatsGrid(width),
                const SizedBox(height: 80),
                _buildSkillsSection(width),
                const SizedBox(height: 80),
                _buildProjectsSection(width),
                _buildFooter(width),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            right: 30,
            child: FloatingActionButton(
              onPressed: () => setState(() => _isDarkMode = !_isDarkMode),
              backgroundColor: Colors.deepOrangeAccent,
              mini: width < 600,
              child: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== HAMBURGER DRAWER ====================
  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: _bgColor,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.deepOrangeAccent.withOpacity(0.1)))
            ),
            child: Center(
              child: Text(
                name.toUpperCase(),
                style: GoogleFonts.orbitron(
                  color: Colors.deepOrangeAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          _drawerItem("HOME", Icons.home_rounded, 0),
          _drawerItem("SKILLS", Icons.code_rounded, 850),
          _drawerItem("EXPERIENCE", Icons.work_history_rounded, 1600),
          _drawerItem("CONTACT", Icons.alternate_email_rounded, 4000),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "© 2026 DHINESH KUMAR.D",
              style: GoogleFonts.firaCode(fontSize: 10, color: _subtextColor),
            ),
          )
        ],
      ),
    );
  }

  Widget _drawerItem(String title, IconData icon, double offset) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepOrangeAccent, size: 20),
      title: Text(
        title,
        style: GoogleFonts.inter(
          color: _textColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
      onTap: () {
        Navigator.pop(context); // Close Drawer
        _scrollToSection(offset);
      },
    );
  }

  // ==================== 1. TOP NAVIGATION ====================
  Widget _buildHeaderNavigation(double width) {
    final bool isMobile = width < 600;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: width * 0.08, vertical: 20),
      child: Row(
        mainAxisAlignment: width >= 1024 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
        children: [
          // Show Hamburger Menu icon on the LEFT for mobile/tablet
          if (width < 1024) ...[
            IconButton(
              icon: Icon(Icons.menu_rounded, color: _textColor, size: 28),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            const SizedBox(width: 8),
          ],

          Flexible(
            child: Text(
              name.toUpperCase(),
              style: GoogleFonts.orbitron(
                color: _textColor,
                fontSize: isMobile ? 14 : 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Desktop Navigation Row
          if (width >= 1024)
            Row(
              children: [
                _navItem("Home", 0),
                _navItem("Skills", 850),
                _navItem("Experience", 1600),
                _navItem("Contact", 4000),
                const SizedBox(width: 25),
                _actionBtn("Hire Me", Icons.send_rounded, true, () =>
                    _scrollToSection(4000)),
              ],
            ),
        ],
      ),
    );
  }

  Widget _navItem(String title, double offset) {
    return InkWell(
      onTap: () => _scrollToSection(offset),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Text(
          title,
          style: GoogleFonts.inter(
              color: _subtextColor, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // ==================== 2. HERO SECTION ====================
  Widget _buildHeroHeader(double width, double height) {
    final bool isMobile = width < 700;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.08,
          vertical: isMobile ? 20 : 10),
      child: isMobile
          ? Column(
        children: [
          _heroImageSection(width, true),
          const SizedBox(height: 40),
          _heroTextSection(width, true),
        ],
      )
          : Row(
        children: [
          Expanded(flex: 3, child: _heroTextSection(width, false)),
          const SizedBox(width: 30),
          Expanded(flex: 2, child: _heroImageSection(width, false)),
        ],
      ),
    );
  }

  Widget _heroTextSection(double width, bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.deepOrangeAccent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.deepOrangeAccent.withOpacity(0.3)),
          ),
          child: Text(
            "SENIOR SOFTWARE TESTER & QA",
            style: GoogleFonts.firaCode(
              color: Colors.deepOrangeAccent,
              fontSize: isMobile ? 10 : 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 20),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "I'm $name",
            style: GoogleFonts.poppins(
              color: _textColor,
              fontSize: isMobile ? 38 : 68,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          aboutMeSummary,
          style: GoogleFonts.inter(
            color: _subtextColor,
            fontSize: isMobile ? 15 : 17,
            height: 1.6,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 35),
        Wrap(
          spacing: 15,
          runSpacing: 15,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _actionBtn("Download CV", Icons.download_rounded, true, _downloadResume),
            _actionBtn("Hire Me", Icons.send_rounded, false, () => _scrollToSection(4000)),
          ],
        ),
      ],
    );
  }

  Widget _heroImageSection(double width, bool isMobile) {
    double imageSize = isMobile ? 220 : 380;
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) =>
          Transform.translate(
            offset: Offset(0, math.sin(_floatingController.value * 2 * math.pi) * 12),
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    bottom: -12,
                    right: -12,
                    child: Container(
                      width: imageSize,
                      height: imageSize,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepOrangeAccent, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Container(
                    width: imageSize,
                    height: imageSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF1E1E2E),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 25,
                          offset: const Offset(8, 8),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _actionBtn(String label, IconData icon, bool isPrimary,
      VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18,
          color: isPrimary ? Colors.white : Colors.deepOrangeAccent),
      label: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: isPrimary ? Colors.white : Colors.deepOrangeAccent,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? Colors.deepOrangeAccent : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.deepOrangeAccent, width: 2),
        ),
      ),
    );
  }

  // ==================== 3. STATS GRID ====================
  Widget _buildStatsGrid(double width) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.08),
      child: Wrap(
        spacing: 30,
        runSpacing: 30,
        alignment: WrapAlignment.center,
        children: [
          _statCard("500+", "Test Cases Executed", Icons.bug_report_rounded, Colors.cyan, width),
          _statCard("50+", "Projects Completed", Icons.folder_special_rounded, Colors.purpleAccent, width),
          _statCard("4.5+", "Years Experience", Icons.history_edu_rounded, Colors.pinkAccent, width),
          _statCard("100%", "Quality Assurance", Icons.verified_user_rounded, Colors.greenAccent, width),
        ],
      ),
    );
  }

  Widget _statCard(String value, String label, IconData icon, Color themeColor, double width) {
    // Responsive card width logic
    double cardWidth = width < 600 ? (width * 0.84) : 240;

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: themeColor.withOpacity(0.2), width: 1),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: themeColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: themeColor, size: 35),
          ),
          const SizedBox(height: 20),
          FittedBox(
            child: Text(
              value,
              style: GoogleFonts.orbitron(
                fontSize: 26,
                color: _textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: _subtextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ==================== 4. SKILLS SECTION ====================
  Widget _buildSkillsSection(double width) {
    return Column(
      children: [
        Text(
          "TECHNICAL EXPERTISE",
          style: GoogleFonts.orbitron(
            fontSize: width < 600 ? 20 : 26,
            color: _textColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        Container(height: 3, width: 60, color: Colors.cyanAccent),
        const SizedBox(height: 50),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.08),
          child: Wrap(
            spacing: 15,
            runSpacing: 15,
            alignment: WrapAlignment.center,
            children: skills.keys.map((s) => _buildAdvancedSkillCard(s)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildAdvancedSkillCard(String skillName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.code_rounded, color: Colors.cyanAccent, size: 16),
          const SizedBox(width: 8),
          Text(
            skillName.toUpperCase(),
            style: GoogleFonts.firaCode(
                fontSize: 13, fontWeight: FontWeight.w600, color: _textColor),
          ),
        ],
      ),
    );
  }

  // ==================== 5. PROJECTS/EXPERIENCE ====================
  Widget _buildProjectsSection(double width) {
    return Column(
      children: [
        Text(
          "PROFESSIONAL JOURNEY",
          style: GoogleFonts.orbitron(
            fontSize: width < 600 ? 20 : 26,
            color: _textColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 50),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.08),
          child: Column(
            children: companyExperienceList
                .asMap()
                .entries
                .map((entry) =>
                _buildAdvancedCompanyRow(entry.value, width,
                    entry.key == companyExperienceList.length - 1))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildAdvancedCompanyRow(CompanyExperience company, double width,
      bool isLast) {
    final bool isMobile = width < 600;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _isDarkMode ? const Color(0xFF1E2235) : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.deepOrangeAccent, width: 2),
                ),
                child: Icon(
                    company.icon, color: Colors.deepOrangeAccent, size: 18),
              ),
              if (!isLast)
                Expanded(child: Container(
                    width: 2, color: Colors.deepOrangeAccent.withOpacity(0.2))),
            ],
          ),
          SizedBox(width: isMobile ? 15 : 30),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 40),
              padding: EdgeInsets.all(isMobile ? 20 : 35),
              decoration: BoxDecoration(
                color: _cardBg,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    company.name,
                    style: GoogleFonts.poppins(fontSize: isMobile ? 18 : 22,
                        fontWeight: FontWeight.bold,
                        color: _textColor),
                  ),
                  Text(
                    company.role,
                    style: GoogleFonts.firaCode(
                        fontSize: 14, color: Colors.deepOrangeAccent),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: company.projects
                        .map((p) => _buildProjectPill(p))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectPill(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10)),
      child: Text(
          title, style: GoogleFonts.inter(fontSize: 12, color: _textColor)),
    );
  }

  // ==================== 6. FOOTER ====================
  Widget _buildFooter(double width) {
    final bool isMobile = width < 600;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: width * 0.08),
      color: _isDarkMode ? Colors.black.withOpacity(0.1) : Colors.grey.shade100,
      child: Column(
        children: [
          FittedBox(
            child: Text(
                "LET'S WORK TOGETHER",
                style: GoogleFonts.orbitron(
                    fontSize: isMobile ? 20 : 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent
                )
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _footerContactItem(Icons.email_outlined, "dhineshdini05@gmail.com", "Tap to Email", isMobile, "mailto:dhineshdini05@gmail.com"),
              _footerContactItem(Icons.phone_android_outlined, "+91 9790274950", "Tap to Call", isMobile, "tel:+919790274950"),
              _footerContactItem(Icons.location_on_outlined, "Tirupur, Tamil Nadu", "Location", isMobile, ""),
              _footerContactItem(Icons.link_rounded, "LinkedIn Profile", "Let's Connect", isMobile, "https://www.linkedin.com/in/ds-dhineshkumar"),
            ],
          ),
          const SizedBox(height: 50),
          Text(
              "© 2026 DHINESH KUMAR.D",
              style: GoogleFonts.firaCode(fontSize: 12, color: _subtextColor)
          ),
        ],
      ),
    );
  }

  Widget _footerContactItem(IconData icon, String value, String label, bool isMobile, String actionUrl) {
    return InkWell(
      onTap: actionUrl.isNotEmpty ? () => _launchURL(actionUrl) : null,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: isMobile ? (MediaQuery.of(context).size.width * 0.84) : 280,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.deepOrangeAccent, size: 20),
                const SizedBox(width: 10),
                Flexible(child: Text(value, style: GoogleFonts.poppins(fontSize: 13, color: _textColor, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
              ],
            ),
            const SizedBox(height: 5),
            Text(label.toUpperCase(), style: GoogleFonts.inter(fontSize: 9, color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
          ],
        ),
      ),
    );
  }
}
