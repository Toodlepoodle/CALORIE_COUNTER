plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.calorie_tracker"
    compileSdk = 34 // Explicitly set compileSdkVersion to 34 (or the latest version)

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.calorie_tracker" // Replace with your app's unique ID
        minSdk = 21 // Minimum SDK version supported by Flutter
        targetSdk = 34 // Target SDK version (match compileSdkVersion)
        versionCode = 1 // Increment this for each release
        versionName = "1.0.0" // Update this for each release
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Add any additional dependencies here
    implementation("org.jetbrains.kotlin:kotlin-stdlib:1.9.22") // Use the latest Kotlin version
}