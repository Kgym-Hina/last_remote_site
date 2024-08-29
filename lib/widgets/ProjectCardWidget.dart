import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class ProjectCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final Uri url;

  const ProjectCardWidget({
    super.key,
    required this.title ,
    required this.description,
    required this.url
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
                      _launchURL();
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
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}