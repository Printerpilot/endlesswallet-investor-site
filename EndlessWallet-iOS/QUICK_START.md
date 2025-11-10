# Endless Wallet iOS - Quick Start Guide

Get your iOS app running in TestFlight in under 2 hours.

## Prerequisites (5 minutes)

✅ Mac with Xcode 15.0+ installed
✅ Apple Developer Account ($99/year)
✅ Stripe account (free)
✅ Plaid account (free for sandbox)

## Step 1: Create Xcode Project (10 minutes)

1. Open Xcode
2. File → New → Project → iOS App
3. Settings:
   - Name: `EndlessWallet`
   - Bundle ID: `com.endlesswallet.ios`
   - Interface: SwiftUI
   - Language: Swift
4. Save in the `EndlessWallet-iOS` directory

## Step 2: Add Source Code (10 minutes)

1. Drag all Swift files into Xcode project:
   - All files from `Models/` folder
   - All files from `Views/` folder
   - All files from `Services/` folder
   - `EndlessWalletApp.swift`

2. Replace `Info.plist` with the provided one

3. Add dependencies via Swift Package Manager:
   - File → Add Package Dependencies
   - Add: `https://github.com/stripe/stripe-ios` (v23.0.0)
   - Add: `https://github.com/plaid/plaid-link-ios` (v5.0.0)
   - Add: `https://github.com/Alamofire/Alamofire` (v5.8.0)

## Step 3: Configure API Keys (10 minutes)

### Stripe

1. Go to https://dashboard.stripe.com/apikeys
2. Copy your **Publishable key** (starts with `pk_test_`)
3. In Xcode, open `EndlessWalletApp.swift`
4. Replace line 12:
```swift
StripeAPI.defaultPublishableKey = "pk_test_YOUR_KEY_HERE"
```

### Backend URLs

Update these files with your backend URL (or use localhost for testing):

**APIService.swift** (line 12):
```swift
private let baseURL = "https://your-backend.com/api"
```

**StripePaymentService.swift** (line 9):
```swift
private let backendURL = "https://your-backend.com/api"
```

**PlaidService.swift** (line 11):
```swift
private let backendURL = "https://your-backend.com/api"
```

> For local testing, use `http://localhost:3000/api`

## Step 4: Test Locally (15 minutes)

1. Select iPhone 15 Pro simulator
2. Press `Cmd + R` to run
3. Test the app:
   - Sign up with any email
   - Navigate through all tabs
   - View dashboard
   - Create a loan petition
   - Browse petitions
   - Check marketplace

## Step 5: Create App in App Store Connect (15 minutes)

1. Go to https://appstoreconnect.apple.com
2. My Apps → + → New App
3. Fill in:
   - Platform: iOS
   - Name: Endless Wallet
   - Language: English
   - Bundle ID: `com.endlesswallet.ios` (create if not exists)
   - SKU: `ENDLESS-WALLET-001`
4. Click Create

## Step 6: Archive and Upload (20 minutes)

1. In Xcode, select device: **Any iOS Device (arm64)**
2. Product → Scheme → Edit Scheme → Run → **Release** configuration
3. Product → Archive
4. Wait for archive (2-5 minutes)
5. In Organizer:
   - Click **Validate App** → Next → Validate
   - Wait for validation (2-5 minutes)
   - Click **Distribute App** → App Store Connect → Upload
   - Wait for upload (5-15 minutes)

## Step 7: Configure TestFlight (15 minutes)

1. Go to https://appstoreconnect.apple.com
2. Select your app → **TestFlight** tab
3. Wait for processing (10-30 minutes) ☕
4. When build appears:
   - Click build
   - Provide Export Compliance info
   - Click "Start Internal Testing"

## Step 8: Add Testers (10 minutes)

1. In TestFlight, click **App Store Connect Users**
2. Click + → Add Group
3. Name: `Sandbox Development Group`
4. Click + next to Testers
5. Add emails of your team members
6. Enable your build for this group
7. Testers receive invitation immediately!

## Step 9: Testers Install (5 minutes per tester)

Send testers these instructions:

```
1. Install TestFlight from App Store
2. Check email for invitation
3. Tap "View in TestFlight"
4. Install Endless Wallet
5. Test the app!

Test Card: 4242 4242 4242 4242 (any CVC, any future date)
```

## Done! 🎉

Your app is now in TestFlight! Testers can install and test immediately.

## Next Steps

- Gather feedback from testers
- Fix bugs and upload new builds (increment build number)
- Test payment flows thoroughly
- When ready, submit for App Store Review

## Troubleshooting

### "Archive Failed"
→ Clean build: `Cmd + Shift + K` then try again

### "Upload Stuck"
→ Wait 1 hour. Apple's servers can be slow.

### "Tester Can't Install"
→ Check their email is correct
→ They need iOS 17+ device
→ Ask them to check spam folder

### "Processing Stuck for Hours"
→ Upload a new build with incremented build number

## Support

- Full documentation: `README.md`
- TestFlight guide: `TESTFLIGHT_GUIDE.md`
- Setup checklist: `SETUP_CHECKLIST.md`
- Email: troy.lunn@endlesswallet.io

---

**Time to TestFlight**: ~2 hours (including Apple's processing time)
