//
//  AppDelegate.swift
//  yokongspam
//
//  Created by Michael Ong on 9/4/22.
//

import UIKit
import YokongCommon

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(
    _: UIApplication,
    willFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    Common.initialize()

    return true
  }

  func application(
    _: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options _: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
}
