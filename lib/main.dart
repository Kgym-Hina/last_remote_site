import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/ProjectCardWidget.dart';

void main() {
  runApp(const LastRemoteWebApp());
}

class LastRemoteWebApp extends StatelessWidget {
  const LastRemoteWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Last Remote',
      themeMode: ThemeMode.dark,
      theme: buildThemeData(false),
      darkTheme: buildThemeData(true),
      home: const HomePage(title: 'Last Remote'),
    );
  }

  ThemeData buildThemeData(bool isDark) {
    var baseData = ThemeData(
      colorScheme: isDark
          ? const ColorScheme.dark()
          : ColorScheme.fromSeed(seedColor: Colors.purple),
      useMaterial3: true,
    );

    return baseData.copyWith(
        textTheme: GoogleFonts.caveatTextTheme(baseData.textTheme));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _showAppBarTitle = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 100 && !_showAppBarTitle) {
        setState(() {
          _showAppBarTitle = true;
        });
      } else if (_scrollController.offset <= 100 && _showAppBarTitle) {
        setState(() {
          _showAppBarTitle = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  var bodyFont = GoogleFonts.eduVicWaNtBeginner(
    textStyle: const TextStyle(fontSize: 20),
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isSmallScreen = screenWidth < 580;

    return Scaffold(
      appBar: AppBar(
        title: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              top: _showAppBarTitle ? 0 : 6,
              left: 0,
              right: 0,
              child: Center(
                child: SvgPicture.asset('assets/svg/icon.svg', height: 16),
              ),
            ),
            AnimatedOpacity(
              opacity: _showAppBarTitle ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Center(
                child: Text(widget.title),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            buildHeader(context, isSmallScreen),
            const SizedBox(height: 50),
            buildBodyAbout(context),
            const SizedBox(height: 50),
            buildBodyProjects(context, isSmallScreen),
            const SizedBox(height: 50),
          ],
        ),
      ),
      bottomNavigationBar: buildFooter(),
    );
  }

  SizedBox buildFooter() {
    return SizedBox(
      height: 80,
      child: Column(
        children: [
          const Divider(
            height: 20,
            thickness: 2,
          ),
          const Text("© 2024 Last-Remote. All rights reserved."),
          GestureDetector(
            child: Text(
              "Connect with me: i@bg8lrr.site (Click)",
              style: TextStyle(color: Colors.purple.shade200),
            ),
            onTap: () {
              launchUrl(Uri.parse("mailto:i@bg8lrr.site"));
            },
          ),
        ],
      ),
    );
  }

  Stack buildHeader(BuildContext context, bool isSmallScreen) {
    return Stack(
      children: [
        SizedBox(
          height: 500,
          width: double.infinity,
          child: SvgPicture.asset(
            'assets/svg/header.svg',
            fit: BoxFit.cover,
          ),
        ),
        Column(
          children: [
            const SizedBox(height: 100),
            Row(
              children: [
                SizedBox(width: isSmallScreen ? 50 : 100),
                Text("Last-Remote",
                    style: Theme.of(context).textTheme.displayLarge),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              children: [
                SizedBox(width: isSmallScreen ? 50 : 100),
                Text("A site of BG8LRR",
                    style: Theme.of(context).textTheme.headlineMedium),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Column buildBodyAbout(BuildContext context) {
    return Column(
      children: [
        Text("About Me", style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                  text: "I am a ",
                  style: bodyFont,
                  children: [
                    TextSpan(
                      text: "software developer",
                      style: TextStyle(color: Colors.purple.shade200),
                    ),
                    const TextSpan(
                      text: "and",
                    ),
                    TextSpan(
                      text: "amateur radio operator.",
                      style: TextStyle(color: Colors.purple.shade200),
                    ),
                    const TextSpan(
                      text: "I am interested in ",
                    ),
                    TextSpan(
                      text:
                          "game development, embedded development, and amateur radio.",
                      style: TextStyle(color: Colors.purple.shade200),
                    ),
                  ],
                ),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text.rich(
                TextSpan(text: "I mainly use",
                    style: bodyFont,
                    children: [
                  TextSpan(
                    text: " C++, C# and Dart.",
                    style: TextStyle(color: Colors.purple.shade200),
                  ),
                  const TextSpan(
                    text: "I am also familiar with ",
                  ),
                  TextSpan(
                    text: "C and Java.",
                    style: TextStyle(color: Colors.purple.shade200),
                  ),
                ]),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                "I first started programming in 2015. Started with a programming language which not liked by many people, E (a chinese modified version of VB).",
                style: bodyFont,
              ),
              const SizedBox(height: 16),
              Text(
                "Since then, I dived into making games. Started with construct2, then moved to Unity. I also tried Unreal Engine, but it is not my cup of tea. :P",
                style: bodyFont,
              ),
              const SizedBox(height: 16),
              Text(
                "In 2019, I made my first embedded project. It is a simple RGB light controller with an ESP32.",
                style: bodyFont,
              ),
              const SizedBox(height: 16),
              Text.rich(
                TextSpan(
                    text: "I got my amateur radio license in 2020. ",
                    children: [
                      TextSpan(
                        text: "My callsign is BG8LRR.",
                        style: TextStyle(color: Colors.purple.shade200),
                      ),
                    ]),
                style: bodyFont,
              ),
              const SizedBox(height: 16),
              Text(
                "Currently working on a project called Ham Toolset. It is a toolset for amateur radio operators.",
                style: bodyFont,
              ),
              const SizedBox(height: 50),
              Text(
                "   Sorry for my poor English. I am still learning it :)",
                style: bodyFont,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column buildBodyProjects(BuildContext context, bool isSmallScreen) {
    return Column(
      children: [
        Text("My Projects", style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: isSmallScreen ? null : 200,
            child: ListView(
              scrollDirection: isSmallScreen ? Axis.vertical : Axis.horizontal,
              shrinkWrap: true,
              children: [
                ProjectCardWidget(
                  title: "ArcadeLink",
                  description: "A project links arcade games to the web",
                  url: Uri.parse("https://github.com/ArcadeLink"),
                ),
                ProjectCardWidget(
                  title: "Ham Toolset (WIP)",
                  description: "A toolset for amateur radio operators.",
                  url: Uri.parse(
                      "https://github.com/Kgym-Hina/bg8lrr_ham_toolset"),
                ),
                ProjectCardWidget(
                  title: "Schiphalast",
                  description:
                      "Mobile MUG made for multiplayer. Cross-platform. Made with Unity",
                  url: Uri.parse("https://www.taptap.cn/app/217268"),
                ),
                ProjectCardWidget(
                  title: "ArcEcho (Planning)",
                  description: "A project that helps staffs in e-sports events",
                  url: Uri.parse(""),
                ),
                ProjectCardWidget(
                  title: "TicTac (Planning)",
                  description: "A game that helps people to learn Morse code",
                  url: Uri.parse(""),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}