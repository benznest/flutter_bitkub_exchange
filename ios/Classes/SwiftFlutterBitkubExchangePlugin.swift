import Flutter
import UIKit

public class SwiftFlutterBitkubExchangePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_bitkub_exchange", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterBitkubExchangePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
