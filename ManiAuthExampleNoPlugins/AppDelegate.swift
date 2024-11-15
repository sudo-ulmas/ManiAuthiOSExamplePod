//
//  AppDelegate.swift
//  ManiAuthExampleNoPlugins
//
//  Created by Abdullah Rakhmatullaev on 06/11/24.
//

import UIKit
import Flutter
//import FlutterPluginRegistrant

@main
class AppDelegate: FlutterAppDelegate {
    lazy var flutterEngine = FlutterEngine(name: "mani auth engine")

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      // Runs the default Dart entrypoint with a default Flutter route.
        flutterEngine.run();
        // Connects plugins with iOS platform code to this app.
//        GeneratedPluginRegistrant.register(with: self.flutterEngine);
      return super.application(application, didFinishLaunchingWithOptions: launchOptions);
    }
}


