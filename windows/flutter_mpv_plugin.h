#ifndef FLUTTER_PLUGIN_FLUTTER_MPV_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_MPV_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_mpv {

class FlutterMpvPlugin : public flutter::Plugin {
 public:
  static flutter::PluginRegistrarWindows* mRegistrar;
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterMpvPlugin();

  virtual ~FlutterMpvPlugin();

  // Disallow copy and assign.
  FlutterMpvPlugin(const FlutterMpvPlugin&) = delete;
  FlutterMpvPlugin& operator=(const FlutterMpvPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

  std::map<flutter::EncodableValue, flutter::EncodableValue> create(
      const flutter::MethodCall<flutter::EncodableValue>& method_call);
};

}  // namespace flutter_mpv

#endif  // FLUTTER_PLUGIN_FLUTTER_MPV_PLUGIN_H_
