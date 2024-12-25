# ExSync
A comprehensive expense tracker application
. This application helps you manage and track your expenses efficiently. Whether you're looking to manage your budgets or simply keep track of your spending habits, ExSync provides all the tools you need to stay on top of your finances.


## Key Features
- **Smooth Transitions**: Smooth transitions enhance the user experience by providing a visually appealing and fluid interaction when navigating through different parts of the application. This can include animations, fade-ins, slide-ins, and other effects that make the UI feel more responsive and polished.
- **Secure Authentication**: A robust and secure login system to protect user data and ensure safe access.
- **Intuitive User Interface**: A clean, modern design for a seamless user experience.
- **Interactive Dashboard**: A dynamic dashboard featuring insightful charts and graphs to track and analyze your financial data.
- **Income Management**: Effortlessly manage your income sources and keep track of your earnings.
- **Expense Management**: Easily monitor and categorize your expenses to maintain financial control.
- **Comprehensive Reports**: Detailed reports offering in-depth analysis of your finances, including summaries and trends.
- **Day-wise Calendar View**: A convenient calendar view that helps you track your expenses on a daily basis for better budgeting and planning.


## Project Structure
```bash
/exsync
    |---android/                # Contains Android-specific code and resources
    |---assets/                 # Directory for storing static assets like images, fonts, etc.
    |---ios/                    # Contains iOS-specific code and resources
    |---lib/                    # Main directory for Dart code, including the app's source code
        |---common/             # Common utilities and components used across the app
            |---theme/          # Theme-related files for consistent styling
                |---theming.dart # Main theming file
            |---widgets/        # Reusable UI components
        |---features/           # Feature-specific code
            |---auth/           # Authentication-related features
                |---login/      # Login feature
                    |---logics/ # Business logic for login
                        |---login_bloc.dart # BLoC pattern for login
                        |---login_event.dart # Events for login BLoC
                        |---login_state.dart # States for login BLoC
                    |---presentation/ # UI for login
                        |---login_screen.dart # Login screen UI
                    |---repository/ # Data handling for login
                        |---login_repository.dart # Repository for login data
        |---firebase_options.dart # Firebase configuration options
        |---main.dart             # Entry point of the application
    |---linux/                  # Contains Linux-specific code and resources
    |---macos/                  # Contains macOS-specific code and resources
    |---web/                    # Contains web-specific code and resources
    |---windows/                # Contains Windows-specific code and resources
    |---.gitignore              # Specifies files and directories to be ignored by Git
    |---.metadata               # Metadata file for the project (used by Dart/Flutter tools)
    |---analysis_options.yaml   # Configuration for Dart static analysis (linting rules)
    |---expense_tracker.iml     # IntelliJ IDEA project file (metadata)
    |---firebase.json           # Firebase configuration file
    |---pubspec.lock            # Lock file for Dart packages, ensuring consistent versions
    |---pubspec.yaml            # Dart package configuration file, specifying dependencies and other settings
    |---README.md               # Markdown documentation file, typically contains project overview and instructions
```

## Technology
Frontend: Flutter

Backend: Firebase

External dependencies used for frontend:
```bash
firebase_core: ^3.8.1
flutter_bloc: ^8.1.6
equatable: ^2.0.7
firebase_auth: ^5.3.4
shared_preferences: ^2.3.3
google_fonts: ^6.2.1
smooth_page_indicator: ^1.2.0+3
quickalert: ^1.1.0
flutter_animate: ^4.5.2
cloud_firestore: ^5.6.0
intl: ^0.19.0
fl_chart: ^0.69.2
syncfusion_flutter_calendar: 27.2.5
shimmer: ^3.0.0
```

## Author
**Kaium Al Limon**
- GitHub: [Kaium's Github](https://github.com/kaiumallimon)
- LinkedIn: [Kaium's LinkedIn](https://www.linkedin.com/in/kaiumallimon/)
- Facebook: [Kaium's Facebook](https://www.facebook.com/lemon.exee)