# Flutter Mini E-Commerce Architecture

## Overview

This project follows **Clean Architecture** combined with **BLoC** state management and the **Repository Pattern**.

The architecture separates the application into independent layers, making it scalable, testable, maintainable, and easy to extend.

---

# Architecture Diagram

```
                Presentation Layer
                       │
                 Flutter UI Pages
                       │
                  Flutter BLoC
                       │
                 Domain Layer
                 ─────────────
                  Use Cases
                       │
             Repository Interface
                       │
                 Data Layer
                 ─────────
          Repository Implementation
                       │
          Remote Data Source (Firestore)
                       │
              Firebase Services
```

---

# Layer Responsibilities

## Presentation Layer

Responsible for:

- UI Screens
- Widgets
- BLoC
- Navigation
- Form Validation

Contains

```
presentation/
    bloc/
    pages/
    widgets/
```

No Firebase code exists in this layer.

---

## Domain Layer

Contains business logic.

Responsible for:

- Entities
- Repository Contracts
- Use Cases

Contains

```
domain/

entities/

repository/

usecases/
```

The Domain Layer never depends on Flutter or Firebase.

---

## Data Layer

Responsible for data access.

Contains

```
data/

datasource/

models/

repository/
```

Responsibilities

- Firestore Queries
- Firebase Authentication
- JSON Parsing
- Repository Implementation

---

# Repository Pattern

```
UI

↓

Bloc

↓

Use Case

↓

Repository Interface

↓

Repository Implementation

↓

Firestore
```

Presentation never communicates directly with Firebase.

---

# State Management

Every feature owns its own BLoC.

Example

```
AuthenticationBloc

ProductBloc

CartBloc

WishlistBloc

CategoryBloc

DashboardBloc

OrderBloc
```

Each BLoC contains

```
Event

State

Bloc
```

---

# Firestore Collections

```
users

products

categories

wishlist

cart

orders
```

---

# Project Structure

```
lib/

app/

core/

features/

authentication/

home/

product/

cart/

wishlist/

search/

category/

orders/

admin/

main.dart
```

Each feature follows

```
data/

domain/

presentation/
```

---

# Design Principles

- Clean Architecture
- SOLID Principles
- Repository Pattern
- BLoC State Management
- Feature-first Structure
- Reusable Widgets
- Dependency Injection
- Null Safety
- Responsive UI

---

# Benefits

- Easy to maintain
- Scalable
- Testable
- Reusable
- Production Ready