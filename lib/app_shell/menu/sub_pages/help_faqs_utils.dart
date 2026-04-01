

enum FAQsGroup {
  userAccount,
  appSettings,
  helpSupport,
  projectManagement,
  other,
}

class FAQsModel {
  final String question;
  final String answer;
  final FAQsGroup typeFAQ;
  final bool isDisable;

  const FAQsModel({
    required this.question,
    required this.answer,
    required this.typeFAQ,
    this.isDisable = false,
  });
}

final List<FAQsModel> listFAQs = [
  // User Account
  FAQsModel(
    question: 'How do I create an account?',
    answer:
        'You can create an account by signing up using your email address or social login options.',
    typeFAQ: FAQsGroup.userAccount,
  ),
  FAQsModel(
    question: 'I forgot my password. What should I do?',
    answer:
        'Use the "Forgot Password" option on the login screen to reset your password.',
    typeFAQ: FAQsGroup.userAccount,
  ),
  FAQsModel(
    question: 'How can I delete my account?',
    answer:
        'Account deletion can be requested from the profile settings or by contacting support.',
    typeFAQ: FAQsGroup.userAccount,
  ),

  // App Settings
  FAQsModel(
    question: 'How do I change app language?',
    answer: 'Go to App Settings and select your preferred language.',
    typeFAQ: FAQsGroup.appSettings,
  ),
  FAQsModel(
    question: 'Can I enable dark mode?',
    answer: 'Yes, dark mode can be enabled from the appearance settings.',
    typeFAQ: FAQsGroup.appSettings,
  ),

  // Help & Support
  FAQsModel(
    question: 'How do I contact support?',
    answer:
        'You can contact support via the Help & Support section in the app menu.',
    typeFAQ: FAQsGroup.helpSupport,
  ),
  FAQsModel(
    question: 'Why is the app not working properly?',
    answer:
        'Please ensure you are using the latest version of the app and have a stable internet connection.',
    typeFAQ: FAQsGroup.helpSupport,
  ),

  // Project Management
  FAQsModel(
    question: 'How do I create a new project?',
    answer: 'Navigate to the dashboard and tap on "Create Project".',
    typeFAQ: FAQsGroup.projectManagement,
  ),
  FAQsModel(
    question: 'Can I edit a project after creating it?',
    answer:
        'Yes, projects can be edited anytime from the project details screen.',
    typeFAQ: FAQsGroup.projectManagement,
  ),
  FAQsModel(
    question: 'How do I assign tasks?',
    answer:
        'Tasks can be assigned to team members from within the project view.',
    typeFAQ: FAQsGroup.projectManagement,
  ),

  // Other
  FAQsModel(
    question: 'Is my data secure?',
    answer:
        'Yes, we follow industry-standard security practices to protect your data.',
    typeFAQ: FAQsGroup.other,
  ),
  FAQsModel(
    question: 'Does the app work offline?',
    answer:
        'Some features may work offline, but full functionality requires an internet connection.',
    typeFAQ: FAQsGroup.other,
  ),
];

/////
