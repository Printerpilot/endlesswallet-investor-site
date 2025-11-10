# Step-by-Step Walkthrough: Getting to TestFlight Upload

Follow these exact steps to reach Step 6 (Archive and Upload).

---

## ✅ STEP 1: Create Xcode Project (10 minutes)

### 1.1 Open Xcode

```bash
# Open Xcode from terminal
open -a Xcode
```

Or: Click Xcode in your Applications folder

### 1.2 Create New Project

1. **File** → **New** → **Project** (or press `Cmd + Shift + N`)

2. Choose template:
   - Select **iOS** at the top
   - Select **App**
   - Click **Next**

3. Configure your project:
   ```
   Product Name: EndlessWallet
   Team: [Select your Apple Developer team]
   Organization Identifier: com.endlesswallet
   Bundle Identifier: com.endlesswallet.ios  ← MUST MATCH THIS EXACTLY
   Interface: SwiftUI  ← Important!
   Language: Swift  ← Important!
   ☐ Use Core Data (unchecked)
   ☐ Include Tests (unchecked for now)
   ```

4. Click **Next**

5. Save location:
   - Navigate to: `endlesswallet-investor-site/EndlessWallet-iOS/`
   - Click **Create**
   - If prompted to create Git repository, click **No** (we already have one)

### 1.3 Verify Project Created

You should now see:
- ✅ Xcode window with your project open
- ✅ `EndlessWallet.xcodeproj` file in the folder
- ✅ Default `EndlessWalletApp.swift` and `ContentView.swift` files

**🎯 Checkpoint**: Xcode project is open and ready

---

## ✅ STEP 2: Add Source Code (10 minutes)

### 2.1 Delete Default Files

In Xcode's Project Navigator (left sidebar):

1. Right-click on `ContentView.swift` → **Delete** → **Move to Trash**
2. Right-click on `EndlessWalletApp.swift` → **Delete** → **Move to Trash**

### 2.2 Add Our Source Files

**Method 1: Drag and Drop (Easiest)**

1. Open Finder
2. Navigate to: `endlesswallet-investor-site/EndlessWallet-iOS/EndlessWallet/`
3. Drag these folders into Xcode's Project Navigator onto "EndlessWallet" group:
   - `Models/` folder
   - `Views/` folder
   - `Services/` folder
   - `EndlessWalletApp.swift` file

4. When prompted:
   - ✅ Copy items if needed
   - ✅ Create groups (not folder references)
   - ✅ Add to target: EndlessWallet
   - Click **Finish**

**Method 2: Add Files (Alternative)**

1. Right-click on "EndlessWallet" in Project Navigator
2. **Add Files to "EndlessWallet"...**
3. Navigate to `EndlessWallet-iOS/EndlessWallet/`
4. Select all folders (Models, Views, Services) and `EndlessWalletApp.swift`
5. Make sure:
   - ✅ Copy items if needed
   - ✅ Create groups
   - ✅ EndlessWallet target is checked
6. Click **Add**

### 2.3 Replace Info.plist

1. In Finder, go to: `EndlessWallet-iOS/Info.plist`
2. Copy this file
3. In your Xcode project folder, replace the default `Info.plist`

Or in Xcode:
1. Select `Info.plist` in Project Navigator
2. Right-click → **Delete** → **Move to Trash**
3. Drag the new `Info.plist` from `EndlessWallet-iOS/` into Xcode

### 2.4 Verify File Structure

Your Xcode Project Navigator should now show:

```
EndlessWallet/
├── Models/
│   ├── User.swift
│   ├── Petition.swift
│   └── TradeableNote.swift
├── Views/
│   ├── ContentView.swift
│   ├── LandingView.swift
│   ├── SignInView.swift
│   ├── SignUpView.swift
│   ├── OnboardingView.swift
│   ├── MainTabView.swift
│   ├── DashboardView.swift
│   ├── BorrowView.swift
│   ├── LendView.swift
│   ├── MarketView.swift
│   └── SettingsView.swift
├── Services/
│   ├── APIService.swift
│   ├── StripePaymentService.swift
│   └── PlaidService.swift
├── EndlessWalletApp.swift
└── Info.plist
```

