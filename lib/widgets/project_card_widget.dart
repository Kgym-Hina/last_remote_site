import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class ProjectCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String url;
  final bool isRoute;

  const ProjectCardWidget({
    super.key,
    required this.title ,
    required this.description,
    required this.url,
    required this.isRoute
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
              Text(title, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),
              Text(description, style: Theme.of(context).textTheme.bodyLarge),
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
                    child: const Text("Learn More >>"),
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