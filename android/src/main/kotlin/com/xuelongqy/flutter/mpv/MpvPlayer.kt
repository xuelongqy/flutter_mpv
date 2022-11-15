package com.xuelongqy.flutter.mpv

import android.content.Context
import android.util.AttributeSet
import android.util.Log
import android.view.SurfaceHolder
import android.view.SurfaceView

class MPVView(context: Context, attrs: AttributeSet) : SurfaceView(context, attrs), SurfaceHolder.Callback {
    override fun surfaceCreated(holder: SurfaceHolder) {
        Log.w("ssss", "attaching surface")
        FlutterMpvJni.getSurfaceWid(0, holder.surface)
//        MPVLib.create(this.context)
//        MPVLib.setOptionString("vo", "gpu")
//        MPVLib.setOptionString("gpu-context", "android")
//        MPVLib.init()
//        MPVLib.setOptionString("save-position-on-quit", "no")
//        MPVLib.setOptionString("force-window", "no")
//        MPVLib.attachSurface(holder.surface)
//        // This forces mpv to render subs/osd/whatever into our surface even if it would ordinarily not
//        MPVLib.setOptionString("force-window", "yes")
//        MPVLib.command(arrayOf("loadfile", "https://viide-filestore.oss-cn-hangzhou.aliyuncs.com/dev/mp4/1349333442.mp4"))
    }

    override fun surfaceChanged(holder: SurfaceHolder, format: Int, width: Int, height: Int) {
        Log.d("MPVView", "$width * $height");
    }

    override fun surfaceDestroyed(holder: SurfaceHolder) {
    }
}