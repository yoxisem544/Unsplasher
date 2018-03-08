//
//  AppDelegate.swift
//  Unsplasher
//
//  Created by David on 2018/3/8.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    setupThirdPartyDependencies()
    
    return true
  }

  func setupThirdPartyDependencies() {
    Fabric.with([Crashlytics.self])
  }

}

