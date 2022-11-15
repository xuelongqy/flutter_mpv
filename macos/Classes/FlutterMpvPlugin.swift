import Cocoa
import FlutterMacOS

public class FlutterMpvPlugin: NSObject, FlutterPlugin {
  static var mRegister: FlutterPluginRegistrar?
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    mRegister = registrar
    let channel = FlutterMethodChannel(name: "com.xuelongqy.flutter.mpv", binaryMessenger: registrar.messenger)
    let instance = FlutterMpvPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "create":
      create(call: call, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    
  public func create(call: FlutterMethodCall, result: @escaping FlutterResult) {
      result(["textureId": 0, "wid": 0, "mpvHandle": call.arguments])
  }
}
