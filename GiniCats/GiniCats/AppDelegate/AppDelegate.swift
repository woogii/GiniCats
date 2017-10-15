//
//  AppDelegate.swift
//  GiniCats
//
//  Created by siwook on 2017. 10. 15..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

@UIApplicationMain
// MARK : - AppDelegate: UIResponder, UIApplicationDelegate
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    setNavigationBarProperty()
    return true
  }

  // MARK : - Set Navigation Bar Property
  func setNavigationBarProperty() {
    UINavigationBar.appearance().barTintColor        = Constants.Color.ThemeBlue
    UINavigationBar.appearance().tintColor           = UIColor.white
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
  }
}
