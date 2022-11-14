package com.xuelongqy.flutter.mpv

import android.annotation.SuppressLint
import android.content.ComponentName
import android.content.Intent
import android.view.Surface

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterMpvPlugin */
class FlutterMpvPlugin: FlutterPlugin, MethodCallHandler {
  companion object {
    lateinit var call: MethodCall
    lateinit var result: Result
  }

  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  /// Flutter plugin binding
  private lateinit var flutterPluginBinding : FlutterPlugin.FlutterPluginBinding

  /// Surface list.
  private val surfaceMap = hashMapOf<Long, Surface>()

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    this.flutterPluginBinding = flutterPluginBinding
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.xuelongqy.flutter.mpv")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    FlutterMpvPlugin.call = call
    FlutterMpvPlugin.result = result
    when (call.method) {
        "create" -> {
          create(call, result)
        }
        "dispose" -> {
          dispose(call, result)
        }
        else -> {
          result.notImplemented()
        }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  @SuppressLint("Recycle")
  private fun create(call: MethodCall, result: Result) {
//    val intent = Intent()
//    intent.component = ComponentName(flutterPluginBinding.applicationContext, "com.xuelongqy.mpv.flutter_mpv_example.MpvActivity")
//    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
//    flutterPluginBinding.applicationContext.startActivity(intent)
    val mpvHandle = call.arguments as Long
    val surfaceTextureEntry = flutterPluginBinding.textureRegistry.createSurfaceTexture()
    val surface = Surface(surfaceTextureEntry.surfaceTexture())
    surfaceMap[surfaceTextureEntry.id()] = surface
    result.success(mapOf("textureId" to surfaceTextureEntry.id(), "wid" to FlutterMpvJni.getSurfaceWid(mpvHandle, surface), "mpvHandle" to mpvHandle))
  }

  private fun dispose(call: MethodCall, result: Result) {
    val textureId = call.argument<Long>("textureId")!!
    val mpvHandle = call.argument<Long>("mpvHandle")!!
    FlutterMpvJni.removeSurfaceWid(mpvHandle);
    surfaceMap[textureId]!!.release()
    result.success(null)
  }
}
