import 'dart:io';

void main() {
 
  List<Map<String, dynamic>> students = [];

  // A set to track used IDs so we enforce uniqueness.
  Set<String> usedIds = {};

  print('Student Records Manager');
  print('Enter student data. To stop, just press Enter for the name.');

  while (true) {
    stdout.write('Enter student name (or press Enter to finish): ');
    String? name = stdin.readLineSync()?.trim();
    if (name == null || name.isEmpty) {
      break;
    }

    // ID
    String id;
    while (true) {
      stdout.write('Enter student ID: ');
      String? inputId = stdin.readLineSync()?.trim();
      if (inputId == null || inputId.isEmpty) {
        print('ID cannot be empty.');
        continue;
      }
      if (usedIds.contains(inputId)) {
        print('This ID ("$inputId") has already been used. Please enter a unique ID.');
        continue;
      }
      id = inputId;
      usedIds.add(id);
      break;
    }

    // Score
    double score;
    while (true) {
      stdout.write('Enter student score (0-100): ');
      String? inputScore = stdin.readLineSync()?.trim();
      if (inputScore == null || inputScore.isEmpty) {
        print('Score cannot be empty.');
        continue;
      }
      try {
        score = double.parse(inputScore);
        if (score < 0 || score > 100) {
          print('Score must be between 0 and 100.');
          continue;
        }
        break;
      } catch (e) {
        print('Invalid number format. Please enter a numeric value.');
      }
    }

    // Determine letter grade
    String grade = _DetermineGrade(score);

    // Add record
    students.add({
      'name': name,
      'id': id,
      'score': score,
      'grade': grade,
    });

    print('>>> Added: name="$name", id="$id", score=$score, grade=$grade');
    print('');
  }

  if (students.isEmpty) {
    print('No student records entered. Exiting.');
    return;
  }

  // Sort by score descending
  students.sort((a, b) => (b['score'] as double).compareTo(a['score'] as double));

  // Compute total, highest, lowest
  int totalStudents = students.length;
  double highestScore = students.first['score'] as double;
  double lowestScore = students.last['score'] as double;

  // Display results
  print('\nStudent List (sorted by score, descending order) ');
  for (var s in students) {
    print('Name: ${s['name']}, ID: ${s['id']}, Score: ${s['score']}, Grade: ${s['grade']}');
  }

  
  print('\n\nTotal number of students: $totalStudents');
  print('Highest score: $highestScore');
  print('Lowest score: $lowestScore');
}


String _DetermineGrade(double score) {
   if (score >= 90) return 'A+';
  if (score >= 80) return 'A';
  if (score >= 70) return 'B';
  if (score >= 60) return 'C';
  if (score >= 50) return 'D';
  return 'F';
}
