import 'package:flutter/material.dart';
import 'package:quiz_app/classes/quiz.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key, required this.quiz});
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quiz.name, style: const TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue.shade200,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white), // Change arrow color to white
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/capitals_map.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 3, right: 3, top: 20, bottom: 15), // Adjust space
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.6), // Change color and opacity according to your preferences
                  border: Border.all(
                    color: Colors.indigo.shade50,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Questions: ${quiz.questions.length}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'Percentage: ${quiz.percent}%',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: quiz.questions.length,
                    itemBuilder: (_, index) {
                      return Card(
                        color: quiz.questions[index].correct
                            ? Colors.green.shade200
                            : Colors.red.shade200,
                        child: ListTile(
                          leading: quiz.questions[index].correct
                              ? Icon(Icons.check, color: Colors.green.shade900)
                              : Icon(Icons.close, color: Colors.red.shade900),
                          title: Text(quiz.questions[index].question),
                          subtitle: Text(quiz.questions[index].selected),
                          trailing: Text(quiz.questions[index].answer),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
