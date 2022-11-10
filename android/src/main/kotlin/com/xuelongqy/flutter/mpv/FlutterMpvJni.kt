package com.xuelongqy.flutter.mpv

class FlutterMpvJni {
    companion object {
        init {
            System.loadLibrary("flutter-mpv-lib")
        }
        external fun getSurfaceWid(self: Any): Long
    }
}