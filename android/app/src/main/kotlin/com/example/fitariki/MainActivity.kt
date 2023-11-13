package com.eBrandstepOut.stepOut

import io.flutter.embedding.android.FlutterActivity

import com.microsoft.appcenter.AppCenter;
import com.microsoft.appcenter.analytics.Analytics;
import com.microsoft.appcenter.crashes.Crashes;

class MainActivity: FlutterActivity() {
    fun onCreate(savedInstanceState: Bundle?) {
        AppCenter.start(
            getApplication(), "f66a71a7-68e7-48d1-b792-9f953423dbec",
            Analytics::class.java, Crashes::class.java
        )
    }
}
