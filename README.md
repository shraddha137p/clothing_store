# Clothing Store

A Flutter clothing catalogue with a local product catalogue, shared watchlist and cart, and simulated checkout.

## Setup

Requires Flutter with Dart 3.11 or later.

```sh
flutter pub get
flutter run
```

Demo login: `admin@gmail.com` / `Admin@123`.

## Architecture

Presentation BLoCs dispatch explicit events and expose states. BLoCs call use cases, which depend on domain repository interfaces. Repository implementations use local data sources: products load from `assets/products.json`, while watchlist and cart data are held in memory. The product, watchlist, cart, and payment BLoCs are provided above the router so their state is shared across screens.

Product events: `LoadProducts`. Watchlist events: `LoadWatchlist`, `AddToWatchlist`, `RemoveFromWatchlist`. Cart events: `LoadCart`, `AddToCart`, `RemoveFromCart`, `IncreaseQuantity`, `DecreaseQuantity`, `ClearCart`. Payment event: `InitiatePayment`.

Use cases cover product loading, watchlist reads and mutations, cart reads and mutations, cart clearing, and dummy payment processing. Payment creates an order receipt and clears the cart only after success.

## Tests

```sh
flutter test
```

Business logic tests cover cart totals and quantity handling, plus watchlist add/remove. A widget smoke test verifies the app opens on the login screen.
