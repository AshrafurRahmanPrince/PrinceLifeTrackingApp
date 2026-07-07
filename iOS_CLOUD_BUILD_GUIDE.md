# iOS Cloud Build & Deployment Guide

Build your Flutter app for iOS using GitHub Actions (free cloud CI/CD) and install it on your iPhone 14 Pro Max!

---

## 🚀 Overview

Since you're on Windows and can't build iOS locally, this guide sets up **free GitHub Actions** to:
- ✅ Build your Flutter app for iOS
- ✅ Export as an IPA file
- ✅ Upload as downloadable artifact
- ✅ Sync to your iPhone using Xcode or TestFlight

---

## 📋 Prerequisites

1. **GitHub Account** (free tier works)
2. **Your Flutter app in a GitHub repository**
3. **iPhone 14 Pro Max** with iOS 15+
4. **Mac (optional, for advanced features)**
5. **Xcode installed on Mac (if syncing locally)**

---

## 🔧 Step 1: Push Your Project to GitHub

### Create a GitHub repository
```bash
cd PrinceLifeTrackiungApp

# Initialize git (if not already done)
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit: Prince's Lifestyle Matrix"

# Add remote (replace with your repo URL)
git remote add origin https://github.com/YOUR_USERNAME/PrinceLifeTrackingApp.git

# Push to GitHub
git branch -M main
git push -u origin main
```

---

## ✅ Step 2: GitHub Actions Workflow Already Included

The workflow file is already created at:
```
.github/workflows/build-ios-ipa.yml
```

**It automatically:**
- Triggers on every push to `main` or `develop` branches
- Builds iOS app on macOS runners
- Exports IPA file
- Uploads as downloadable artifact

---

## 🎯 Step 3: Trigger the Build

### Option A: Automatic (Recommended)
1. Push code to GitHub:
   ```bash
   git push origin main
   ```
2. Go to your repository on GitHub
3. Click **"Actions"** tab
4. See workflow running automatically! ✨

### Option B: Manual Trigger
1. Go to GitHub repository
2. Click **"Actions"** tab
3. Select **"Build iOS IPA"** workflow
4. Click **"Run workflow"** button
5. Choose branch and click **"Run workflow"**

---

## 📥 Step 4: Download the IPA File

### Once build completes (takes ~15-20 minutes):

1. Go to your repository
2. Click **"Actions"** tab
3. Click the completed workflow run
4. Scroll down to **"Artifacts"** section
5. Download **"Prince-Lifestyle-Matrix-iOS"** ZIP file
6. Extract the ZIP to get the `.ipa` file

---

## 📱 Step 5: Install IPA on iPhone

### Option A: Using Xcode (Mac Only)
Requires: Mac with Xcode

```bash
# Connect iPhone via USB
# Open Xcode
# Window → Devices and Simulators
# Select your iPhone
# Drag & drop the .ipa file onto your iPhone
```

### Option B: Using Apple Configurator 2 (Mac Only)
```
1. Download Apple Configurator 2 from App Store
2. Connect iPhone
3. Drag & drop .ipa file
4. Done!
```

