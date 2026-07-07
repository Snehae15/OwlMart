# Implementation Plan

## Step 1

Create project structure

```
app/

core/

features/
```

---

## Step 2

Setup Firebase

- Firebase Core
- Firestore
- Authentication
- Google Sign-In

---

## Step 3

Create Core

- Constants
- Validators
- Helpers
- Services
- Shared Widgets

---

## Step 4

Authentication

### Data

- Auth Data Source
- Auth Repository Implementation

### Domain

- Auth Repository
- Login UseCase
- Logout UseCase

### Presentation

- Authentication Bloc
- Login Page

---

## Step 5

Product Module

### Data

- Firestore Product Data Source
- Product Model

### Domain

- Product Entity
- Product Repository
- Get Products UseCase
- Search Products UseCase
- Add Product UseCase
- Update Product UseCase

### Presentation

- Product Bloc
- Product List
- Product Details

---

## Step 6

Cart Module

- Add Item
- Remove Item
- Update Quantity

---

## Step 7

Wishlist Module

- Add Wishlist
- Remove Wishlist

---

## Step 8

Search Module

- Search by Name
- Search by SKU

---

## Step 9

Category Module

- Category CRUD
- Subcategory CRUD

---

## Step 10

Admin Dashboard

Dashboard Cards

- Total Products
- Total Users
- Total Orders
- Low Stock Products

---

## Step 11

Product Management

Features

- Add Product
- Edit Product
- Delete Product
- Enable Product
- Disable Product
- SKU Generator

---

## Step 12

Stock Management

- Search SKU
- Update Stock

Scanner is optional.

Manual SKU search will be used if scanner is unavailable.

---

## Step 13

Order Management

- View Orders
- Update Status

Checkout is mocked.

---

## Step 14

Testing

- Verify Firestore
- Verify Authentication
- Verify CRUD
- Verify Search
- Verify Dashboard

---

## Step 15

Deployment

- Generate APK
- Push Git Repository
- Complete Documentation