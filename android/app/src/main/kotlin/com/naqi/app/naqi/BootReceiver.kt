package com.naqi.app.naqi

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import androidx.annotation.RequiresApi

class BootReceiver : BroadcastReceiver() {
    @RequiresApi(Build.VERSION_CODES.O)
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == Intent.ACTION_BOOT_COMPLETED) {
            // Check if filter was enabled before reboot
            val sharedPreferences = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
            val settingsJson = sharedPreferences.getString("flutter.app_settings", null)
            
            // If filter was enabled, you can restart the service here
            // For now, we just log that boot was completed
            android.util.Log.d("NaqiApp", "Boot completed - Ready to start monitoring if enabled")
        }
    }
}
