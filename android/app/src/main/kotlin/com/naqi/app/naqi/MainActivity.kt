package com.naqi.app.naqi

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.media.projection.MediaProjectionManager
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.naqi.app/screen_monitor"
    private val SCREEN_CAPTURE_REQUEST = 1001
    private var methodResult: MethodChannel.Result? = null
    
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "requestPermission" -> {
                    methodResult = result
                    requestScreenCapturePermission()
                }
                "analyzeScreen" -> {
                    val sensitivity = call.argument<Double>("sensitivity") ?: 0.7
                    // In production, this would trigger screen capture and analysis
                    // For now, return false (no inappropriate content detected)
                    result.success(false)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
    
    private fun requestScreenCapturePermission() {
        val mediaProjectionManager = getSystemService(Context.MEDIA_PROJECTION_SERVICE) as MediaProjectionManager
        startActivityForResult(mediaProjectionManager.createScreenCaptureIntent(), SCREEN_CAPTURE_REQUEST)
    }
    
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        
        if (requestCode == SCREEN_CAPTURE_REQUEST) {
            if (resultCode == Activity.RESULT_OK) {
                methodResult?.success(true)
                // Store the result for future use
                // In production, initialize MediaProjection here
            } else {
                methodResult?.success(false)
            }
            methodResult = null
        }
    }
}
