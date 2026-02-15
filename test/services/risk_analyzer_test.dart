import 'package:flutter_test/flutter_test.dart';
import 'package:ledgerly/services/risk_analyzer.dart';

void main() {
  late RiskAnalyzer riskAnalyzer;

  setUp(() {
    riskAnalyzer = RiskAnalyzer();
  });

  group('RiskAnalyzer', () {
    test('should return 0.0 for amount less than 1000', () {
      final score = riskAnalyzer.calculateRiskScore(500);
      expect(score, 0.0);
    });

    test('should return 0.4 for amount between 1000 and 5000', () {
      final score = riskAnalyzer.calculateRiskScore(2000);
      expect(score, 0.4);
    });

    test('should return 0.7 for amount greater than 5000', () {
      final score = riskAnalyzer.calculateRiskScore(6000);
      expect(score, 0.7);
    });

    test('should add 0.2 for negative amount', () {
      final score = riskAnalyzer.calculateRiskScore(-100);
      expect(score, 0.2);
    });

    test('should combine rules for negative amount > 1000', () {
      final score = riskAnalyzer.calculateRiskScore(-2000);
      expect(score, 0.6); // 0.4 + 0.2
    });

    test('should cap score at 1.0', () {
      final score = riskAnalyzer.calculateRiskScore(-6000);
      expect(score, 1.0); // 0.7 + 0.2 = 0.9, but capped at 1.0
    });
  });
}
