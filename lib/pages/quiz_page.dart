import 'dart:convert';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/classes/question.dart';
import 'package:quiz_app/classes/quiz.dart';
import 'package:quiz_app/pages/results_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

String getLetter(int index) {
  // This function returns letters in alphabetical order: A, B, C, ...
  // Index 0 corresponds to 'A', index 1 corresponds to 'B', and so on.
  if (index >= 0 && index < 36) {
    return String.fromCharCode('A'.codeUnitAt(0) + index);
  } else {
    // If the index is out of range (for example, beyond option D),
    // it just returns blank.
    return ' ';
  }
}

class _QuizPageState extends State<QuizPage> {
  int totalQuestions = 5;
  int totalOptions = 4;
  int questionIndex = 0;
  int progressIndex = 0;
  Quiz quiz = Quiz(name: 'Quiz of Capitals', questions: []);

  Future<void> readJson() async {
    // Some things
    final String response = await rootBundle.loadString('assets/countries.json');
    final List<dynamic> data = await json.decode(response);
    List<int> optionList = List<int>.generate(data.length, (i) => i);
    List<int> questionsAdded = [];

    while (true) {
      optionList.shuffle();
      int answer = optionList[0];
      if (questionsAdded.contains(answer)) continue;
      questionsAdded.add(answer);

      List<String> otherOptions = [];
      for (var option in optionList.sublist(1, totalOptions)) {
        otherOptions.add(data[option]['capital']);
      }

      Question question = Question.fromJson(data[answer]);
      question.addOptions(otherOptions);
      quiz.questions.add(question);

      if (quiz.questions.length >= totalQuestions) break;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // function to load the json data
    readJson();
  }

  void _optionSelected(String selected) {
    quiz.questions[questionIndex].selected = selected;
    if (selected == quiz.questions[questionIndex].answer) {
      quiz.questions[questionIndex].correct = true;
      quiz.right += 1;
    }

    progressIndex += 1;
    if (questionIndex < totalOptions) {  // Here delete the -1
      questionIndex += 1;
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => _buildResultDialog(context));
    }

    setState(() {});
  }

  Widget _buildResultDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Results', style: Theme.of(context).textTheme.displayLarge),
      backgroundColor: Colors.blue.shade300,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total questions: $totalQuestions',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text('Correct questions: ${quiz.right}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text('Incorrect questions: ${(totalQuestions - quiz.right)}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text('Percentage: ${quiz.percent}%',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
      actions: [
          TextButton(
        onPressed: () {
            Navigator.of(context).pop();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: ((context) => ResultsPage(quiz: quiz,))
              ),
            );
          },
          child: Text(
              'See Answers',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quiz.name, style: const TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue.shade200,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white), // Change the arrow color to white
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/capitals_map.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: LinearProgressIndicator(
                  color: Colors.lightGreen,
                  value: (progressIndex / totalQuestions),
                  minHeight: 20,
                ),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 450),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: quiz.questions.isNotEmpty
                    ? Card(
                  elevation: 0,
                  color: Colors.blue.withOpacity(0.6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: Text(
                          quiz.questions[questionIndex].question,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: totalOptions,
                          itemBuilder: (_, index) {
                            return Container(
                              margin: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.indigo.shade100,
                                    width: 2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                leading: Text(
                                  getLetter(index), // Use the getLetter function
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                title: Text(
                                  quiz.questions[questionIndex]
                                      .options[index],
                                  style:
                                  Theme.of(context).textTheme.bodyLarge,
                                ),
                                onTap: () {
                                  _optionSelected(quiz
                                      .questions[questionIndex]
                                      .options[index]);
                                }, // Effect of clicking on the answer to the question
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
                    : const CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _optionSelected('Skipped');
              },
              child: Text(
                'Skip',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 24,
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