**🎯 Checkpoint**: All source files are in Xcode

---

## ✅ STEP 3: Add Dependencies (15 minutes)

### 3.1 Add Swift Packages

1. In Xcode: **File** → **Add Package Dependencies...**

### 3.2 Add Stripe iOS SDK

1. In the search box, paste:
   ```
   https://github.com/stripe/stripe-ios
   ```

2. Press **Enter**

3. Wait for package to load (30 seconds)

4. In "Dependency Rule":
   - Select **Up to Next Major Version**
   - Version: `23.0.0`

5. Click **Add Package**

6. Select these products (check the boxes):
   - ✅ `StripePaymentSheet`
   - ✅ `StripePayments`
   - ✅ `StripeCore`

7. Click **Add Package**

### 3.3 Add Plaid Link iOS

1. Again: **File** → **Add Package Dependencies...**

2. Paste:
   ```
   https://github.com/plaid/plaid-link-ios
   ```

3. Press **Enter**, wait for load

4. Dependency Rule:
   - **Up to Next Major Version**
   - Version: `5.0.0`

5. Click **Add Package**

6. Select:
   - ✅ `LinkKit`

7. Click **Add Package**

### 3.4 Add Alamofire

1. Again: **File** → **Add Package Dependencies...**

2. Paste:
   ```
   https://github.com/Alamofire/Alamofire
   ```

3. Press **Enter**, wait for load

4. Dependency Rule:
   - **Up to Next Major Version**
   - Version: `5.8.0`

5. Click **Add Package**

6. Select:
   - ✅ `Alamofire`

7. Click **Add Package**

### 3.5 Verify Dependencies

1. In Project Navigator, you should see a "Package Dependencies" folder with:
   - Stripe
   - LinkKit
   - Alamofire

2. Try building: Press `Cmd + B`
   - You'll see some errors - that's OK! We need to configure API keys next.

**🎯 Checkpoint**: All dependencies are added

---

## ✅ STEP 4: Configure API Keys (10 minutes)

### 4.1 Get Stripe API Key

1. Go to: https://dashboard.stripe.com/test/apikeys
2. Sign in or create account (free)
3. Copy your **Publishable key** (starts with `pk_test_`)
   - Example: `pk_test_51AbCdEfGhIjKlMnOpQrStUvWxYz...`

### 4.2 Add Stripe Key to Code

1. In Xcode, open `EndlessWalletApp.swift`

2. Find line 12 (in the `init()` function):
   ```swift
   // StripeAPI.defaultPublishableKey = "pk_test_YOUR_KEY_HERE"
   ```

3. Uncomment and replace with your key:
   ```swift
   StripeAPI.defaultPublishableKey = "pk_test_51AbCdEfGhIjKlMnOpQrStUvWxYz..."
   ```

4. Save file: `Cmd + S`

### 4.3 Configure Backend URLs

For now, we'll use placeholder URLs (you can update these later).

**Option A: Use Placeholder (Recommended for now)**

The code already has placeholders. You can update later when your backend is ready.

**Option B: Use Your Backend URL**

If you have a backend ready:

1. Open `Services/APIService.swift`
   - Line 12: Change `baseURL` to your backend
   ```swift
   private let baseURL = "https://your-backend.com/api"
   ```

2. Open `Services/StripePaymentService.swift`
   - Line 9: Change `backendURL`
   ```swift
   private let backendURL = "https://your-backend.com/api"
   ```

3. Open `Services/PlaidService.swift`
   - Line 11: Change `backendURL`
   ```swift
   private let backendURL = "https://your-backend.com/api"
   ```

**🎯 Checkpoint**: API keys are configured

---

## ✅ STEP 5: Test Locally (15 minutes)

### 5.1 Build the Project

