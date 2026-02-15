# Ledgerly

A Flutter transaction tracking app built with Clean Architecture principles.

## Features

- Add transactions with title and amount
- View transaction list
- Risk score calculation for each transaction
- Simple and clean UI

## Architecture

This project follows Clean Architecture with three main layers:

### Domain Layer
- **Entities**: Pure business objects (`Transaction`)
- **Repositories**: Abstract interfaces
- **Use Cases**: Business logic (`AddTransaction`, `GetTransactions`)

### Data Layer
- **Models**: Data transfer objects with JSON serialization
- **Data Sources**: Firebase Firestore implementation
- **Repository Implementation**: Bridges domain and data layers

### Presentation Layer
- **Cubit**: State management using `flutter_bloc`
- **Pages**: UI components

## Tech Stack

- **State Management**: Cubit (flutter_bloc)
- **Dependency Injection**: GetIt
- **Routing**: go_router
- **Backend**: Firebase Firestore
- **Error Handling**: dartz (Either pattern)

## Risk Calculation Rules

- Amount > 5000 → Risk +0.7
- Amount > 1000 → Risk +0.4
- Negative amount → Risk +0.2

## Project Structure

```
lib/
├── core/                    # Shared utilities
│   ├── error/              # Failure classes
│   ├── usecases/           # Base UseCase
│   └── di/                 # Dependency injection
├── features/
│   └── transaction/
│       ├── domain/         # Business logic
│       ├── data/           # Data layer
│       └── presentation/   # UI layer
├── services/               # App services
├── routes/                 # Navigation
└── screens/                # General screens
```

## Getting Started

1. Clone the repository
2. Run `flutter pub get`
3. Configure Firebase
4. Run `flutter run`

## Testing

Run tests with:
```bash
flutter test
```
