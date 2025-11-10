# Pre-Archive Checklist

Complete this checklist before archiving to avoid common issues.

## 📋 Before You Archive

### Project Configuration
- [ ] Xcode project created in `EndlessWallet-iOS/` directory
- [ ] All source files added to Xcode (Models, Views, Services)
- [ ] Info.plist replaced with provided version
- [ ] Project builds successfully (`Cmd + B`)

### Dependencies
- [ ] Stripe iOS SDK added (v23.0.0+)
- [ ] Plaid Link iOS added (v5.0.0+)
- [ ] Alamofire added (v5.8.0+)
- [ ] All packages resolved successfully
- [ ] No package dependency errors

### API Configuration
- [ ] Stripe publishable key added to `EndlessWalletApp.swift`
- [ ] Backend URL updated in `APIService.swift` (or placeholder OK for now)
- [ ] Backend URL updated in `StripePaymentService.swift`
- [ ] Backend URL updated in `PlaidService.swift`

### Testing
- [ ] App runs on simulator without crashing
- [ ] Can sign up with test credentials
- [ ] Can navigate through all tabs
- [ ] Dashboard displays correctly
- [ ] Borrow form works
- [ ] Lend view shows petitions
- [ ] Market view displays

### Version & Build
- [ ] Version set to: `1.0.0`
- [ ] Build number set to: `1`
- [ ] Display name: `Endless Wallet`
- [ ] Bundle ID: `com.endlesswallet.ios` (exact match)

### Signing
- [ ] Apple Developer account enrolled ($99/year)
- [ ] Team selected in Signing & Capabilities
- [ ] "Automatically manage signing" enabled
- [ ] No signing errors shown in Xcode
- [ ] Signing certificate shows "Apple Development"

### App Store Connect
- [ ] Logged into https://appstoreconnect.apple.com
- [ ] App created in App Store Connect
- [ ] App name: "Endless Wallet"
- [ ] Bundle ID matches: `com.endlesswallet.ios`
- [ ] SKU entered: `ENDLESS-WALLET-001`
- [ ] Basic app information filled

### Build Configuration
- [ ] Scheme set to "Release" (not Debug)
- [ ] Device selector: "Any iOS Device (arm64)" (not simulator)
- [ ] Clean build folder done (`Cmd + Shift + K`)

### Info.plist Requirements
- [ ] Camera usage description present
- [ ] Photo library usage description present
- [ ] URL schemes configured (`endlesswallet`)
- [ ] Export compliance set
- [ ] Minimum iOS version: 17.0

## 🚀 Ready to Archive?

If all items above are checked, you're ready!

Run verification script:
```bash
cd EndlessWallet-iOS
./verify_setup.sh
```

Then proceed to archive:
1. **Product** → **Archive**
2. Wait for completion
3. Validate archive
4. Upload to App Store Connect

## ⏱️ Time Estimates

| Step | Time |
|------|------|
| Archive creation | 2-5 minutes |
| Validation | 2-5 minutes |
| Upload | 5-20 minutes |
| Apple processing | 10-60 minutes |
| **Total** | **~30-90 minutes** |

## 🆘 If Something Goes Wrong

### Archive Fails
1. Clean build folder: `Cmd + Shift + K`
2. Check for red errors in Issue Navigator
3. Verify signing is configured correctly
4. Try again

### Validation Fails
1. Read the error message carefully
2. Check Bundle ID matches App Store Connect
3. Verify signing certificates are valid
4. Check WALKTHROUGH.md troubleshooting section

### Upload Fails
1. Check internet connection
2. Check Apple System Status: https://developer.apple.com/system-status/
3. Try uploading from Xcode Organizer
4. If persistent, increment build number and re-archive

### Processing Takes Forever
1. Wait at least 1 hour (normal)
2. Check email for notification
3. If stuck >2 hours, upload new build with incremented build number

## 📧 Email Notifications

You'll receive emails from Apple for:
- ✅ Build uploaded successfully
- ✅ Build processing complete
- ✅ Build ready for testing
- ❌ Build processing failed (with error details)

## 🎯 After Successful Upload

When your build finishes processing:

1. You'll receive email from Apple
2. Build appears in App Store Connect → TestFlight → iOS Builds
3. Status changes from "Processing" to ready
4. You're ready for TestFlight configuration (Step 7)

## Next Steps After Upload

Once upload is complete and processing finishes:

```
✅ STEP 1: Create Xcode Project - DONE
✅ STEP 2: Add Source Code - DONE
✅ STEP 3: Configure API Keys - DONE
✅ STEP 4: Test Locally - DONE
✅ STEP 5: Create App in App Store Connect - DONE
✅ STEP 6: Archive and Upload - DONE
⏳ STEP 7: Configure TestFlight - READY TO START
```

You'll need to:
- Add export compliance info
- Create internal testing group
- Add testers
- Enable build for testing
- Distribute to your sandbox group

I'll help you with Step 7 once your build finishes processing!

---

**Last Updated**: Before archiving
**Status**: Ready for archive
**Build Number**: 1
