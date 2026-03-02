plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.fennac_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "29.0.14206865"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.fennac.ostryx"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        // Temporarily target SDK 34 to avoid 16KB warnings until Agora updates their SDK
        targetSdk = 34
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        
        // Restrict to arm64-v8a (primary architecture) to reduce APK size
        ndk {
            abiFilters.add("arm64-v8a")
        }
    }
    
    // Enable split APKs by ABI for Play Store optimization
    bundle {
        language {
            enableSplit = true
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            
            // Enable Dart code stripping to remove unused Dart code
            ndk {
                abiFilters.clear()
                abiFilters.add("arm64-v8a")
            }
        }
    }

    packaging {
        jniLibs {
            // Force legacy packaging so native libs are extracted on device.
            // This reduces 16 KB page-size compatibility warnings for debug builds
            // when third-party SDKs ship non-16 KB-aligned binaries.
            useLegacyPackaging = true
        }
    }

}

flutter {
    source = "../.."
}
