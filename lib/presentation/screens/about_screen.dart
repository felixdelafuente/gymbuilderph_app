import 'package:flutter/material.dart';
import 'package:gym_builder_app/presentation/widgets/drawer.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key, required this.title});
  final String title;

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: const Color(0xff2b2b2b),
      ),
      drawer: appDrawer(context),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How was Gym Builder PH developed?',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'Gym Builder PH is a cross-platform mobile application that was developed using Flutter. Flutter is an open-source UI toolkit that allows developers to create beautiful and fast applications for multiple platforms, such as iOS, Android, web, and desktop, from a single codebase. Flutter uses the Dart programming language, which is expressive, concise, and powerful. Flutter also provides a rich set of widgets, animations, and state management solutions that make app development easier and more enjoyable.',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'The web ecommerce of Gym Builder PH was developed using HTML, CSS, and JavaScript for the frontend, and PHP and MySQL for the backend. HTML is the standard markup language for creating web pages and documents. CSS is the language that describes the style and layout of HTML elements. JavaScript is the scripting language that enables dynamic and interactive features on web pages. PHP is a server-side scripting language that handles the business logic and data processing of the web application. MySQL is a relational database management system that stores and manages the data of the web application.',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'The developers of Gym Builder PH used various tools and technologies to create a high-quality and user-friendly application. Some of these tools are Visual Studio Code, Firebase, Git, GitHub, Flutter DevTools, and Adobe XD. Visual Studio Code is a code editor that supports many languages and extensions. Firebase is a platform that provides various services, such as authentication, cloud storage, cloud functions, analytics, and more. Git is a version control system that tracks changes in the source code. GitHub is a hosting service that allows developers to collaborate and share their code online. Flutter DevTools is a suite of debugging and performance tools for Flutter applications. Adobe XD is a design tool that allows developers to create and prototype user interfaces.',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
