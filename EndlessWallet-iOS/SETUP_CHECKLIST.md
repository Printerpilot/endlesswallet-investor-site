# Endless Wallet iOS - Complete Setup Checklist

Use this checklist to ensure all steps are completed before TestFlight distribution.

## ☐ Phase 1: Project Setup

### Xcode Project Creation
- [ ] Install Xcode 15.0 or later
- [ ] Create new iOS App project in Xcode
- [ ] Name: "EndlessWallet"
- [ ] Bundle ID: `com.endlesswallet.ios`
- [ ] Interface: SwiftUI
- [ ] Language: Swift
- [ ] Save to `EndlessWallet-iOS` directory

### Add Source Files
- [ ] Add all files from `Models/` folder
- [ ] Add all files from `Views/` folder
- [ ] Add all files from `Services/` folder
- [ ] Add `EndlessWalletApp.swift`
- [ ] Add `Info.plist` with all required keys
- [ ] Verify all files compile without errors

### Swift Package Dependencies
- [ ] Add Stripe iOS SDK (v23.0.0+)
- [ ] Add Plaid Link iOS (v5.0.0+)
- [ ] Add Alamofire (v5.8.0+)
- [ ] Resolve package dependencies
- [ ] Verify all imports work

## ☐ Phase 2: API Configuration

### Stripe Setup
- [ ] Create Stripe account at https://stripe.com
- [ ] Get publishable key from dashboard
- [ ] Add key to `EndlessWalletApp.swift`
- [ ] Enable payment methods: Cards, ACH
- [ ] Configure webhook endpoints
- [ ] Test with test card: 4242 4242 4242 4242

### Plaid Setup
- [ ] Create Plaid account at https://plaid.com
- [ ] Get Client ID and Secret
- [ ] Configure in backend (not iOS app)
- [ ] Enable required products: Auth, Transactions
- [ ] Test with sandbox credentials

### Backend API
- [ ] Deploy backend API server
- [ ] Configure environment variables
- [ ] Update API URL in `APIService.swift`
- [ ] Update API URL in `StripePaymentService.swift`
- [ ] Update API URL in `PlaidService.swift`
- [ ] Test all API endpoints
- [ ] Enable HTTPS/SSL
- [ ] Configure CORS for iOS app

## ☐ Phase 3: Apple Developer Setup

### Apple Developer Account
- [ ] Enroll in Apple Developer Program ($99/year)
- [ ] Wait for enrollment approval (1-2 days)
- [ ] Accept agreements in developer portal
- [ ] Add payment method for App Store Connect

### App ID Creation
- [ ] Go to Certificates, Identifiers & Profiles
- [ ] Create new App ID
- [ ] Bundle ID: `com.endlesswallet.ios`
- [ ] Enable capabilities:
  - [ ] App Groups
  - [ ] Sign in with Apple (optional)
  - [ ] Push Notifications
- [ ] Register App ID

### App Store Connect
- [ ] Create new app in App Store Connect
- [ ] Fill app information
- [ ] Set privacy policy URL
- [ ] Set category: Finance
- [ ] Set age rating: 17+
- [ ] Save app information

## ☐ Phase 4: Code Signing

### Certificates
- [ ] Xcode → Preferences → Accounts → Add Apple ID
- [ ] Select your team
- [ ] Download certificates automatically
- [ ] Or manually create in developer portal

### Provisioning Profiles
- [ ] Enable "Automatically manage signing" in Xcode
- [ ] Or manually create profiles in developer portal
- [ ] Verify signing works: Product → Archive

### Capabilities Configuration
- [ ] Go to Signing & Capabilities in Xcode
- [ ] Verify team is selected
- [ ] Add required capabilities if needed
- [ ] No errors in signing section

## ☐ Phase 5: Testing

### Local Testing
- [ ] Build app: Cmd + B
- [ ] Run on simulator: Cmd + R
- [ ] Test authentication flow
- [ ] Test dashboard displays
- [ ] Test borrow flow
- [ ] Test lend flow
- [ ] Test market view
- [ ] Test settings
- [ ] Fix any crashes or bugs

### Device Testing
- [ ] Connect physical iPhone (iOS 17+)
- [ ] Select device in Xcode
- [ ] Build and run on device
- [ ] Test all features on real hardware
- [ ] Test Stripe payment flow (test mode)
- [ ] Test Plaid bank connection (sandbox)
- [ ] Verify notifications work
- [ ] Test biometrics if implemented

### Payment Testing
- [ ] Use Stripe test card: 4242 4242 4242 4242
- [ ] Test successful payment
- [ ] Test declined payment: 4000 0000 0000 0002
- [ ] Test 3D Secure: 4000 0027 6000 3184
- [ ] Verify payment appears in Stripe dashboard

### Banking Testing
- [ ] Use Plaid sandbox credentials
- [ ] Username: `user_good`
- [ ] Password: `pass_good`
- [ ] Test bank account linking
- [ ] Test balance retrieval
- [ ] Test ACH transfer (sandbox)

