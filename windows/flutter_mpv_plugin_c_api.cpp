#include "include/flutter_mpv/flutter_mpv_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_mpv_plugin.h"

void FlutterMpvPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_mpv::FlutterMpvPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