### Option C: Using Cydia Impactor (Windows/Mac/Linux)
1. Download [Cydia Impactor](http://www.cydiaimpactor.com/)
2. Connect iPhone via USB
3. Drag .ipa onto Cydia Impactor window
4. Enter Apple ID credentials
5. Wait for installation

### Option D: AltStore (Windows/Mac/Linux) - Easiest!
**Recommended for Windows users!**

1. Download [AltStore](https://altstore.io/)
2. Install AltStore on your computer
3. Connect iPhone via USB
4. Open AltStore
5. Go to **My Apps** section
6. Click **"+"** button and select your .ipa file
7. Sign in with Apple ID
8. App installs on your iPhone! ✨

---

## 🔑 Step 6: Code Signing (Important for Release Builds)

### For Development Builds (current setup)
✅ **No code signing needed!** Workflow uses unsigned builds.

### For Release/TestFlight (Advanced)
To publish to App Store, you need:

1. **Apple Developer Account** ($99/year)
2. **Code Signing Certificate** from Apple
3. **Provisioning Profile**
4. **GitHub Secrets** with signing credentials

See "Advanced Setup" section below.

---

## 🎯 Using the Build Workflow

### Automatic Triggers
The workflow runs automatically when:
- ✅ You push to `main` branch
- ✅ You push to `develop` branch
- ✅ A pull request is created

### Manual Triggers
Anytime via GitHub Actions UI:
1. **Actions** tab → **Build iOS IPA** workflow
2. **Run workflow** button
3. Choose branch
4. **Run workflow**

### Check Build Status
1. Go to **Actions** tab
2. See all workflow runs
3. Click to see logs
4. Download artifact when complete

---

## 📊 Build Workflow Details

### Debug Builds (Automatic on push)
- ✅ Built every push to main/develop
- ✅ Artifacts kept for 7 days
- ✅ Can run manually anytime
- ✅ Perfect for testing

### Release Builds (Tag-triggered)
- ✅ Only runs when you create a Git tag
- ✅ Artifacts kept for 30 days

**To trigger release build:**
```bash
git tag v1.0.0
git push origin v1.0.0
```

---

## 🔄 Customization

### Change Trigger Branches
Edit `.github/workflows/build-ios-ipa.yml`:
```yaml
on:
  push:
    branches:
      - main          # Change this
      - develop       # Or this
```

### Change Build Configuration
```yaml
- name: Build iOS app (Debug)
  run: |
    flutter build ios \
      --no-codesign \
      --debug
```

Options:
- `--debug` - Debug build (current)
- `--release` - Release build (requires signing)
- `--no-codesign` - Skip code signing

---

## 🛠️ Advanced Setup: Code Signing (Optional)

For publishing to App Store, follow these steps:

### 1. Get Signing Credentials
1. Go to [Apple Developer](https://developer.apple.com/)
2. Create signing certificate
3. Create provisioning profile
4. Download .p8 file or certificate

### 2. Store in GitHub Secrets
1. Go to repository **Settings**
2. Click **Secrets and variables** → **Actions**
3. Add secrets:
   - `APPLE_SIGNING_CERT` - Base64 encoded certificate
   - `APPLE_CERT_PASSWORD` - Certificate password
   - `APPLE_TEAM_ID` - Your Apple Team ID

### 3. Update Workflow
Replace `--no-codesign` with your signing credentials in the workflow file.

---

## 📱 Install on iPhone - Methods Comparison

| Method | OS | Difficulty | Cost | Speed |
|--------|----|-----------:|-----:|------:|
| **AltStore** | Win/Mac | Easy | Free | Fast |
| **Xcode** | Mac | Easy | Free | Medium |
| **Cydia Impactor** | All | Medium | Free | Medium |
| **Apple Configurator** | Mac | Easy | Free | Fast |
| **TestFlight** | All | Hard | $99/yr | Slow |

**Recommendation for Windows**: Use **AltStore** ✅

---

## 🐛 Troubleshooting

### Build Failed?
1. Check **Actions** tab → Workflow logs
2. Look for error messages
3. Common issues:
   - Flutter version mismatch
   - Dependency issues
   - Dart SDK problems

**Fix:**
```bash
flutter clean
flutter pub get
git push origin main  # Retrigger build
```

### Can't Download IPA?
1. Check build status (should show ✅)
2. Scroll to "Artifacts" section
3. If missing: Build may have failed
4. Check logs for errors

### IPA Installation Fails?
1. iPhone must have enough storage
2. Check iOS version compatibility
3. Try different installation tool
4. Restart iPhone and try again

### AltStore Not Working?
1. Update AltStore to latest version
2. Restart computer
3. Reconnect iPhone
4. Re-authorize in Apple ID settings

---

## 📊 Build Times

Typical build times on GitHub Actions:
- Setup Flutter: ~3 minutes
- Get dependencies: ~2 minutes
- Build iOS app: ~8 minutes
- Export IPA: ~2 minutes
- **Total**: ~15-20 minutes

You can check progress in **Actions** tab.

---

## 🔐 Security Notes

### Current Setup (Development)
- ✅ No code signing required
- ✅ Safe to use
- ✅ No credentials needed
- ⚠️ App only works for testing

### Production Setup
- ⚠️ Requires Apple Developer Account
- ⚠️ Requires code signing certificates
- ⚠️ Never commit certificates to GitHub
- ✅ Use GitHub Secrets for credentials

---

## 📝 Update Your Profile (Optional)

Before building, customize your app:

**File**: `lib/main.dart`

```dart
class UserConfig {
  static const String fullName = "Ashrafur Rahman Prince";
  static const String nickname = "Prince";
  static const String profileImagePath = 'assets/prince_profile.png';
  static const String workspaceTitle = "Lifestyle Matrix";
}
```

Commit and push:
```bash
git add .
git commit -m "Customize app profile"
git push origin main
```

This triggers a new build automatically! ✨

---

## 🎯 Next Steps

1. **Push to GitHub** if not already done
2. **Check Actions** tab to see build start
3. **Wait 15-20 minutes** for build to complete
4. **Download IPA** from artifacts
5. **Install on iPhone** using AltStore (recommended for Windows)
6. **Enjoy your app** on your iPhone 14 Pro Max!

---

## 📞 Need Help?

### Build Fails?
1. Check workflow logs in **Actions** tab
2. Look for specific error message
3. Try `flutter clean && flutter pub get`
4. Push again to retrigger

### Installation Issues?
1. Try different installation tool
2. Check iPhone storage
3. Verify iOS version
4. Restart iPhone

### Want to Modify Build?
Edit `.github/workflows/build-ios-ipa.yml` with:
- Different build configuration
- Additional build steps
- Custom notifications

---

## 🚀 Manual Build (If Needed)

If you get access to a Mac, build locally:

```bash
flutter clean
flutter pub get
flutter build ios --release

# Export IPA
cd build/ios
xcodebuild \
  -exportArchive \
  -archivePath build/Runner.xcarchive \
  -exportOptionsPlist ../ExportOptions.plist \
  -exportPath ../ipa
```

---

## 📱 Syncing Multiple Devices

Once installed:
- ✅ App syncs to iCloud
- ✅ Can install on multiple iPhones
- ✅ Updates not automatic (rebuild needed)
- ✅ Expires after ~1 week (AltStore)

---

## 💡 Pro Tips

1. **Get notifications**: Add email notifications in workflow
2. **Faster builds**: Use `--debug` for testing
3. **Schedule builds**: Set cron schedule in workflow
4. **Auto-deploy**: Add TestFlight upload step (advanced)
5. **Track versions**: Use Git tags for releases

---

## ✅ Checklist

- [ ] Push project to GitHub
- [ ] Verify `.github/workflows/build-ios-ipa.yml` exists
- [ ] Trigger build manually
- [ ] Wait for completion
- [ ] Download IPA artifact
- [ ] Install using AltStore or Xcode
- [ ] Launch app on iPhone 14 Pro Max
- [ ] Test habit tracker
- [ ] Celebrate! 🎉

---

## 📚 Additional Resources

- [Flutter iOS Build Docs](https://flutter.dev/docs/deployment/ios)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [AltStore Official Docs](https://altstore.io/)
- [Apple Developer Docs](https://developer.apple.com/documentation/)

---

**Happy Building! Your iPhone app is just 15 minutes away!** 🚀

Last Updated: March 2026 | Version: 1.0.0
