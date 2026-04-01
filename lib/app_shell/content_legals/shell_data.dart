import '../app_shell_io.dart';

class ShellContent {
  final String? image;
  final String title;
  final String info;
  final String? description;
  final List<String>? items;

  const ShellContent({
    this.image,
    required this.title,
    required this.info,
    this.description,
    this.items,
  });
}

/// ─────────────────────────────────────────────
/// StorePool (Zi_3) App Content Configuration
/// ─────────────────────────────────────────────

abstract class ShellData {
  ShellData._();

  // ─── App Identity ─────────────────────────────────────────
  static const ShellContent appInfo = ShellContent(
    image: ShellImages.logo,
    title: 'StorePool (Zi_3)',
    info: 'Instant Digital Store Builder',
    description:
        'A rapid digitization tool for small businesses to create online stores in minutes, manage orders, and replace WhatsApp-based selling with structured commerce.',
  );

  // ─── Splash ───────────────────────────────────────────────
  static const ShellContent appSplash = ShellContent(
    image: ShellImages.logo,
    title: 'StorePool',
    info: 'Launch your store in minutes',
    description: 'Powered by ZiCore',
  );

  // ─── Onboarding ───────────────────────────────────────────
  static const List<ShellContent> onboarding = [
    ShellContent(
      image: ShellImages.onBoarding1,
      title: 'Create Your Store in 5 Minutes',
      info: 'Set up products or services instantly with zero technical setup.',
      description: 'Perfect for small shops and local businesses.',
    ),
    ShellContent(
      image: ShellImages.onBoarding1,
      title: 'Replace WhatsApp Ordering Chaos',
      info: 'Turn chats into structured orders with a simple system.',
      description: 'No more missed or confused orders.',
    ),
    ShellContent(
      image: ShellImages.onBoarding1,
      title: 'Share Your Store Link',
      info: 'Customers browse and order directly from your public store page.',
      description: 'One link for all your products & services.',
    ),
  ];

  // ─── ZGate ────────────────────────────────────────────────
  static const ShellContent zGate = ShellContent(
    title: 'Welcome to StorePool',
    info: 'Sign in or create an account\nand launch your digital store instantly.',
  );

  // ─── Auth ─────────────────────────────────────────────────
  static const ShellContent register = ShellContent(
    image: ShellImages.logo,
    title: 'Create Your Store Owner Account',
    info: 'Start building your online store in minutes.',
    description: 'Join early sellers going digital with StorePool.',
  );

  static const ShellContent login = ShellContent(
    image: ShellImages.logo,
    title: 'Welcome Back',
    info: 'Continue managing your store and orders.',
  );

  static const ShellContent forgotPassword = ShellContent(
    title: 'Forgot Password?',
    info: "Enter your email and we’ll send you a reset link.",
  );

  static const ShellContent resetPassword = ShellContent(
    title: 'Reset Password',
    info: 'Set a new password for your StorePool account.',
  );

  static const ShellContent editProfile = ShellContent(
    title: 'Update Profile',
    info: 'Keep your store owner details up to date.',
  );

  // ─── About App ────────────────────────────────────────────
  static const ShellContent appAbout = ShellContent(
    image: ShellImages.logo,
    title: 'StorePool (Zi_3)',
    info: 'Our Mission',
    description:
        'To help small businesses move from informal selling (WhatsApp-based) to structured digital stores in minutes with zero complexity.',
    items: [
      '1: Enable instant online store creation for SMEs.',
      '2: Replace manual ordering with structured digital workflows.',
      '3: Help sellers share a single store link for all products/services.',
    ],
  );

  // ─── Features (MVP Scope) ─────────────────────────────────
  static const ShellContent appFeatures = ShellContent(
    title: 'StorePool MVP Features',
    info: 'Core System (April 2026)',
    items: [
      '1: Store creation with instant public store link (slug-based).',
      '2: Category management (Products / Services).',
      '3: Unified item system (products + services).',
      '4: Cart-based ordering system (web).',
      '5: Guest checkout (name + phone only).',
      '6: Order management with status tracking.',
      '7: Basic dashboard (orders + items summary).',
      '8: Firebase Auth-based store owner system.',
    ],
  );

  // ─── Terms & Conditions ───────────────────────────────────
  static const ShellContent appTermsConditions = ShellContent(
    title: 'Terms & Conditions',
    info: 'Please read carefully before using StorePool.',
    items: [
      '1: StorePool is designed for lawful business use only.',
      '2: Users are responsible for maintaining account security.',
      '3: Misuse of the platform may result in account suspension.',
      '4: Data entered remains owned by the store owner.',
      '5: Service availability may change during MVP phase.',
      '6: StorePool is not responsible for losses due to misuse or downtime.',
    ],
  );

  // ─── Privacy Policy ───────────────────────────────────────
  static const ShellContent appPrivacyPolicy = ShellContent(
    title: 'Privacy Policy',
    info: 'Your data is protected and remains your property.',
    items: [
      '1: We collect only essential data for store functionality.',
      '2: All business data is securely stored in Firebase.',
      '3: We do not sell or share user data with third parties.',
      '4: Users can request account deletion anytime.',
      '5: Analytics may be used to improve system performance.',
      '6: Policy updates will be communicated inside the app.',
    ],
  );

  // ─── Contact ──────────────────────────────────────────────
  static const ShellContent appContact = ShellContent(
    title: 'Contact Us',
    info: 'We’re here to support your store journey.',
    items: [
      'Phone: +92 342 4264494',
      'Email: support@storepool.app',
      'Website: www.storepool.app',
    ],
  );

  static const ShellContent appDevelopers = ShellContent(
    title: 'ZiCore',
    info: 'Built by ZiCore Team',
    items: [
      'Phone: +92 000 0000000',
      'Email: hello@zicore.dev',
      'Website: www.zicore.dev',
    ],
  );
}