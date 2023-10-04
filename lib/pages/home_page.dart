import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.blue.shade300,
      //   title: const Text(
      //     'Quiz of Capitals',
      //     style: TextStyle(
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/capitals.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 50),
                child: const Icon(
                  Icons.wb_sunny,
                  size: 100,
                  color: Colors.lightBlueAccent,
                ),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: const Color.fromRGBO(0, 191, 255, 0.4), // More vivid and less opaque light blue
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  children: [
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(top: 10, bottom: 25),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.blue.shade100,
                            Colors.blue.shade300,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Text(
                          'QUIZ APP',
                          style: TextStyle(
                            color:  Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/quiz-page');
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.blue.shade300,
                        elevation: 4,
                        side: const BorderSide(color: Colors.white, width: 1),
                      ),
                      child: const Text(
                        'Start Quiz',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/review-page');
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.blue.shade300,
                        elevation: 4,
                        side: const BorderSide(color: Colors.white, width: 1),
                      ),
                      child: const Text(
                        'Review Quiz',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
