# 🛒 OwlMart

A production-ready mini e-commerce application built with **Flutter**, **Firebase**, and **BLoC**, following **Clean Architecture** and the **Repository Pattern**.

This project was developed as part of a Flutter machine test to demonstrate scalable architecture, clean code practices, state management, Firebase integration, and responsive UI design.

---

## ✨ Features

### 👤 User Module

* 🔐 Email & Password Authentication
* 🔑 Google Sign-In
* 🏠 Home Screen
* 📦 Product Listing
* 🔍 Product Search
* ❤️ Wishlist Management
* 🛒 Shopping Cart
* 📄 Product Details
* 📂 Browse by Categories & Subcategories
* 🚪 Logout
* ⏳ Loading & Error States

---

### 👨‍💼 Admin Module

* 🔒 Secure Admin Login
* 📊 Dashboard

  * Total Products
  * Total Users
  * Total Orders (Mock)
  * Low Stock Products
* ➕ Add Product
* ✏️ Edit Product
* 🗑️ Delete Product
* 🔄 Enable / Disable Products
* 📂 Category & Subcategory Management
* 📦 Automatic SKU Generation
* 📷 Barcode / SKU Search
* 📉 Stock Management
* 📋 Basic Order Management (Mock)

---

## 🏗️ Architecture

The project follows **Clean Architecture** with **BLoC** for state management.

```text
lib/
├── core/
│   ├── constants/
│   ├── services/
│   ├── utils/
│   └── widgets/
│
├── features/
│   ├── authentication/
│   ├── admin/
│   ├── product/
│   ├── cart/
│   ├── wishlist/
│   └── orders/
│
├── shared/
└── main.dart
```

Each feature is divided into:

* **Presentation**

  * Pages
  * Widgets
  * BLoC
* **Domain**

  * Entities
  * Repository Contracts
  * Use Cases
* **Data**

  * Models
  * Data Sources
  * Repository Implementations

---

## 🚀 Tech Stack

| Technology              | Used |
| ----------------------- | ---- |
| Flutter                 | ✅    |
| Dart                    | ✅    |
| Firebase Authentication | ✅    |
| Cloud Firestore         | ✅    |
| Google Sign-In          | ✅    |
| flutter_bloc            | ✅    |
| Repository Pattern      | ✅    |
| Clean Architecture      | ✅    |
| Null Safety             | ✅    |

---

## 📦 Packages

* flutter_bloc
* firebase_core
* firebase_auth
* cloud_firestore
* google_sign_in
* equatable
* get_it
* uuid
* image_picker
* qr_flutter
* barcode
* cached_network_image

---

## 🔑 Test Credentials

### 👨‍💼 Admin

```text
Email:
admin@owlmart.com

Password:
Admin@123
```

### 👤 User 1

```text
Email:
user1@owlmart.com

Password:
User@123
```

### 👤 User 2

```text
Email:
user2@owlmart.com

Password:
User@123
```

---

## ⚙️ Getting Started

### Clone the repository

```bash
git clone https://github.com/Snehae15/OwlMart.git
```

### Install dependencies

```bash
flutter pub get
```

### Configure Firebase

```bash
flutterfire configure
```

Enable the following Firebase services:

* Firebase Authentication
* Email/Password Authentication
* Google Sign-In
* Cloud Firestore

Download and add:

* `google-services.json` (Android)
* `GoogleService-Info.plist` (iOS)

---

## ▶️ Run the App

```bash
flutter run
```

---

## 📱 Build Release APK

```bash
flutter build apk --release
```

APK output:

```text
build/app/outputs/flutter-apk/app-release.apk
```

---

## 📂 Project Highlights

* ✅ Clean Architecture
* ✅ Repository Pattern
* ✅ BLoC State Management
* ✅ Firebase Authentication
* ✅ Cloud Firestore Integration
* ✅ Responsive UI
* ✅ Reusable Widgets
* ✅ SKU Generation
* ✅ Barcode/SKU Search
* ✅ Product CRUD
* ✅ Category Management
* ✅ Wishlist
* ✅ Shopping Cart
* ✅ Search Functionality
* ✅ Loading & Error Handling

---

## 🎯 Bonus Features

* Responsive UI
* Optimized Firestore Queries
* Reusable Components
* Product Status Toggle
* Mock Order Management
* Image Placeholders (where applicable)

---

## 🔮 Future Improvements

* Offline Caching
* Pagination
* Crashlytics
* Dark Mode
* Unit Tests
* Payment Gateway Integration
* Push Notifications
* Order Tracking
* Product Reviews

---


## 👩‍💻 Developed By

**Sneha E**

Flutter Developer

GitHub: https://github.com/Snehae15

---

## 🙏 Thank You

Thank you for reviewing my submission.

This project demonstrates my understanding of Flutter development, Clean Architecture, BLoC state management, Firebase integration, scalable application design, and best coding practices.
