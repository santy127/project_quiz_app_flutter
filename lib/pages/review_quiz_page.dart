import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/classes/question.dart';
import 'package:quiz_app/classes/quiz.dart';

class ReviewQuizPage extends StatefulWidget {
  const ReviewQuizPage({super.key});

  @override
  State<ReviewQuizPage> createState() => _ReviewQuizPageState();
}

class _ReviewQuizPageState extends State<ReviewQuizPage> {

  Quiz quiz = Quiz(name: 'Quiz of Capitals', questions: []);

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/countries.json');
    final List<dynamic> data = await json.decode(response);
    for (var item in data) {
      Question question = Question.fromJson(item);
      question.question += question.country;
      quiz.questions.add(question);
    }
    setState(() {});
  }

  @override
  void initState(){
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: quiz.questions.isNotEmpty ? Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin:
                const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 10),
            width: double.infinity, // So that it takes as much width as it can
            decoration: BoxDecoration(
              border: Border.all(color: Colors.indigo.shade50, width: 1),
            ),
            child: Center(
              child: Text('Questions: ${quiz.questions.length}',
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: quiz.questions.length,
                itemBuilder: (_, index) {
                  return Card(
                    color: Theme.of(context).primaryColorLight,
                    child: ListTile(
                      leading: Text('${index + 1}'),
                      title: Text(quiz.questions[index].question),
                      trailing: Text(quiz.questions[index].answer),
                    ),
                  );
                }),
          ),
        ],
      )
        : const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          )
      ),
    );
  }
}
