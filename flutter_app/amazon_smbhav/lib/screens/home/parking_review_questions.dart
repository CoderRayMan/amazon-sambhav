import 'package:flutter/material.dart';

class ReviewQuestionsScreen extends StatefulWidget {
  const ReviewQuestionsScreen({super.key});

  @override
  State<ReviewQuestionsScreen> createState() => _ReviewQuestionsScreenState();
}

class _ReviewQuestionsScreenState extends State<ReviewQuestionsScreen> {
  int _currentQuestion = 0;
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'How empty is the parking?',
      'options': ['<5', '~20', '30+'],
      'answer': null,
    },
    {
      'question': 'How would you rate the parking safety?',
      'options': ['Poor', 'Average', 'Excellent'],
      'answer': null,
    },
    {
      'question': 'Is the parking well-lit?',
      'options': ['No', 'Partially', 'Yes'],
      'answer': null,
    },
    {
      'question': 'Would you recommend this parking?',
      'options': ['No', 'Maybe', 'Yes'],
      'answer': null,
    },
  ];

  void _nextQuestion() {
    if (_currentQuestion < _questions.length - 1) {
      setState(() {
        _currentQuestion++;
      });
    } else {
      // Save answers and return to parking list
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    // If it's the first question, display the custom layout
    if (_currentQuestion == 0) {
      return ParkingReviewScreen2(
        onOptionSelected: (answer) {
          _questions[_currentQuestion]['answer'] = answer;
          _nextQuestion();
        },
      );
    }

    // Default screen for other questions
    return Scaffold(
      appBar: AppBar(
        title: Text('Review for Parking #${_currentQuestion + 1}'),

      ),
      floatingActionButton: TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Save & Exit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: (_currentQuestion + 1) / _questions.length,
            ),
            const SizedBox(height: 16),
            Text(
              'Question ${_currentQuestion + 1}/${_questions.length}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Text(
              _questions[_currentQuestion]['question'],
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 32),
            ...(_questions[_currentQuestion]['options'] as List<String>).map(
                  (option) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _questions[_currentQuestion]['answer'] = option;
                      _nextQuestion();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                    child: Text(option),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ParkingReviewScreen2 extends StatelessWidget {
  final Function(String) onOptionSelected;

  const ParkingReviewScreen2({super.key, required this.onOptionSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review for Parking #1'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LinearProgressIndicator(value: 0.33),
            const SizedBox(height: 20),
            const Text('Question 1/4', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            const Text(
              'How empty is the parking?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildParkingOption('<5', Colors.red, onOptionSelected),
                _buildParkingOption('~20', Colors.orange, onOptionSelected),
                _buildParkingOption('30+', Colors.green, onOptionSelected),
              ],
            ),
            const Spacer(),

          ],
        ),
      ),
    );
  }

  Widget _buildParkingOption(String text, Color color, Function(String) onOptionSelected) {
    return Column(
      children: [
        Text(text, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 8),
        CircleAvatar(
          backgroundColor: color,
          child: const Text('P', style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          onPressed: () => onOptionSelected(text),
          child: Text(text),
        ),
      ],
    );
  }
}

class ParkingTable extends StatelessWidget {
  const ParkingTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate to Earn Rewards!!'),
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const CircleAvatar(child: Text('P')),
              title: const Text('123 Fake Street, Apt. 4B, Springfield, CA 12345'),
              subtitle: const Text('15 mins Ago'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: List.generate(
                      3,
                          (index) => const Icon(Icons.star, color: Colors.orange),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('20pts'),
                ],
              ),
              onTap: () {

              },
            ),
          );
        },
      ),
    );
  }
}
