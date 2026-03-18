import 'package:expens/models/onbording_modle.dart';

class OnboardingData {
  static List<Onboarding> onboardingList = [
    Onboarding(
      title: "Gain total control of your money",
      imageUrl: "assets/images/onboard_1.png",
      description:
          "Take full control of your financial life by tracking your income and expenses in one place. Expenz helps you understand your spending habits, manage your cash flow effectively, and make smarter financial decisions with confidence.",
    ),
    Onboarding(
      title: "Know where your money goes",
      imageUrl: "assets/images/onboard_2.png",
      description:
          "Stay informed about every transaction you make. With detailed insights and clear visual breakdowns, you can easily see where your money is going and identify areas where you can save more and spend wisely.",
    ),
    Onboarding(
      title: "Planning ahead",
      imageUrl: "assets/images/onboard_3.png",
      description:
          "Build a secure financial future by planning ahead. Set budgets, define your financial goals, and track your progress over time. Expenz helps you stay prepared and in control, no matter what life brings.",
    ),
  ];
}
