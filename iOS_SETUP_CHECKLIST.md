# GitHub Actions iOS Build Setup Checklist

**Step-by-step checklist to build your Flutter app for iPhone on GitHub!**

---

## ✅ Phase 1: Repository Setup

- [ ] Create GitHub account (https://github.com)
- [ ] Create new repository for your project
- [ ] Note the repository URL: `https://github.com/YOUR_USERNAME/REPO_NAME`

---

## ✅ Phase 2: Push Your Code

### Setup Git Locally
- [ ] Open terminal/PowerShell in project folder
- [ ] Run: `git init`
- [ ] Run: `git add .`
- [ ] Run: `git commit -m "Initial commit"`
- [ ] Run: `git remote add origin https://github.com/YOUR_USERNAME/REPO_NAME`
- [ ] Run: `git branch -M main`
- [ ] Run: `git push -u origin main`

### Verify on GitHub
- [ ] Go to your GitHub repository
- [ ] Verify files are there:
  - [ ] `lib/main.dart`
  - [ ] `pubspec.yaml`
  - [ ] `.github/workflows/build-ios-ipa.yml` ← This is important!
  - [ ] `ios/ExportOptions.plist`
- [ ] If missing: Manually upload files or check git push

---

## ✅ Phase 3: Verify Workflow File

### Check Workflow Exists
- [ ] Go to GitHub repository
- [ ] Click **"Code"** tab
- [ ] Look for `.github/workflows/build-ios-ipa.yml`
- [ ] If not visible:
  - [ ] Manually create the file on GitHub
  - [ ] Copy content from `iOS_CLOUD_BUILD_GUIDE.md`

### Verify Workflow Content
- [ ] File should contain: `name: Build iOS IPA`
- [ ] Should have: `runs-on: macos-latest`
- [ ] Should have: `flutter build ios`
- [ ] Should have: `xcodebuild` commands

---

## ✅ Phase 4: Trigger First Build

### Method A: Automatic (Recommended)
- [ ] Push any change to `main` branch:
  ```bash
  echo "# iOS Build Ready!" >> README.md
  git add .
  git commit -m "Trigger build"
  git push origin main
  ```

### Method B: Manual
- [ ] Go to GitHub repository
- [ ] Click **"Actions"** tab
- [ ] Click **"Build iOS IPA"** workflow
- [ ] Click **"Run workflow"** button
- [ ] Select branch: `main`
- [ ] Click **"Run workflow"** button

---

## ✅ Phase 5: Monitor Build

### Watch Workflow Run
- [ ] Go to **"Actions"** tab
- [ ] You should see "Build iOS IPA" workflow running
- [ ] Yellow dot (🟡) = In progress
- [ ] Green checkmark (✅) = Success
- [ ] Red X (❌) = Failed

### Check Progress
- [ ] Click the workflow run name
- [ ] Click **"build-ios"** job
- [ ] Expand step logs to see progress
- [ ] Look for:
  - [ ] "Setup Flutter" ✅
  - [ ] "Get Flutter dependencies" ✅
  - [ ] "Build iOS app" ✅
  - [ ] "Export IPA" ✅

### Expected Duration
- [ ] Total time: 15-20 minutes
- [ ] Don't close the page or GitHub tab

---

## ✅ Phase 6: Download IPA

### After Build Completes (✅ Green Checkmark)
- [ ] Still in Actions tab, scroll down
- [ ] Look for **"Artifacts"** section
- [ ] You should see: **"Prince-Lifestyle-Matrix-iOS"**
- [ ] Click to expand the artifact
- [ ] Click **"Download"** button
- [ ] Wait for ZIP file to download (~50-80 MB)

### Extract IPA File
- [ ] Locate downloaded ZIP file
- [ ] Extract/Unzip the file
- [ ] You should see: **`Prince-Lifestyle-Matrix-iOS.ipa`**
- [ ] Note the folder location for later

---

## ✅ Phase 7: Install IPA on iPhone

### Preparation
- [ ] iPhone 14 Pro Max available
- [ ] iPhone charged (>20% battery)
- [ ] iPhone unlocked
- [ ] USB cable ready (for some methods)

### Choose Installation Method

#### Option A: AltStore (Recommended for Windows)
- [ ] Download AltStore: https://altstore.io/
- [ ] Install AltStore on your Windows PC
- [ ] Open AltStore
- [ ] Connect iPhone via USB cable
- [ ] In AltStore, click **"My Apps"**
- [ ] Click **"+"** button
- [ ] Select your downloaded `.ipa` file
- [ ] Sign in with your Apple ID
- [ ] Accept when iPhone asks
- [ ] Wait for installation (~2-5 minutes)
- [ ] App appears on iPhone home screen ✨

#### Option B: Xcode (Mac Only)
- [ ] Open Xcode on Mac
- [ ] Connect iPhone via USB
- [ ] Go to **Window** → **Devices and Simulators**
- [ ] Select your iPhone
- [ ] Drag `.ipa` file onto the iPhone in Xcode
- [ ] Wait for installation

#### Option C: Cydia Impactor (All Platforms)
- [ ] Download: http://www.cydiaimpactor.com/
- [ ] Install on your computer
- [ ] Connect iPhone
- [ ] Drag `.ipa` file onto Cydia Impactor window
- [ ] Enter Apple ID when prompted
- [ ] Accept prompts on iPhone

---

## ✅ Phase 8: Launch App on iPhone

### After Installation
- [ ] Look for "Prince's Lifestyle Matrix" app on home screen
- [ ] Tap to open
- [ ] First launch may take 10-15 seconds
- [ ] See the habit grid!

### Test Features
- [ ] See your profile at top
- [ ] Click a checkbox - does it work?
- [ ] See stats update instantly
- [ ] Try mood selector
- [ ] Try sleep logger
- [ ] Scroll the habit grid

### Success! 🎉
- [ ] App launches without crashing
- [ ] Checkboxes work
- [ ] Stats update
- [ ] UI looks good
- [ ] All features work

---

## 🐛 Troubleshooting Checklist

### Build Won't Start
- [ ] Check you pushed code to GitHub
- [ ] Check `.github/workflows/build-ios-ipa.yml` exists in repo
- [ ] Try manual trigger from Actions tab
- [ ] Wait 1-2 minutes for workflow to appear

### Build Failed (Red ❌)
- [ ] Click workflow to see logs
- [ ] Look for error message
- [ ] Common issues:
  - [ ] Flutter version mismatch → Check `pubspec.yaml`
  - [ ] Dependency error → Run `flutter pub get` locally
  - [ ] XCode error → This is from GitHub's macOS server
- [ ] Fix locally, commit, push again

### Artifacts Missing
- [ ] Build must have succeeded (green ✅)
- [ ] Scroll down in workflow page
- [ ] Look for "Artifacts" section
- [ ] If still missing: Scroll all the way down

### IPA Won't Download
- [ ] Check file is green ✅ (succeeded)
- [ ] Try different browser
- [ ] Try incognito/private mode
- [ ] Try again after 5 minutes

### IPA Won't Install with AltStore
- [ ] iPhone must be connected via USB
- [ ] AltStore must show iPhone in window
- [ ] Apple ID must be correct
- [ ] iPhone must have enough storage (>500 MB)
- [ ] Try restarting iPhone
- [ ] Try different USB cable

### IPA Won't Install with Xcode
- [ ] Xcode must be running
- [ ] iPhone must be visible in Devices window
- [ ] Try unplugging and reconnecting iPhone
- [ ] Try `flutter install` instead

### App Crashes on Launch
- [ ] Check iOS version (must be iOS 15+)
- [ ] Try reinstalling IPA
- [ ] Delete and reinstall the app
- [ ] Check device logs

### Can't See App on Home Screen
- [ ] Scroll through all pages
- [ ] Check in App Library
- [ ] App should be under: **All Apps** or **Productivity**
- [ ] Long-press to see it

---

## 🔄 Update & Rebuild

### Make Changes
- [ ] Edit `lib/main.dart` (colors, habits, name)
- [ ] Locally test if possible: `flutter run`
- [ ] Commit and push:
  ```bash
  git add .
  git commit -m "Update colors and habits"
  git push origin main
  ```

### Trigger New Build
- [ ] GitHub Actions automatically starts
- [ ] No manual action needed
- [ ] Or manually trigger from Actions tab

### Get Updated IPA
- [ ] Wait 15-20 minutes for build
- [ ] Download new IPA from artifacts
- [ ] Uninstall old app from iPhone
- [ ] Install new IPA using AltStore
- [ ] Test changes!

---

## ✅ Final Verification

After everything is working:

- [ ] App installs successfully
- [ ] App launches without errors
- [ ] Profile appears at top
- [ ] Habit grid is visible
- [ ] Checkboxes are clickable
- [ ] Stats update instantly
- [ ] Dark theme looks good
- [ ] No layout issues
- [ ] Mood tracker works
- [ ] Sleep logger works

**Everything checked?** Congratulations! 🎉

---

## 📞 Emergency Contacts

### Build Still Failing?
1. Check workflow logs in Actions tab
2. Google the specific error message
3. Verify `pubspec.yaml` is valid
4. Try `flutter clean && flutter pub get` locally
5. Push again to GitHub

### IPA Still Won't Install?
1. Try different installation tool (AltStore recommended)
2. Check iPhone storage (Settings → General → Storage)
3. Verify iOS version (iOS 15+)
4. Restart both iPhone and computer
5. Try different USB cable

### General Help?
- See: `iOS_CLOUD_BUILD_GUIDE.md` (comprehensive guide)
- See: `iOS_BUILD_QUICK_REFERENCE.md` (quick reference)
- Check: GitHub Actions documentation
- Try: AltStore help forums

---

## 🎯 Success Timeline

| Step | Time | Status |
|------|------|--------|
| Push code | 5 min | ✅ |
| Build starts | 1 min | ✅ |
| Build runs | 15-20 min | ⏳ |
| Artifacts ready | 0 min | ⏳ |
| Download IPA | 2-5 min | ⏳ |
| Install with AltStore | 2-5 min | ⏳ |
| Launch app | 1 min | ⏳ |
| **Total** | **30-40 min** | 🎉 |

---

## 💡 Pro Tips

1. **Bookmark the Actions tab** for quick access
2. **Test locally first** before pushing to avoid failed builds
3. **Check logs immediately** if build fails
4. **Keep your AltStore updated** for best compatibility
5. **Verify file exists** before deleting old version
6. **Keep 2-3 old IPAs** for backup

---

## 🚀 You're Ready!

Follow this checklist start to finish, and you'll have:
- ✅ Flutter app building in the cloud
- ✅ IPA file ready on your computer
- ✅ App running on your iPhone 14 Pro Max
- ✅ Automated builds for future updates

**Estimated time: 30-40 minutes total**

---

## ✅ After Complete

- [ ] Bookmark or screenshot this checklist
- [ ] Save the IPA file location
- [ ] Remember your Apple ID for AltStore
- [ ] Keep app for daily habit tracking
- [ ] Modify habits as needed
- [ ] Rebuild anytime with new changes

---

**Happy Building! Your iPhone app awaits!** 🎉🚀

Created: March 2026 | Version: 1.0.0
