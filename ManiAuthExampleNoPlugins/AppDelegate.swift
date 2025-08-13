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
    
    func createNewFlutterEngine() -> FlutterEngine {
        let engine = FlutterEngine(name: "mani auth engine")
        engine.run()
        return engine
    }

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      return super.application(application, didFinishLaunchingWithOptions: launchOptions);
    }
}


