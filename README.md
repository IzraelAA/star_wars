<response>

# Star Wars Bloc Application with Clean Architecture

Overview
This Flutter application embraces Uncle Bob's Clean Architecture and employs the BLoC pattern for robust state management. Utilizing Dio as the networking module, the app seamlessly integrates with the SWAPI (Star Wars API) to fetch and display data.

### Caching Mechanism
Data is cached using shared preferences. Any data created more than one week ago will be automatically removed.

## Getting Started

### Prerequisites
- Ensure Flutter is installed on your machine.

### Installation
1. Clone the repository: `git clone https://github.com/IzraelAA/star_wars`
2. Navigate to the project directory: `cd https://github.com/IzraelAA/star_wars`
3. Run `flutter pub get` to fetch dependencies.


### Build Runner and Dependency Injection Setup
1. Ensure `build_runner` is installed globally: `flutter pub global activate build_runner`
2. Run the following command to generate code and set up injection:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Run the Application
Execute the following command to run the application:
```bash
flutter run
```

## Folder Structure
- **injection/** *(Dependency injection setup)*
- **main.dart** *(Entry point)*
- **lib/**
  - **presentation/** *(UI layer)*
  - **domain/** *(Business logic layer)*
  - **data/** *(Data layer)*
 
 
 
