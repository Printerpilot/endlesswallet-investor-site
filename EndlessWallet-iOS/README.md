# Endless Wallet iOS App

A comprehensive peer-to-peer lending platform for iOS with payment processing, bank connections, and tradeable loan notes.

## Features

- ✅ **Authentication**: Sign up, Sign in with email
- ✅ **Dashboard**: Net worth breakdown with interactive charts
- ✅ **Borrow**: Create detailed loan petitions with flexible terms
- ✅ **Lend**: Browse and fund loan petitions
- ✅ **Marketplace**: Trade loan notes on secondary market
- ✅ **Payment Processing**: Stripe integration for payments
- ✅ **Bank Connections**: Plaid integration for ACH transfers
- ✅ **CORE Score**: Alternative credit scoring beyond FICO
- ✅ **Multi-Currency Support**: USD, EUR, GBP, and cryptocurrencies

## Architecture

```
EndlessWallet-iOS/
├── EndlessWallet/
│   ├── Models/           # Data models
│   │   ├── User.swift
│   │   ├── Petition.swift
│   │   └── TradeableNote.swift
│   ├── Views/            # SwiftUI views
│   │   ├── ContentView.swift
│   │   ├── LandingView.swift
│   │   ├── SignInView.swift
│   │   ├── SignUpView.swift
│   │   ├── OnboardingView.swift
│   │   ├── MainTabView.swift
│   │   ├── DashboardView.swift
│   │   ├── BorrowView.swift
│   │   ├── LendView.swift
│   │   ├── MarketView.swift
│   │   └── SettingsView.swift
│   ├── ViewModels/       # View models
│   ├── Services/         # Business logic & API
│   │   ├── APIService.swift
│   │   ├── StripePaymentService.swift
│   │   └── PlaidService.swift
│   ├── Resources/        # Assets, colors, fonts
│   └── EndlessWalletApp.swift
└── Package.swift         # Swift Package dependencies
```

## Prerequisites

1. **Xcode 15.0+** with iOS 17.0+ SDK
2. **Apple Developer Account** ($99/year for TestFlight distribution)
3. **Stripe Account** for payment processing
4. **Plaid Account** for bank connections
5. **Backend API** (see Backend Setup section)

## Setup Instructions

### 1. Open Project in Xcode

```bash
cd EndlessWallet-iOS
open -a Xcode .
```

### 2. Create Xcode Project

Since this is source code only, you need to create the Xcode project:

1. Open Xcode
2. File → New → Project
3. Select **iOS** → **App**
4. Product Name: `EndlessWallet`
5. Interface: **SwiftUI**
6. Language: **Swift**
7. Save to the `EndlessWallet-iOS` directory

### 3. Add Swift Files

Drag all the Swift files from the folder structure into your Xcode project:
- All files in `Models/`
- All files in `Views/`
- All files in `Services/`
- `EndlessWalletApp.swift`

### 4. Add Dependencies via Swift Package Manager

1. In Xcode: File → Add Package Dependencies
2. Add these packages:

**Stripe iOS SDK:**
```
https://github.com/stripe/stripe-ios
Version: 23.0.0+
```

**Plaid Link iOS:**
```
https://github.com/plaid/plaid-link-ios
Version: 5.0.0+
```

**Alamofire:**
```
https://github.com/Alamofire/Alamofire
Version: 5.8.0+
```

### 5. Configure API Keys

#### Stripe Configuration

In `EndlessWalletApp.swift`, replace the placeholder:

```swift
init() {
    // Replace with your Stripe publishable key
    StripeAPI.defaultPublishableKey = "pk_test_YOUR_STRIPE_KEY_HERE"
}
```

Get your key from: https://dashboard.stripe.com/apikeys

#### Backend URL Configuration

Update the backend URL in these files:
- `Services/APIService.swift` (line 12)
- `Services/StripePaymentService.swift` (line 9)
- `Services/PlaidService.swift` (line 11)

