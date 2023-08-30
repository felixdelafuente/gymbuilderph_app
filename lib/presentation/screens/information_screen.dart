import 'package:flutter/material.dart';
import 'package:gym_builder_app/presentation/widgets/drawer.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key, required this.title});
  final String title;

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
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
          // remove the const keyword
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            // add this widget
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Gym Builder PH',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Gym Builder PH is your one-stop shop for quality gym equipment in the Philippines. Whether you are looking for a squat rack, a bench, a barbell, or a kettlebell, we have it all. We also offer durable and heavy-duty equipment that can withstand any workout intensity. Our products are designed to help you reach your fitness goals and unleash your potential.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Why choose Gym Builder PH?',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  '- We offer competitive prices and fast delivery nationwide.',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  '- We have a wide range of products that suit your needs and preferences.',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  '- We have a friendly and responsive customer service team that can assist you with any inquiries or concerns.',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  '- We have a loyal and satisfied customer base that trusts our brand and quality.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  'How to order from Gym Builder PH?',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  '- Visit our website [gymbuilderph.com] and browse our products.',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  '- Add the items you want to buy to your cart and proceed to checkout.',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  '- Fill in your shipping and payment details and confirm your order.',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  '- Wait for your order confirmation email and tracking number.',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  '- Receive your order within the estimated delivery time and enjoy your new gym equipment.',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ));
  }
}
