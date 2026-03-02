# Optimized ProGuard rules for maximum APK size reduction

# === Code Removal Optimizations ===
# Remove logging completely to reduce code size
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
    public static *** i(...);
    public static *** e(...);
}

# Remove BuildConfig debug field references
-assumenosideeffects class * {
    public static final boolean DEBUG;
}

# === Class/Library Keep Rules ===
# Keep OkHttp3 classes (used by image_cropper and Firebase)
-keep class okhttp3.** { *; }
-keep class okio.** { *; }
-keep interface okhttp3.** { *; }
-keep interface okio.** { *; }
-dontwarn okhttp3.**
-dontwarn okio.**

# Keep image_cropper/uCrop classes
-keep class com.yalantis.ucrop.** { *; }
-dontwarn com.yalantis.ucrop.**

# Keep Flutter plugins
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.plugins.**

# Keep Firebase classes (essential)
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# Keep Agora RTC Engine classes
-keep class io.agora.rtc2.** { *; }
-dontwarn io.agora.rtc2.**

# === Aggressive Optimization ===
# Enable maximum optimization passes
-optimizationpasses 7

# Don't use mixed case class names (improves compression)
-dontusemixedcaseclassnames

# Allow access modification to merge classes
-allowaccessmodification

# Repackage classes into a single package
-repackageclasses 'com.fennac'

# Remove unused attributes
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile

# Aggressive code optimization
-optimizations !code/simplification/arithmetic,!code/simplification/cast,!code/simplification/object,!code/allocation/variable
