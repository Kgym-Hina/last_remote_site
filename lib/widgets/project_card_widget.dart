import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class ProjectCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String url;
  final bool isRoute;
  final TextTheme? textTheme;

  const ProjectCardWidget({
    super.key,
    required this.title ,
    required this.description,
    required this.url,
    required this.isRoute,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: SizedBox(
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme?.headlineLarge?.copyWith(color: Colors.white)),
              const SizedBox(height: 20),
              Text(description, style: textTheme?.bodyMedium?.copyWith(color: Colors.white)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (isRoute) {
                        Navigator.pushNamed(context, url);
                      } else {
                        _launchURL();
                      }
                    },
                    child: Text("Learn More >>", style: textTheme?.bodyMedium?.copyWith(color: Colors.purple.shade300),),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL() async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}