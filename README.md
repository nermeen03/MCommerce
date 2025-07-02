# 🛍️ TRADIA App (iOS)

An iOS mobile commerce application built with **SwiftUI**, **MVVM architecture**, **GraphQL**, and **manual dependency injection**. The app enables users to browse, search, favorite, and purchase products from various vendors online.

---

## 📱 Features

### 🏠 Home Tab

* Displays a grid of featured products.
* Search bar for products.
* Scrollable horizontal list of brands.
* Tap a brand to view its products with filtering options (e.g., price).
* Scrollable list of ads.

### 🗂️ Category Tab

* View and filter products by **Main Categories** and **Sub-Categories**.
* Supports product search with price-based filtering.

### 👤 Profile Tab

* **Logged-In Users**:

  * Welcome message with user's name.
  * Last 4 orders and 4 wishlist items (with "See More" navigation).
  * Access to settings.
* **Guests**:

  * Prompt to sign in/register.
  * Restricted access to cart and wishlist.

### 🛍️ Product Details

* Product image carousel.
* Name, price, available sizes, and colors.
* Add to favorites or add to cart.

### 🛒 Shopping Cart

* List of cart items with:

  * Product image, name, price
  * Quantity control (respecting stock limits)
  * Delete item
* Live-updating total price.
* Proceed to checkout.

### 💳 Checkout & Payment

* Select payment method:

  * Cash on Delivery
  * Online Payment
* Apply discount coupon.
* Receive confirmation email after placing the order.

### ⚙️ Settings

* Update currency.
* Manage address:

  * Add or edit address using map integration.
  * Includes recipient phone number and location type.
* About Us section.
* Contact Us form.
* Logout functionality.

### 🔐 Authentication

* Sign up / Login with Email & Password.
* Firebase Authentication with email verification.
* Guest Mode with restricted access.

---

## 🛠️ Technologies Used

* **SwiftUI** – UI development
* **MVVM** – App architecture
* **Coordinator Pattern** – Navigation management
* **Manual DI Container** – Dependency injection
* **Firebase Auth** – User authentication
* **Shopify GraphQL API** – Products & orders
* **Connectivity** – Internet connection check
* **MapKit** – Address autocomplete and map integration
* **GraphQL** – Shopify API access

---

## 📧 Email Notifications

* Verification email sent after new user registration.
* Order confirmation email sent after successful checkout.

---

## 📲 Getting Started

1. **Clone the repository**

   ```bash
   git clone https://github.com/nermeen03/MCommerce
   ```

2. **Open the project in Xcode**

   ```bash
   open MCommerce.xcodeproj
   ```

3. **Configure project settings**

   * Add your `GoogleService-Info.plist` (Firebase config).
   * Set up API keys for currency exchange and address autocomplete.

4. **Build & Run the app**
