import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:last_remote_site/ham_toolkit_page.dart';
import 'package:last_remote_site/models/project_card_widget_data.dart';
import 'package:last_remote_site/widgets/qsl_card_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:badges/badges.dart' as badges;
import 'widgets/project_card_widget.dart';

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
      routes: {
        '/': (context) => const HomePage(title: 'Last Remote'),
        '/ham': (context) => const HamToolkitPage(),
      },
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
  final PageController _pageController = PageController();
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

  var bodyFont = GoogleFonts.jetBrainsMono(
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
            buildSectionTitle(context, "QSL Cards"),
            const SizedBox(height: 16),
            SizedBox(
              height: isSmallScreen ? 250 : 400,
              child: Stack(
                children: [
                  PageView(
                    controller: _pageController,
                    children: const [
                      QslCardWidget(imagePath: "assets/images/qsl/1.png"),
                      QslCardWidget(imagePath: "assets/images/qsl/2.png"),
                      QslCardWidget(imagePath: "assets/images/qsl/3.png"),
                    ],
                  ),
                  Positioned(
                    left: 20,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_left),
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_right),
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () => {
                      // Pop up a dialog
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                                title: Text("Get an eQSL"),
                                content: Text("This feature is not available yet."),);
                          })
                    },
                child: const Text("Get an eQSL")),
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
              "Connect with me: i@bg8lrr.link (Click)",
              style: TextStyle(color: Colors.purple.shade200),
            ),
            onTap: () {
              launchUrl(Uri.parse("mailto:i@bg8lrr.link"));
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
            const SizedBox(height: 150),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: badges.Badge(
                badgeContent: const Text("New"),
                child: Row(
                  children: [
                    Expanded(
                      child: FilledButton(onPressed: () {
                        launchUrl(Uri.parse("https://blog.last-remote.xyz"));
                      }, child: const Text("Blog")),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column buildBodyAbout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionTitle(context, "About Me"),
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
                TextSpan(text: "I mainly use", style: bodyFont, children: [
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
                "Currently working on a project called Ham Toolkit. It is a toolset for amateur radio operators.",
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

  Row buildSectionTitle(BuildContext context, String title) {
    return Row(
        children: [
          Text(title, style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 2,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.purple.shade200,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
  }

  List<ProjectCardWidgetData> getProjects() {
    return [
      ProjectCardWidgetData(
        title: "ArcadeLink",
        description: "A project links arcade games to the web",
        url: "https://github.com/ArcadeLink",
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(),
      ),
      ProjectCardWidgetData(
        title: "Ham Toolset",
        description: "A toolset for amateur radio operators.",
        route: "/ham",
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(),
      ),
      ProjectCardWidgetData(
        title: "Schiphalast",
        description:
            "Mobile MUG made for multiplayer. Cross-platform. Made with Unity",
        url: "https://www.taptap.cn/app/217268",
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(),
      ),
      ProjectCardWidgetData(
        title: "TicTac (Planning)",
        description: "A game that helps people to learn Morse code",
        url: "",
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(),
      )
    ];
  }

  Column buildBodyProjects(BuildContext context, bool isSmallScreen) {
    return Column(
      children: [
        buildSectionTitle(context, "Projects"),
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: isSmallScreen ? null : 200,
            child: isSmallScreen
                ? Column(
                    children: [
                      for (var project in getProjects())
                        ProjectCardWidget(
                          title: project.title,
                          description: project.description,
                          url: project.route ?? project.url!,
                          isRoute: project.route != null,
                          textTheme: project.textTheme,
                        ),
                    ],
                  )
                : ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      for (var project in getProjects())
                        ProjectCardWidget(
                          title: project.title,
                          description: project.description,
                          url: project.route ?? project.url!,
                          isRoute: project.route != null,
                          textTheme: project.textTheme,
                        ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
