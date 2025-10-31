package com.naqi.flutter_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.media.projection.MediaProjectionManager
import android.os.Build
import android.app.Activity

class MainActivity : FlutterActivity() {
    private val CHANNEL = "naqi/filter"
    private val REQUEST_CODE_MEDIA_PROJECTION = 1001
    private var pendingResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "initialize" -> {
                    result.success(true)
                }
                "requestPermission" -> {
                    requestScreenCapturePermission(result)
                }
                "captureScreen" -> {
                    // Screen capture implementation (placeholder)
                    result.success(null)
                }
                "applyBlur" -> {
                    // Blur implementation (placeholder)
                    result.success(true)
                }
                "stopMonitoring" -> {
                    result.success(true)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun requestScreenCapturePermission(result: MethodChannel.Result) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val mediaProjectionManager = getSystemService(MEDIA_PROJECTION_SERVICE) as MediaProjectionManager
            pendingResult = result
            startActivityForResult(mediaProjectionManager.createScreenCaptureIntent(), REQUEST_CODE_MEDIA_PROJECTION)
        } else {
            result.success(false)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        
        if (requestCode == REQUEST_CODE_MEDIA_PROJECTION) {
            if (resultCode == Activity.RESULT_OK) {
                pendingResult?.success(true)
            } else {
                pendingResult?.success(false)
            }
            pendingResult = null
        }
    }
}
