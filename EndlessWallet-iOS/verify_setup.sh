#!/bin/bash

# Endless Wallet iOS - Quick Setup Verification Script
# Run this to verify your setup is complete before archiving

echo "🔍 Endless Wallet iOS - Setup Verification"
echo "=========================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check counters
checks_passed=0
checks_failed=0

# Function to check and report
check_item() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✅ $2${NC}"
        ((checks_passed++))
    else
        echo -e "${RED}❌ $2${NC}"
        ((checks_failed++))
    fi
}

# 1. Check if Xcode is installed
echo "Checking Xcode installation..."
if command -v xcodebuild &> /dev/null; then
    xcode_version=$(xcodebuild -version | head -n 1)
    check_item 0 "Xcode installed: $xcode_version"
else
    check_item 1 "Xcode is not installed"
fi
echo ""

# 2. Check if we're in the right directory
echo "Checking directory structure..."
if [ -d "EndlessWallet" ]; then
    check_item 0 "EndlessWallet directory exists"
else
    check_item 1 "EndlessWallet directory not found"
    echo -e "${YELLOW}   ⚠️  Run this script from EndlessWallet-iOS directory${NC}"
fi
echo ""

# 3. Check for required source files
echo "Checking source files..."

required_files=(
    "EndlessWallet/EndlessWalletApp.swift"
    "EndlessWallet/Models/User.swift"
    "EndlessWallet/Models/Petition.swift"
    "EndlessWallet/Models/TradeableNote.swift"
    "EndlessWallet/Views/ContentView.swift"
    "EndlessWallet/Views/LandingView.swift"
    "EndlessWallet/Views/DashboardView.swift"
    "EndlessWallet/Views/BorrowView.swift"
    "EndlessWallet/Services/APIService.swift"
    "EndlessWallet/Services/StripePaymentService.swift"
    "EndlessWallet/Services/PlaidService.swift"
    "Info.plist"
)

files_found=0
files_missing=0

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        ((files_found++))
    else
        ((files_missing++))
        echo -e "${RED}   ❌ Missing: $file${NC}"
    fi
done

if [ $files_missing -eq 0 ]; then
    check_item 0 "All $files_found source files present"
else
    check_item 1 "$files_missing source files missing"
fi
echo ""

# 4. Check for Xcode project
echo "Checking Xcode project..."
if [ -f "EndlessWallet.xcodeproj/project.pbxproj" ]; then
    check_item 0 "Xcode project file exists"
else
    check_item 1 "Xcode project not found"
    echo -e "${YELLOW}   ⚠️  You need to create the Xcode project first${NC}"
fi
echo ""

# 5. Check for Package.swift (SPM dependencies)
echo "Checking package dependencies..."
if [ -f "Package.swift" ]; then
    check_item 0 "Package.swift exists"
else
    check_item 1 "Package.swift not found"
fi
echo ""

# 6. Check Info.plist for required keys
echo "Checking Info.plist configuration..."
if [ -f "Info.plist" ]; then
    if grep -q "NSCameraUsageDescription" Info.plist; then
        check_item 0 "Camera permission configured"
    else
        check_item 1 "Camera permission missing"
    fi

    if grep -q "NSPhotoLibraryUsageDescription" Info.plist; then
        check_item 0 "Photo library permission configured"
    else
        check_item 1 "Photo library permission missing"
    fi

    if grep -q "CFBundleURLSchemes" Info.plist; then
        check_item 0 "URL schemes configured"
    else
        check_item 1 "URL schemes missing"
    fi
else
    check_item 1 "Info.plist not found"
fi
echo ""

# 7. Check Stripe key configuration
echo "Checking API configuration..."
if [ -f "EndlessWallet/EndlessWalletApp.swift" ]; then
    if grep -q "pk_test_" EndlessWallet/EndlessWalletApp.swift || grep -q "pk_live_" EndlessWallet/EndlessWalletApp.swift; then
        check_item 0 "Stripe API key configured"
    else
        if grep -q "YOUR_KEY_HERE" EndlessWallet/EndlessWalletApp.swift; then
            check_item 1 "Stripe API key not configured"
            echo -e "${YELLOW}   ⚠️  Replace YOUR_KEY_HERE with actual Stripe key${NC}"
        else
            check_item 1 "Stripe API key configuration unclear"
        fi
    fi
else
    check_item 1 "Cannot verify Stripe API key"
fi
echo ""

# Summary
echo "=========================================="
echo "📊 Verification Summary"
echo "=========================================="
echo -e "${GREEN}✅ Checks passed: $checks_passed${NC}"
if [ $checks_failed -gt 0 ]; then
    echo -e "${RED}❌ Checks failed: $checks_failed${NC}"
else
    echo -e "${GREEN}❌ Checks failed: $checks_failed${NC}"
fi
echo ""

if [ $checks_failed -eq 0 ]; then
    echo -e "${GREEN}🎉 Your setup looks good!${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Open the project in Xcode"
    echo "2. Select 'Any iOS Device (arm64)'"
    echo "3. Product → Archive"
    echo "4. Follow the upload instructions"
else
    echo -e "${YELLOW}⚠️  Please fix the issues above before archiving${NC}"
    echo ""
    echo "Need help? Check:"
    echo "- WALKTHROUGH.md for detailed instructions"
    echo "- README.md for troubleshooting"
fi
echo ""
