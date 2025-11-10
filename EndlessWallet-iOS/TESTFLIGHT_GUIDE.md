# TestFlight Distribution Guide

Complete guide to distributing the Endless Wallet iOS app via TestFlight to your sandbox development group.

## Prerequisites

- ✅ Active **Apple Developer Program** membership ($99/year)
- ✅ Xcode 15.0+ installed
- ✅ App fully built and tested locally
- ✅ All API integrations configured (Stripe, Plaid)
- ✅ Backend API deployed and accessible

## Step 1: App Store Connect Setup

### 1.1 Create App ID

1. Go to [Apple Developer Portal](https://developer.apple.com)
2. Navigate to **Certificates, Identifiers & Profiles**
3. Click **Identifiers** → **+** button
4. Select **App IDs** → Continue
5. Fill in:
   - Description: `Endless Wallet`
   - Bundle ID: `com.endlesswallet.ios` (must match Xcode)
   - Capabilities:
     - ✅ App Groups
     - ✅ Sign in with Apple (if using)
     - ✅ Push Notifications
6. Click **Continue** → **Register**

### 1.2 Create App in App Store Connect

1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Click **My Apps** → **+** button → **New App**
3. Fill in:
   - **Platform**: iOS
   - **Name**: Endless Wallet
   - **Primary Language**: English (U.S.)
   - **Bundle ID**: Select `com.endlesswallet.ios`
   - **SKU**: `ENDLESS-WALLET-001` (unique identifier)
   - **User Access**: Full Access
4. Click **Create**

### 1.3 Fill App Information

1. In App Store Connect, select your app
2. Go to **App Information**
3. Fill required fields:
   - **Privacy Policy URL**: Your privacy policy URL
   - **Category**: Finance
   - **Subcategory**: Personal Finance
   - **Age Rating**: 17+ (financial services)

## Step 2: Prepare for Archive

### 2.1 Update Version and Build Number

In Xcode:
1. Select project in Navigator
2. Select **EndlessWallet** target
3. Go to **General** tab
4. Set:
   - **Version**: `1.0.0`
   - **Build**: `1`

### 2.2 Configure Signing

1. In Xcode, select **EndlessWallet** target
2. Go to **Signing & Capabilities**
3. Select your **Team** (your Apple Developer account)
4. Enable **Automatically manage signing**
5. Xcode will create provisioning profiles automatically

### 2.3 Set Build Configuration

1. In Xcode menu: **Product** → **Scheme** → **Edit Scheme**
2. Select **Run** in left sidebar
3. Set **Build Configuration** to **Release**
4. Click **Close**

### 2.4 Update Info.plist

Add export compliance:

```xml
<key>ITSAppUsesNonExemptEncryption</key>
<false/>
```

If you use encryption for payments:
```xml
<key>ITSAppUsesNonExemptEncryption</key>
<true/>
<key>ITSEncryptionExportComplianceCode</key>
<string>YOUR_ERN_NUMBER</string>
```

## Step 3: Archive the App

### 3.1 Select Generic iOS Device

1. In Xcode toolbar (top left), click device selector
2. Select **Any iOS Device (arm64)**

### 3.2 Create Archive

1. In Xcode menu: **Product** → **Archive**
2. Wait for archive to complete (2-10 minutes)
3. Xcode Organizer will open automatically

### 3.3 Validate Archive

1. In Organizer, select your archive
2. Click **Validate App**
3. Follow wizard:
   - Select your distribution certificate
   - Choose automatic signing
   - Click **Validate**
4. Wait for validation (1-5 minutes)
5. Fix any errors/warnings

## Step 4: Upload to App Store Connect

### 4.1 Distribute Archive

1. In Organizer, select your archive
2. Click **Distribute App**
3. Select **App Store Connect** → Next
4. Select **Upload** → Next
5. Keep default options → Next
6. Review and click **Upload**
7. Wait for upload (5-20 minutes depending on connection)

### 4.2 Verify Upload

1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Select your app
3. Go to **TestFlight** tab
4. Wait for processing (10-30 minutes)
5. Build will appear under **iOS Builds** when ready

## Step 5: Configure TestFlight

### 5.1 Complete Missing Compliance

1. In TestFlight, select your build
2. Click **Provide Export Compliance Information**
3. Answer questions:
   - "Is your app designed to use cryptography?" → Yes (for payments)
   - "Does your app use encryption?" → Yes
   - "Does your app qualify for exemption?" → Yes (HTTPS/TLS only)
4. Click **Start Internal Testing**

### 5.2 Add Test Information

1. Go to **Test Information** section
2. Fill in:
   - **Beta App Description**: Brief description for testers
   - **Feedback Email**: Your support email
   - **What to Test**: Testing instructions for your team
3. Click **Save**

## Step 6: Add Internal Testers

### 6.1 Create Internal Testing Group

1. In TestFlight, click **App Store Connect Users** tab
2. Click **+** button → **Add Group**
3. Name: `Sandbox Development Group`
4. Click **Create**

### 6.2 Add Testers to Group

1. Select your new group
2. Click **+** button next to **Testers**
3. Add testers by:
   - **Email**: Enter their Apple ID email
   - Or select from existing App Store Connect users
4. Click **Add**

### 6.3 Enable Build for Testing

1. Go back to **iOS Builds** tab
2. Select your build
3. Toggle on your testing group
4. Testers will receive email invitation immediately

## Step 7: Testers Install App

### 7.1 Tester Setup

Testers must:
1. Install **TestFlight** app from App Store
2. Open invitation email
3. Click **View in TestFlight** link
4. Accept invitation in TestFlight app
5. Install Endless Wallet build

### 7.2 Tester Instructions

Share these instructions with testers:

```
Welcome to Endless Wallet Beta Testing!

1. Install TestFlight from the App Store
2. Check your email for the invitation
3. Tap "View in TestFlight" in the email
4. Accept the invitation and install the app
5. Open Endless Wallet and create an account

Test Credentials (Sandbox):
- Stripe Test Card: 4242 4242 4242 4242
- Plaid Username: user_good
- Plaid Password: pass_good

Please report any bugs or issues to: troy.lunn@endlesswallet.io
```

## Step 8: External Testing (Optional)

For wider beta testing beyond your team:

### 8.1 Submit for Beta App Review

1. Go to **External Testing** tab
2. Create new group: `Beta Testers`
3. Add build to group
4. Fill **Test Information**:
   - App Description
   - Feedback Email
   - Marketing URL (optional)
   - Privacy Policy URL
5. Click **Submit for Review**

### 8.2 Beta App Review

- ⏱️ Review time: 24-48 hours
- Apple reviews your app for basic functionality
- Less strict than App Store review
- You'll receive email when approved

### 8.3 Add External Testers

After approval:
1. Add testers by email (up to 10,000)
2. Testers receive invitation
3. Can install via TestFlight

## Troubleshooting

### Common Issues

#### ❌ Archive Failed
- **Solution**: Check code signing in Build Settings
- Verify all targets have valid signing certificates

#### ❌ Validation Failed - Missing Compliance
- **Solution**: Add export compliance info in Info.plist
- See Step 2.4 above

#### ❌ Upload Failed - Invalid Binary
- **Solution**: Check minimum iOS version is 17.0+
- Verify all frameworks are embedded correctly

#### ❌ Processing Stuck
- **Solution**: Wait up to 1 hour
- If still stuck, upload a new build with incremented build number

#### ❌ Testers Can't Install
- **Solution**: Verify tester's Apple ID email is correct
- Ask tester to check spam folder for invitation
- Ensure tester has iOS 17.0+ device

### Build Processing Takes Too Long

If your build is stuck processing:
1. Wait 1 hour first (this is normal)
2. Check [Apple System Status](https://developer.apple.com/system-status/)
3. If issue persists >2 hours, upload new build

## Updating the Build

### To release a new test build:

1. **Increment Build Number** in Xcode:
   - Version stays `1.0.0`
   - Build: `2`, `3`, `4`, etc.

2. **Archive and Upload** (repeat Steps 3-4)

3. **Existing testers are notified automatically**
   - They see "Update" button in TestFlight
   - No need to re-invite

## Monitoring TestFlight

### Analytics Available:

- **Install metrics**: How many testers installed
- **Session metrics**: How long testers use the app
- **Crash reports**: Automatic crash reporting
- **Feedback**: Testers can send screenshots & comments

Access in: **App Store Connect → TestFlight → Your App**

## Production Release Preparation

Once testing is complete:

1. Fix all critical bugs reported
2. Increment version to `1.0.1` or `2.0.0`
3. Create new archive
4. Submit for **App Store Review** (not just TestFlight)
5. App Store review takes 1-3 days
6. Upon approval, release to App Store

## Best Practices

✅ **Test before uploading**: Always test thoroughly on real devices

✅ **Increment builds properly**: Never reuse build numbers

✅ **Keep testers informed**: Send release notes with each build

✅ **Monitor crash reports**: Check daily for critical issues

✅ **Limit tester count**: Start with 5-10 internal testers

✅ **Update regularly**: Release new builds every 1-2 weeks during beta

## Support Resources

- **Apple Developer Documentation**: https://developer.apple.com/testflight/
- **App Store Connect Help**: https://developer.apple.com/help/app-store-connect/
- **TestFlight FAQ**: https://testflight.apple.com/
- **Contact Apple Support**: https://developer.apple.com/contact/

## Next Steps

After successful TestFlight distribution:

1. ✅ Gather feedback from testers
2. ✅ Fix bugs and iterate
3. ✅ Test payment flows end-to-end
4. ✅ Verify Plaid bank connections
5. ✅ Test all user flows
6. ✅ Prepare App Store metadata
7. ✅ Submit for App Store Review
8. ✅ Launch to production!

---

Questions? Contact: troy.lunn@endlesswallet.io