1. Press `Cmd + B` to build
2. Wait for build to complete (30-60 seconds)
3. Fix any errors if they appear (there shouldn't be any now)

### 5.2 Select Simulator

1. In Xcode toolbar (top), click device selector (currently shows "iPhone")
2. Choose: **iPhone 15 Pro** (or any iPhone simulator)

### 5.3 Run the App

1. Press `Cmd + R` (or click Play button)
2. Wait for simulator to launch (30-60 seconds first time)
3. App should open automatically

### 5.4 Test Core Features

Test these flows:

**Authentication:**
- [ ] Click "Get Started"
- [ ] Enter any name, email, password
- [ ] Click "Create Account"
- [ ] Should see onboarding screens

**Onboarding:**
- [ ] Click through all 4 onboarding steps
- [ ] Should reach dashboard

**Dashboard:**
- [ ] See net worth breakdown
- [ ] See asset allocation
- [ ] See CORE score badge

**Navigation:**
- [ ] Tap each tab at bottom:
  - Dashboard ✓
  - Borrow ✓
  - Lend ✓
  - Market ✓
  - Settings ✓

**Borrow Flow:**
- [ ] Enter loan amount
- [ ] Change currency
- [ ] See monthly payment calculation

**Lend Flow:**
- [ ] See loan petitions
- [ ] Try search
- [ ] Try filters (All, Verified, High CORE, Low Rate)

If everything works, you're ready for production!

### 5.5 Stop Simulator

Press `Cmd + .` to stop the app

**🎯 Checkpoint**: App runs successfully on simulator

---

## ✅ STEP 6: Archive and Upload (20 minutes)

### 6.1 Create App Store Connect Account

1. Go to: https://appstoreconnect.apple.com
2. Sign in with your Apple Developer account
3. Accept any agreements

### 6.2 Create App in App Store Connect

1. Click **My Apps**
2. Click **+** button (top left)
3. Select **New App**

4. Fill in the form:
   ```
   Platform: iOS ✓
   Name: Endless Wallet
   Primary Language: English (U.S.)
   Bundle ID: Create new...
   ```

5. Click **Create new Bundle ID**:
   ```
   Bundle ID: com.endlesswallet.ios
   Description: Endless Wallet iOS App
   ```
   Click **Continue**

6. Back in New App form:
   ```
   Bundle ID: com.endlesswallet.ios (select it)
   SKU: ENDLESS-WALLET-001
   User Access: Full Access
   ```

7. Click **Create**

### 6.3 Fill Basic App Information

1. In your new app, go to **App Information**

2. Fill required fields:
   ```
   Category: Finance
   Subcategory: Personal Finance
   ```

3. Privacy Policy URL:
   - If you have one: Enter URL
   - If not: Use `https://endlesswallet.io/privacy` (placeholder)

4. Click **Save** (top right)

### 6.4 Prepare for Archive

**In Xcode:**

1. Select your project (top of Project Navigator)
2. Select **EndlessWallet** target (not the project)
3. Go to **General** tab

4. Verify these settings:
   ```
   Display Name: Endless Wallet
   Bundle Identifier: com.endlesswallet.ios
   Version: 1.0.0
   Build: 1
   ```

5. Go to **Signing & Capabilities** tab

6. Set up signing:
   - ✅ Automatically manage signing
   - Team: [Select your Apple Developer team]
   - You should see: ✅ "Signing Certificate: Apple Development"

### 6.5 Set Build Configuration to Release

1. In Xcode menu: **Product** → **Scheme** → **Edit Scheme...**
2. Click **Run** in left sidebar
3. Change **Build Configuration** to: **Release**
4. Click **Close**

### 6.6 Select Generic iOS Device

1. In Xcode toolbar, click device selector
2. Select: **Any iOS Device (arm64)**
3. DO NOT select a simulator - must be "Any iOS Device"

### 6.7 Archive the App

1. Clean build folder: **Product** → **Clean Build Folder** (`Cmd + Shift + K`)

2. Create archive: **Product** → **Archive**

3. Wait for archiving to complete (2-5 minutes)
   - You'll see progress in the status bar
   - Xcode Organizer will open automatically when done

### 6.8 Validate the Archive

**In Xcode Organizer:**

1. Your archive appears in the list
2. Select your archive
3. Click **Validate App** button (right side)

4. Follow wizard:
   - **Distribution:** App Store Connect
   - Click **Next**

   - **App Store Connect Distribution Options:**
   - Keep defaults checked
   - Click **Next**

   - **Signing:**
   - ✅ Automatically manage signing
   - Click **Next**

   - **Review:**
   - Review information
   - Click **Validate**

5. Wait for validation (2-5 minutes)

6. If successful: ✅ "Validation Successful"
   - Click **Done**

7. If errors appear:
   - Read the error messages
   - Common fixes in troubleshooting section below
   - Fix and re-archive

### 6.9 Upload to App Store Connect

**After successful validation:**

1. Click **Distribute App** button

2. Follow wizard:
   - **Method:** App Store Connect
   - Click **Next**

   - **Destination:** Upload
   - Click **Next**

   - **App Store Connect Distribution Options:**
   - Keep defaults
   - Click **Next**

   - **Signing:**
   - ✅ Automatically manage signing
   - Click **Next**

   - **Review:**
   - Review information
   - Click **Upload**

3. Wait for upload (5-20 minutes)
   - Progress bar shows upload status
   - Don't close Xcode during upload

4. When complete: "Upload Successful"
   - Click **Done**

### 6.10 Verify Upload in App Store Connect

1. Go to: https://appstoreconnect.apple.com
2. Select your app: **Endless Wallet**
3. Click **TestFlight** tab
4. You'll see: "Processing" status (this is normal)

**Wait for Processing (10-60 minutes):**
- Apple processes your build
- You'll receive email when ready
- Build appears under "iOS Builds" when ready
- Status changes from "Processing" to ready

**🎉 SUCCESS! You've reached Step 6 - Ready for TestFlight!**

---

## 🚨 Troubleshooting

### Archive Failed

**Error: "No accounts with App Store Connect access"**
- Solution: Add your Apple ID in Xcode → Preferences → Accounts

**Error: "Code signing error"**
- Solution: Go to Signing & Capabilities, uncheck and recheck "Automatically manage signing"

**Error: "Build failed"**
- Solution: Product → Clean Build Folder, then try again
- Check for any red errors in Issue Navigator (left sidebar, warning icon)

### Validation Failed

**Error: "Invalid Bundle ID"**
- Solution: Bundle ID in Xcode must match App Store Connect exactly
- Check: Project Settings → General → Bundle Identifier

**Error: "Missing Compliance"**
- Solution: This is handled during TestFlight configuration, not now

**Error: "Invalid Provisioning Profile"**
- Solution: Go to developer.apple.com → Certificates, delete old profiles, re-archive

### Upload Stuck

**Upload taking longer than 30 minutes:**
- Check your internet connection
- Check Apple System Status: https://developer.apple.com/system-status/
- Cancel and try again
- Try uploading from Xcode → Organizer → Archives instead

### Processing Stuck (After Upload)

**Build stuck "Processing" for more than 2 hours:**
1. Wait 24 hours (Apple's servers can be slow)
2. If still stuck, upload a new build with incremented build number:
   - In Xcode: General → Build: Change `1` to `2`
   - Archive and upload again

---

## ✅ What's Next?

After your build finishes processing (you'll get an email):

**You're ready for Step 7: Configure TestFlight!**

At that point, come back and I'll help you with:
- Adding export compliance info
- Creating your testing group
- Adding testers
- Distributing to your sandbox development group

---

## 📞 Need Help?

If you get stuck at any step:
1. Copy the exact error message
2. Take a screenshot if possible
3. Let me know which step you're on
4. I'll help you troubleshoot!

**Estimated Total Time: 1-2 hours**
(including Apple's processing time)
