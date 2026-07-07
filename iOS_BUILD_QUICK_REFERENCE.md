# GitHub Actions iOS Build - Quick Reference

**Build your Flutter app for iOS in the cloud without a Mac!**

---

## ⚡ Quick Setup (2 minutes)

### 1. Push to GitHub
```bash
cd PrinceLifeTrackiungApp
git add .
git commit -m "Add to GitHub"
git push origin main
```

### 2. Check Actions Tab
- Go to your GitHub repository
- Click **"Actions"** tab
- See workflow running automatically! ✨

### 3. Download IPA (after ~20 minutes)
- Actions tab → Completed workflow
- Scroll to "Artifacts"
- Download `.ipa` file

### 4. Install on iPhone
- Download [AltStore](https://altstore.io/) (Windows/Mac/Linux)
- Connect iPhone via USB
- Open AltStore, drag .ipa file
- Done! 🎉

---

## 📊 Workflow Files

### Main Workflow
**File**: `.github/workflows/build-ios-ipa.yml`

Automatically:
- ✅ Triggers on every push to `main`
- ✅ Builds iOS app on GitHub's macOS servers
- ✅ Exports IPA file
- ✅ Uploads as downloadable artifact

### Export Configuration
**File**: `ios/ExportOptions.plist`

Tells xcodebuild how to export the IPA.

---

## 🎯 Common Tasks

### Trigger Build Manually
1. GitHub Actions tab
2. Select "Build iOS IPA" workflow
3. Click "Run workflow"
4. Choose branch (main/develop)
5. Click "Run workflow"

### View Build Logs
1. Actions tab
2. Click the workflow run
3. Click "build-ios" job
4. See detailed logs

### Download IPA
1. Actions tab
2. Click completed workflow
3. Scroll to Artifacts section
4. Download "Prince-Lifestyle-Matrix-iOS"
5. Extract ZIP to get .ipa file

### Check Build Status
Actions tab shows:
- 🟡 In progress
- ✅ Success (artifact ready)
- ❌ Failed (check logs)

---

## 🔧 Troubleshooting

| Issue | Solution |
|-------|----------|
| Build won't start | Push code to GitHub first |
| Build takes too long | Normal (15-20 min), check logs |
| No artifacts after build | Build failed, check logs |
| IPA won't install | Try AltStore or different tool |
| App crashes on iPhone | Check iOS version compatibility |

---

## 📱 Installation Methods

### Windows Users - Use AltStore
1. Download [AltStore](https://altstore.io/)
2. Install on Windows PC
3. Connect iPhone via USB
4. Open AltStore
5. Click "+" and select .ipa file
6. Sign in with Apple ID
7. App installs! ✨

### Mac Users - Use Xcode
```bash
# Connect iPhone
# Open Xcode
# Window → Devices and Simulators
# Drag .ipa onto your iPhone
```

### Advanced - TestFlight (App Store)
Requires:
- Apple Developer Account ($99/year)
- Code signing setup
- TestFlight configuration

See iOS_CLOUD_BUILD_GUIDE.md for details.

---

## 🚀 Automatic Triggers

Build runs automatically when:
- ✅ You push to `main` branch
- ✅ You push to `develop` branch
- ✅ Pull request created

No manual action needed!

---

## 📝 Build Configuration

### Debug Build (Default)
```yaml
flutter build ios --no-codesign --debug
```
- Fast builds
- No signing needed
- Perfect for testing
- **Current setup**

### Release Build
```yaml
flutter build ios --no-codesign --release
```
- Slower builds
- Still no signing
- Optimized performance
- For production testing

### Production Build (With Signing)
- Requires Apple Developer Account
- Requires code signing certificates
- Requires provisioning profiles
- See advanced guide for setup

---

## 🔄 Update & Rebuild

### Change Code
```bash
# Make changes to your app
# E.g., change colors, habits, profile

# Commit and push
git add .
git commit -m "Update app colors"
git push origin main

# Automatic build triggers! ✨
# Check Actions tab in 20 minutes
```

### Change Habits
Edit `lib/main.dart` → `_initializeHabits()`:
```dart
Habit(
  id: '11',
  name: 'New Habit',
  emoji: '🎯',
  completionDays: List.generate(31, (i) => false),
)
```
Then push to trigger rebuild.

---

## ✅ Workflow Status

### ✅ Success
- Artifacts available
- Download and install
- Everything works!

### ❌ Failed
- Check logs for error
- Common: Flutter version, dependency issues
- Fix locally, push again

### 🟡 Running
- Wait for completion
- Check logs if interested
- Typically 15-20 minutes

---

## 📊 Build Times

| Step | Time |
|------|------|
| Setup | ~3 min |
| Get dependencies | ~2 min |
| Build iOS | ~8 min |
| Export IPA | ~2 min |
| **Total** | ~15-20 min |

---

## 🔐 Security

### Current Setup (Unsigned)
- ✅ No credentials needed
- ✅ Safe to use
- ✅ Free!
- ⚠️ Expires after ~7 days (AltStore)

### Production Setup (Signed)
- Requires Apple Developer Account
- Store credentials in GitHub Secrets
- Never commit certificates
- For official App Store releases

---

## 🎯 Next Steps

1. **Push to GitHub** (if not done)
2. **Wait 20 minutes** for first build
3. **Download IPA** from artifacts
4. **Install with AltStore**
5. **Test on iPhone 14 Pro Max**
6. **Enjoy!** 🎉

---

## 📞 Quick Help

### Build won't trigger?
→ Push to `main` or `develop` branch

### Artifacts missing?
→ Check if build succeeded (green checkmark)

### IPA installation fails?
→ Try AltStore instead of other tools

### Want faster builds?
→ Use `--debug` mode (already default)

### Need signing for App Store?
→ See full guide: `iOS_CLOUD_BUILD_GUIDE.md`

---

**Ready? Push your code to GitHub and watch it build!** 🚀

Created: March 2026 | Last Updated: March 2026