## ☐ Phase 6: Pre-Archive Checklist

### Version Numbers
- [ ] Set Version: `1.0.0`
- [ ] Set Build: `1`
- [ ] Increment build for each upload

### Build Configuration
- [ ] Set scheme to Release
- [ ] Disable debug logs
- [ ] Remove test/demo code
- [ ] Verify no hardcoded test data in production

### Info.plist Check
- [ ] All usage descriptions present
- [ ] URL schemes configured
- [ ] Export compliance set
- [ ] Minimum iOS version: 17.0
- [ ] Bundle ID matches: `com.endlesswallet.ios`

### Assets and Resources
- [ ] Add app icon (all sizes)
- [ ] Add launch screen
- [ ] Add any required images
- [ ] Optimize image sizes
- [ ] Remove unused assets

## ☐ Phase 7: Archive and Upload

### Create Archive
- [ ] Select "Any iOS Device (arm64)"
- [ ] Product → Archive
- [ ] Wait for archive to complete
- [ ] Organizer opens automatically

### Validate Archive
- [ ] Select archive in Organizer
- [ ] Click "Validate App"
- [ ] Choose automatic signing
- [ ] Wait for validation
- [ ] Fix any errors/warnings

### Upload to App Store Connect
- [ ] Click "Distribute App"
- [ ] Select "App Store Connect"
- [ ] Choose "Upload"
- [ ] Review and upload
- [ ] Wait for upload (5-20 min)
- [ ] Verify in App Store Connect

### Build Processing
- [ ] Go to App Store Connect
- [ ] Navigate to TestFlight
- [ ] Wait for processing (10-60 min)
- [ ] Build appears under "iOS Builds"

## ☐ Phase 8: TestFlight Configuration

### Export Compliance
- [ ] Select build in TestFlight
- [ ] Provide export compliance info
- [ ] Answer encryption questions
- [ ] Save compliance info

### Test Information
- [ ] Write beta app description
- [ ] Add feedback email
- [ ] Write "What to Test" instructions
- [ ] Save test information

### Internal Testing Group
- [ ] Create group: "Sandbox Development Group"
- [ ] Add team members by email
- [ ] Enable build for this group
- [ ] Verify invitations sent

## ☐ Phase 9: Tester Setup

### Tester Instructions Sent
- [ ] Email installation instructions to testers
- [ ] Include TestFlight download link
- [ ] Provide test credentials
- [ ] Explain how to report bugs
- [ ] Share testing checklist

### Tester Verification
- [ ] Confirm testers received invitation
- [ ] Verify testers installed TestFlight
- [ ] Confirm testers installed app
- [ ] Check testers can sign in
- [ ] Confirm testers can navigate app

## ☐ Phase 10: Monitoring

### Daily Checks
- [ ] Check crash reports in App Store Connect
- [ ] Review tester feedback
- [ ] Monitor Stripe dashboard for test payments
- [ ] Check Plaid dashboard for connections
- [ ] Review backend logs for errors

### Issue Tracking
- [ ] Set up bug tracking system
- [ ] Document all reported issues
- [ ] Prioritize critical bugs
- [ ] Fix and prepare new builds
- [ ] Increment build number for each upload

## ☐ Phase 11: Production Preparation

### Before App Store Submission
- [ ] Complete all beta testing
- [ ] Fix all critical bugs
- [ ] Verify all features work
- [ ] Test on multiple devices
- [ ] Verify payment processing works
- [ ] Test with real Stripe/Plaid accounts
- [ ] Update version to 1.0.0
- [ ] Create App Store screenshots
- [ ] Write App Store description
- [ ] Submit for App Store Review

## Notes Section

Use this space for notes, API keys, or reminders:

```
Stripe Publishable Key (Test): pk_test_...
Stripe Publishable Key (Live): pk_live_...

Backend API URL (Staging): https://staging.api.endlesswallet.io
Backend API URL (Production): https://api.endlesswallet.io

Plaid Client ID: ...
Plaid Environment: sandbox | development | production

TestFlight Group Link: https://testflight.apple.com/join/...

Important Dates:
- TestFlight Start: ___________
- Planned App Store Submission: ___________
- Target Launch Date: ___________
```

## Troubleshooting Reference

Common issues and solutions:

**Archive Failed**
→ Check code signing settings
→ Verify all dependencies resolved
→ Clean build folder (Cmd + Shift + K)

**Upload Failed**
→ Check internet connection
→ Verify Apple ID credentials
→ Try uploading from Xcode Organizer

**Processing Stuck**
→ Wait 1 hour (normal)
→ Check Apple System Status
→ Upload new build if stuck >2 hours

**Testers Can't Install**
→ Verify email addresses correct
→ Ask to check spam folder
→ Ensure iOS 17+ device
→ Check TestFlight app is installed

---

**Last Updated**: ___________
**Current Status**: ___________
**Next Action**: ___________
