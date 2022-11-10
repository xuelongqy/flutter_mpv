#include <jni.h>
#include <android/log.h>

extern "C"
JNIEXPORT jlong JNICALL
Java_com_xuelongqy_flutter_mpv_FlutterMpvJni_00024Companion_getSurfaceWid(JNIEnv *env,
                                                                             jobject thiz,
                                                                             jobject self) {
    auto surface = env->NewGlobalRef(self);
    __android_log_print(ANDROID_LOG_DEBUG, "mpv", "%ld", surface);
    auto wid = (int64_t)(intptr_t) surface;
    return wid;
}