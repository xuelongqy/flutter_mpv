#include <jni.h>
#include <map>
#include <android/log.h>
#include "../../../../include/client.h"

static std::map<int64_t, jobject> surfaceMap;
static jobject surface;

extern "C"
JNIEXPORT jlong JNICALL
Java_com_xuelongqy_flutter_mpv_FlutterMpvJni_00024Companion_getSurfaceWid(JNIEnv *env,
                                                                             jobject thiz,
                                                                             jlong mpvHandle,
                                                                             jobject _surface) {
    surface = env->NewGlobalRef(_surface);
    surfaceMap[mpvHandle] = surface;
    auto wid = (int64_t)(intptr_t) surface;
    __android_log_print(ANDROID_LOG_DEBUG, "wid", "%lld", wid);
//    auto mpv = mpv_create();
//    mpv_set_option_string(mpv, "vo", "gpu");
//    mpv_set_option_string(mpv, "gpu-context", "android");
//    mpv_set_option_string(mpv, "deband", "yes");
//    mpv_set_option_string(mpv, "gpu-debug", "yes");
//    mpv_set_option_string(mpv, "override-display-fps", "60");
//    mpv_set_option_string(mpv, "hwdec", "auto");
//    mpv_set_option_string(mpv, "hwdec-codecs", "h264,hevc,mpeg4,mpeg2video,vp8,vp9");
//    mpv_set_option_string(mpv, "ao", "audiotrack,opensles");
//    mpv_set_option_string(mpv, "input-default-bindings", "yes");
//    mpv_set_option_string(mpv, "vd-lavc-dr", "no");
//    mpv_initialize(mpv);
//    mpv_set_option_string(mpv, "save-position-on-quit", "no");
//    mpv_set_option_string(mpv, "force-window", "yes");
//    mpv_set_option(mpv, "wid", MPV_FORMAT_INT64, (void*) _surface);
//    const char *args[] = {"loadfile", "https://sample-videos.com/video123/mkv/720/big_buck_bunny_720p_10mb.mkv", nullptr};
//    mpv_set_option_string(mpv, "android-surface-size", "1440x2787");
//    mpv_command(mpv, args);
    return wid;
}
extern "C"
JNIEXPORT void JNICALL
Java_com_xuelongqy_flutter_mpv_FlutterMpvJni_00024Companion_removeSurfaceWid(JNIEnv *env,
                                                                              jobject thiz,
                                                                              jlong mpvHandle) {
    surface = surfaceMap[mpvHandle];
    surfaceMap.erase(mpvHandle);
    env->DeleteGlobalRef(surface);
    surface = nullptr;
}