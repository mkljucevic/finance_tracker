import 'package:finance_tracker/colors.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Statistics',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            StatsCard(
              title: 'Balance Trend',
              description:
                  'Lorem ipsum dal amore del ilore at sibilis trend in major uniturmumu',
              image: 'bar-graph',
            ),
            SizedBox(height: 20),
            StatsCard(
              title: 'Cash Flow',
              description:
                  'Lorem ipsum dal amore del ilore at sibilis trend in major uniturmumu',
              image: 'report',
            ),
            SizedBox(height: 20),
            StatsCard(
              title: 'Spendings',
              description:
                  'Lorem ipsum dal amore del ilore at sibilis trend in major uniturmumu',
              image: 'pie-chart',
            ),
            SizedBox(height: 20),
            StatsCard(
              title: 'Reports',
              description:
                  'Lorem ipsum dal amore del ilore at sibilis trend in major uniturmumu',
              image: 'report',
            ),
          ],
        ),
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const StatsCard({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        //color: Color(0xfff2f5f3),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xfff2f5f3),
            Colors.white,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6 - 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  description,
                  style: const TextStyle(
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  child: const Text(
                    'Show details',
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4 - 20,
            child: Center(
              child: Container(
                //color: Colors.grey,
                width: 80,
                height: 50,
                child: Image.asset('assets/images/$image.png'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
