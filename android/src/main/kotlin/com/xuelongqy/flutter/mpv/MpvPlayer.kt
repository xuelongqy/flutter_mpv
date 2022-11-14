package com.xuelongqy.flutter.mpv

import android.content.Context
import android.util.AttributeSet
import android.util.Log
import android.view.SurfaceHolder
import android.view.SurfaceView

class MPVView(context: Context, attrs: AttributeSet) : SurfaceView(context, attrs), SurfaceHolder.Callback {

    override fun surfaceCreated(holder: SurfaceHolder) {
        val mpvHandle = FlutterMpvPlugin.call.arguments as Long
        FlutterMpvPlugin.result.success(mapOf("textureId" to 1, "wid" to FlutterMpvJni.getSurfaceWid(mpvHandle, holder.surface), "mpvHandle" to mpvHandle))
    }

    override fun surfaceChanged(holder: SurfaceHolder, format: Int, width: Int, height: Int) {
        Log.d("MPVView", "$width * $height");
    }

    override fun surfaceDestroyed(holder: SurfaceHolder) {
    }
}