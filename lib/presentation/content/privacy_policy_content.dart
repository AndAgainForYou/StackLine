class PrivacyPolicySection {
  const PrivacyPolicySection({
    required this.title,
    this.body,
    this.bullets = const [],
  });

  final String title;
  final String? body;
  final List<String> bullets;
}

class PrivacyPolicyContent {
  PrivacyPolicyContent._();

  static List<PrivacyPolicySection> forLocale(String languageCode) {
    return languageCode == 'uk' ? _uk : _en;
  }

  static const _en = [
    PrivacyPolicySection(
      title: 'Summary',
      bullets: [
        'Stackline is an offline-first puzzle game.',
        'Your high score and saved game progress are stored locally on your device.',
        'We do not require an account, login, or registration.',
        'The app may show ads through Google AdMob after a game ends.',
        'The app uses Firebase Core for basic platform initialization.',
      ],
    ),
    PrivacyPolicySection(
      title: 'Information stored on your device',
      body:
          'The app may store the following data locally using on-device storage:',
      bullets: [
        'High score',
        'Saved game session (board state, score, and related game progress)',
        'Selected theme and language preferences',
      ],
    ),
    PrivacyPolicySection(
      title: 'Information we do not collect directly',
      body: 'We do not ask for or collect directly from you:',
      bullets: [
        'Name, email address, or phone number',
        'Contacts, photos, or files',
        'Precise location',
        'Payment information',
      ],
    ),
    PrivacyPolicySection(
      title: 'Advertising (Google AdMob)',
      body:
          'Stackline may display banner advertisements after a game ends. Google may collect and use information such as advertising ID, device type, operating system, app version, ad interaction data, and approximate location derived from IP address to serve and measure ads.',
    ),
    PrivacyPolicySection(
      title: 'Firebase',
      body:
          'The app uses Firebase Core for platform services and app initialization. Firebase/Google may process limited technical information such as device identifiers, app instance data, and diagnostic logs required for service operation.',
    ),
    PrivacyPolicySection(
      title: 'Third-party services',
      body: 'The app may interact with the following third-party services:',
      bullets: [
        'Google AdMob — advertising',
        'Google Firebase — platform services',
      ],
    ),
    PrivacyPolicySection(
      title: 'Data retention',
      body:
          'Local game data remains on your device until you delete it or uninstall the app. Data processed by Google services is retained according to Google policies and your device settings.',
    ),
    PrivacyPolicySection(
      title: 'Children\'s privacy',
      body:
          'Stackline is intended for a general audience. We do not knowingly collect personal information from children.',
    ),
    PrivacyPolicySection(
      title: 'Security',
      body:
          'We take reasonable steps to protect information stored on your device through standard platform security features. No method of storage or transmission is 100% secure.',
    ),
    PrivacyPolicySection(
      title: 'Your choices',
      bullets: [
        'Delete local app data in your device settings',
        'Uninstall the app to remove locally stored information',
        'Adjust ad personalization in your device privacy settings',
      ],
    ),
    PrivacyPolicySection(
      title: 'Changes to this policy',
      body:
          'We may update this Privacy Policy from time to time. Continued use of the app after changes means you accept the updated policy.',
    ),
    PrivacyPolicySection(
      title: 'Contact',
      body:
          'If you have questions about this Privacy Policy, contact us via GitHub Issues in the Stackline repository.',
    ),
  ];

  static const _uk = [
    PrivacyPolicySection(
      title: 'Коротко',
      bullets: [
        'Stackline — офлайн-гра-головоломка.',
        'Рекорд і збережена гра зберігаються локально на вашому пристрої.',
        'Реєстрація та вхід не потрібні.',
        'Після програшу можуть показуватися рекламні банери Google AdMob.',
        'Додаток використовує Firebase Core для базової ініціалізації.',
      ],
    ),
    PrivacyPolicySection(
      title: 'Дані на вашому пристрої',
      body: 'Додаток може локально зберігати:',
      bullets: [
        'Рекорд',
        'Збережену гру (стан поля, рахунок та прогрес)',
        'Обрану тему та мову',
      ],
    ),
    PrivacyPolicySection(
      title: 'Що ми не збираємо напряму',
      body: 'Ми не запитуємо і не збираємо:',
      bullets: [
        'Ім\'я, email або номер телефону',
        'Контакти, фото чи файли',
        'Точну геолокацію',
        'Платіжні дані',
      ],
    ),
    PrivacyPolicySection(
      title: 'Реклама (Google AdMob)',
      body:
          'Після програшу можуть показуватися банери Google AdMob. Google може збирати рекламний ID, тип пристрою, ОС, версію додатку, дані про взаємодію з рекламою та приблизну локацію за IP для показу та аналітики реклами.',
    ),
    PrivacyPolicySection(
      title: 'Firebase',
      body:
          'Додаток використовує Firebase Core. Google/Firebase може обробляти обмежені технічні дані: ідентифікатори пристрою, дані екземпляра додатку та діагностичні журнали.',
    ),
    PrivacyPolicySection(
      title: 'Сторонні сервіси',
      body: 'Додаток може взаємодіяти з:',
      bullets: [
        'Google AdMob — реклама',
        'Google Firebase — платформені сервіси',
      ],
    ),
    PrivacyPolicySection(
      title: 'Зберігання даних',
      body:
          'Локальні дані гри залишаються на пристрої, доки ви їх не видалите або не деінсталюєте додаток. Дані Google зберігаються згідно з політиками Google та налаштуваннями пристрою.',
    ),
    PrivacyPolicySection(
      title: 'Діти',
      body:
          'Stackline призначено для широкої аудиторії. Ми свідомо не збираємо персональні дані дітей.',
    ),
    PrivacyPolicySection(
      title: 'Безпека',
      body:
          'Ми використовуємо стандартні засоби безпеки платформи. Жоден спосіб зберігання або передачі даних не є на 100% безпечним.',
    ),
    PrivacyPolicySection(
      title: 'Ваші можливості',
      bullets: [
        'Видалити дані додатку в налаштуваннях пристрою',
        'Деінсталювати додаток',
        'Обмежити персоналізацію реклами в налаштуваннях приватності',
      ],
    ),
    PrivacyPolicySection(
      title: 'Зміни політики',
      body:
          'Ми можемо оновлювати цю політику. Продовження використання додатку означає прийняття оновленої версії.',
    ),
    PrivacyPolicySection(
      title: 'Контакт',
      body:
          'З питаннями звертайтеся через GitHub Issues у репозиторії Stackline.',
    ),
  ];
}
