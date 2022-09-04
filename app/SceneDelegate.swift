//
//  SceneDelegate.swift
//  yokongspam
//
//  Created by Michael Ong on 9/4/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
    guard let mainScene = (scene as? UIWindowScene) else { return }

    window = UIWindow(windowScene: mainScene)
    window?.rootViewController = RootController(nibName: nil, bundle: .main)

    window?.makeKeyAndVisible()
  }
}