Replace `"https://your-backend.com/api"` with your actual backend URL.

### 6. Configure Info.plist

Add these keys to your `Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>We need camera access for KYC verification</string>

<key>NSPhotoLibraryUsageDescription</key>
<string>We need photo library access for document upload</string>

<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>endlesswallet</string>
        </array>
    </dict>
</array>
```

### 7. Configure App Capabilities

In Xcode Project Settings → Signing & Capabilities:

1. **Sign in with Apple** (if using OAuth)
2. **App Groups** (for data sharing)
3. **Background Modes** (for payment processing)

## Backend Setup

The iOS app requires a backend API. Here's what you need to implement:

### Required Endpoints

#### Authentication
- `POST /api/auth/login`
- `POST /api/auth/register`

#### Petitions
- `GET /api/petitions`
- `POST /api/petitions`
- `POST /api/petitions/fund`

#### Notes Marketplace
- `GET /api/notes/marketplace`
- `POST /api/notes/purchase`
- `POST /api/notes/list`

#### User Profile
- `GET /api/user/profile`
- `PUT /api/user/profile`

#### Payments (Stripe)
- `POST /api/payments/create-intent`
- `POST /api/transfers/create`

#### Bank Connections (Plaid)
- `POST /api/plaid/create-link-token`
- `POST /api/plaid/exchange-token`
- `POST /api/plaid/balance`

### Environment Variables

Your backend needs these environment variables:

```bash
STRIPE_SECRET_KEY=sk_test_...
STRIPE_WEBHOOK_SECRET=whsec_...
PLAID_CLIENT_ID=...
PLAID_SECRET=...
DATABASE_URL=...
JWT_SECRET=...
```

## TestFlight Distribution

See [TESTFLIGHT_GUIDE.md](./TESTFLIGHT_GUIDE.md) for complete TestFlight setup instructions.

### Quick Steps:

1. **Archive the app** in Xcode
2. **Upload to App Store Connect**
3. **Add internal testers**
4. **Submit for Beta Review** (first time only)
5. **Distribute to testers**

## Development

### Running Locally

1. Select a simulator or connected device
2. Press `Cmd + R` to build and run
3. Use mock data for development (already implemented)

### Mock Data

The app includes mock data for development:
- `User.mock` - Sample user with complete profile
- `LoanPetition.mockPetitions` - Sample loan petitions
- `TradeableNote.mockNotes` - Sample tradeable notes

### Testing Payments

Use Stripe test cards:
- Success: `4242 4242 4242 4242`
- Decline: `4000 0000 0000 0002`
- Full list: https://stripe.com/docs/testing

### Testing Bank Connections

Plaid sandbox credentials:
- Username: `user_good`
- Password: `pass_good`
- Full list: https://plaid.com/docs/sandbox/test-credentials/

## Security Considerations

⚠️ **IMPORTANT**: Before production release:

1. ✅ Enable SSL pinning for API calls
2. ✅ Store API keys in iOS Keychain
3. ✅ Implement proper token refresh logic
4. ✅ Add biometric authentication
5. ✅ Implement certificate pinning for Stripe/Plaid
6. ✅ Add jailbreak detection
7. ✅ Obfuscate sensitive strings
8. ✅ Implement proper error logging (without exposing sensitive data)

## Compliance

This app handles financial data. Ensure compliance with:

- **PCI DSS** - Payment card security
- **SOC 2** - Data security controls
- **GDPR** - EU data protection (if applicable)
- **CCPA** - California privacy laws (if applicable)
- **Banking regulations** - Money transmission laws

Consult with legal counsel before launching.

## Support

- Documentation: [docs.endlesswallet.io](https://docs.endlesswallet.io)
- Email: troy.lunn@endlesswallet.io
- Issues: [GitHub Issues](https://github.com/endlesswallet/ios/issues)

## License

Copyright © 2025 Endless Wallet. All rights reserved.
