package com.xuelongqy.flutter.mpv

class FlutterMpvJni {
    companion object {
        init {
            System.loadLibrary("flutter-mpv-lib")
        }
        external fun getSurfaceWid(mpvHandle: Long, _surface: Any): Long
        external fun removeSurfaceWid(mpvHandle: Long)
    }
}