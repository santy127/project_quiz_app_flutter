import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(  // Scaffold = Used for a new page
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30, bottom: 50),
            child: Icon(
              Icons.wb_sunny_outlined,
              size: 100,
              color: Colors.purple.shade100,
            ),
          ),
          Card(
            margin: const EdgeInsets.all(20), // To make it look more separated from the edge of the screen
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.indigo.shade200,
            child: ListView(
              shrinkWrap: true, // Solution
              padding: const EdgeInsets.all(10),
              children: [
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 10, bottom: 25),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.indigo.shade200,
                        Colors.purple.shade300
                      ]
                    ),
                    borderRadius: BorderRadius.circular(5),
                    ),
                  child: const Center(
                    child: Text('QUIZ APP',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                OutlinedButton(
                  onPressed: () {
                    // This automatically adds a button to go back.
                    Navigator.pushNamed(context, '/quiz-page');
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.indigo.shade100,
                    elevation: 4,
                    side: const BorderSide(width: 1),
                  ),
                  child: const Text(
                    'Start Quiz',
                    style: TextStyle(color: Colors.black), // Set the text color
                  ),
                ),
                const SizedBox(
                  height: 10, // Space between buttons
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/review-page');
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.indigo.shade100,
                    elevation: 4,
                    side: const BorderSide(width: 1),
                  ),
                  child: const Text(
                    'Review Quiz',
                    style: TextStyle(color: Colors.black), // Set the text color
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
