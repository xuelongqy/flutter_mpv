package com.xuelongqy.flutter.mpv

import `is`.xyz.mpv.MPVLib
import android.annotation.SuppressLint
import android.view.Surface

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.view.TextureRegistry

/** FlutterMpvPlugin */
class FlutterMpvPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  /// Flutter plugin binding
  private lateinit var flutterPluginBinding : FlutterPlugin.FlutterPluginBinding

  /// Surface list.
  private val mpvTextureMap = hashMapOf<Long, MpvTextureEntity>()

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    MPVLib.create(flutterPluginBinding.applicationContext)
    MPVLib.destroy()
    this.flutterPluginBinding = flutterPluginBinding
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.xuelongqy.flutter.mpv")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
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
    mpvTextureMap[surfaceTextureEntry.id()] = MpvTextureEntity(surfaceTextureEntry, surface)
    result.success(mapOf(
      "textureId" to surfaceTextureEntry.id(),
      "wid" to FlutterMpvJni.getSurfaceWid(mpvHandle, surface),
      "mpvHandle" to mpvHandle,
    ))
  }

  private fun dispose(call: MethodCall, result: Result) {
    val textureId = call.argument<Long>("textureId")!!
    val mpvHandle = call.argument<Long>("mpvHandle")!!
    FlutterMpvJni.removeSurfaceWid(mpvHandle);
    mpvTextureMap[textureId]?.run {
      surface.release()
      surfaceTextureEntry.release()
    }
    result.success(null)
  }
}

data class MpvTextureEntity(
  val surfaceTextureEntry: TextureRegistry.SurfaceTextureEntry,
  val surface: Surface,
);
