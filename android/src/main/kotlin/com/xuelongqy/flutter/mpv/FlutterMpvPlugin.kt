package com.xuelongqy.flutter.mpv

import android.annotation.SuppressLint
import android.view.Surface

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

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
  private val surfaceMap = hashMapOf<Long, Surface>()

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    this.flutterPluginBinding = flutterPluginBinding
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.xuelongqy.flutter.mpv")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
        "createSurface" -> {
          createSurface(result)
        }
        "dispose" -> {
          dispose(call, result)
        }
        else -> {
          result.notImplemented()
        }
    }
  }

  @SuppressLint("Recycle")
  private fun createSurface(result: Result) {
    val surfaceTextureEntry = flutterPluginBinding.textureRegistry.createSurfaceTexture()
    val surface = Surface(surfaceTextureEntry.surfaceTexture())
    surfaceMap[surfaceTextureEntry.id()] = surface
    result.success(mapOf("textureId" to surfaceTextureEntry.id(), "wid" to System.identityHashCode(surface)))
  }

  private fun dispose(call: MethodCall, result: Result) {
    val textureId = call.argument<Long>("textureId")!!
    surfaceMap[textureId]!!.release()
    result.success(null)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
