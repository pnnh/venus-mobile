import Cocoa
import FlutterMacOS

public class PillowPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "pillow", binaryMessenger: registrar.messenger)
    let instance = PillowPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    case "initPlugin":
      result("ok")
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
