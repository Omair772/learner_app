import 'package:flutter_test/flutter_test.dart';
import 'package:learner_app/main.dart';

void main() {
  testWidgets('Learner App loads', (WidgetTester tester) async {
    await tester.pumpWidget(const LearnerApp());

    expect(find.text('Learner App'), findsOneWidget);
  });
}