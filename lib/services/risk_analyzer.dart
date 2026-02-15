class RiskAnalyzer {
  double calculateRiskScore(double amount) {
    double score = 0.0;

    // Rule 1: amount > 5000 → +0.7
    if (amount > 5000) {
      score += 0.7;
    }
    // Rule 2: amount > 1000 → +0.4
    else if (amount > 1000) {
      score += 0.4;
    }

    // Rule 3: negative amount → +0.2
    if (amount < 0) {
      score += 0.2;
    }

    // Cap at 1.0
    if (score > 1.0) {
      score = 1.0;
    }

    return score;
  }
}
