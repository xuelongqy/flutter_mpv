#include "flutter_mpv_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>

namespace flutter_mpv {

// static
flutter::PluginRegistrarWindows* FlutterMpvPlugin::mRegistrar = nullptr;

void FlutterMpvPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  FlutterMpvPlugin::mRegistrar = registrar;
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "com.xuelongqy.flutter.mpv",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<FlutterMpvPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

FlutterMpvPlugin::FlutterMpvPlugin() {}

FlutterMpvPlugin::~FlutterMpvPlugin() {}

void FlutterMpvPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare("create") == 0) {
    result->Success(flutter::EncodableMap(create(method_call)));
  } else {
    result->NotImplemented();
  }
}

std::map<flutter::EncodableValue, flutter::EncodableValue> FlutterMpvPlugin::create(
    const flutter::MethodCall<flutter::EncodableValue>& method_call) {
    std::map<flutter::EncodableValue, flutter::EncodableValue> resultMap;
    resultMap[flutter::EncodableValue("textureId")] = flutter::EncodableValue(0);
    resultMap[flutter::EncodableValue("wid")] = flutter::EncodableValue(0);
    resultMap[flutter::EncodableValue("mpvHandle")] = flutter::EncodableValue(method_call.arguments()->LongValue());
    return resultMap;
}

}  // namespace flutter_mpv
