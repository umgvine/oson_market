# YA Market (Flutter)

Flutter asosidagi ko'p platformali e-commerce ilova.

## Deploy va Hosting (Uzbek)

Quyida web (GitHub Pages) va Android APK uchun avtomatik build/deploy jarayonlari keltirilgan.

### 1) GitHub repo va push

1. GitHub’da bo'sh repo yarating (public yoki private).
2. Lokalda quyidagilarni bajaring:

  ```bash
  git init
  git add .
  git commit -m "Initial commit"
  git branch -M main
  git remote add origin https://github.com/<user>/<repo>.git
  git push -u origin main
  ```

### 2) Web deploy (GitHub Pages)

Ushbu repo `/.github/workflows/deploy-pages.yml` workflow’idan foydalanadi (GitHub Pages “GitHub Actions” manbasi orqali):

- `main` branchga push qilinganda:
  - (ixtiyoriy) testlar
  - `flutter build web` (to‘g‘ri `--base-href` bilan)
  - Pages artifact sifatida yuklanadi va `actions/deploy-pages` orqali deploy qilinadi (alohida `gh-pages` branch ishlatilmaydi)

Custom domen uchun Settings → Secrets and variables → Actions → Variables bo‘limida `PAGES_CNAME` nomli variable yarating va domeningizni kiriting (masalan, `shop.example.uz`). Workflow `CNAME` faylini avtomatik qo‘shadi.

GitHub Pages ni yoqish:

1. Repo Settings → Pages.
2. Build and deployment: `GitHub Actions` ni tanlang.
3. Deploy tugagach, `https://<user>.github.io/<repo>/` yoki custom domain orqali sayt ochiladi.

Eslatma: Agar custom domen bo‘lmasa, build `--base-href /<repo>/` bilan qilinadi. Domen o‘zgarganda brauzer keshini tozalash foydali.

#### Live URL (auto-deploy)

- Prod (Pages): <https://umgvine.github.io/ya-market/>

CI `/.github/workflows/deploy-pages.yml` fayli orqali har bir `main` push’da Flutter Web’ni quyidagicha build qiladi:

```bash
flutter build web --release --base-href "/ya-market/" --pwa-strategy=offline-first
```

Shu sabab GitHub Pages’dagi subpathda (`/<repo>/`) assetlar to‘g‘ri yuklanadi.

### 3) Android APK release

`/.github/workflows/release_apk.yml` workflow `v*.*.*` teg (tag) push qilinganda APK build qiladi va GitHub Release’ga yuklaydi.

Teg yaratish va push:

```bash
git tag v1.0.0
git push origin v1.0.0
```

Release sahifasida `app-release.apk` faylini topasiz.

#### Ixtiyoriy: Imzolash (signing) uchun secrets

Play Store yoki imzolangan APK kerak bo‘lsa, quyidagi secrets’larni qo‘shing (Repo → Settings → Secrets and variables → Actions → Secrets):

- `ANDROID_KEYSTORE_BASE64` — `upload-keystore.jks` faylni base64 ko‘rinishda
- `KEYSTORE_PASSWORD`
- `KEY_PASSWORD`
- `KEY_ALIAS`

Workflow ularni o‘qib `android/key.properties` va `android/app/upload-keystore.jks` ni yaratadi. Aks holda unsigned release APK generatsiya qilinadi.

### 4) Lokal build/test komandalar (ixtiyoriy)

```bash
flutter pub get
flutter test
flutter build web --release
flutter build apk --release
```

### 5) Custom domen DNS

GitHub Pages uchun domeningizni `CNAME` yozuv orqali `username.github.io` ga yo‘naltiring. DNS o‘zgarishlari 5–60 daqiqa ichida kuchga kiradi (ba'zan ko‘proq). SSL sertifikat GitHub tomonidan avtomatik beriladi.

---

## Getting Started

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
