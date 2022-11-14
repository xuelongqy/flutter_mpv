package com.xuelongqy.mpv.flutter_mpv_example

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.xuelongqy.flutter.mpv.MPVView

class MpvActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_mpv)
        val mpvView = findViewById<MPVView>(R.id.mpv_view)
        mpvView.holder.addCallback(mpvView)
    }
}