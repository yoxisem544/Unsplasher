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

    setupView()
    
//    RequestAuthCode().perform(scopes: UnsplashAPIPermissionScope.allScopes)
      
    return true
  }

  func setupThirdPartyDependencies() {
    Fabric.with([Crashlytics.self])
  }
  
  func setupView() {
    window = UIWindow(frame: UIScreen.main.bounds)
    let appContainer = AppContainerBuilder().buildContainer()!
    window?.rootViewController = appContainer
    window?.makeKeyAndVisible()
    window?.backgroundColor = .white
    
    UITabBar.appearance().tintColor = UnsplasherColor.dark
    UITabBar.appearance().barTintColor = .white
  }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    
    // check if open url contains code returned by unsplasher auth.
    print(url.absoluteString)
    if url.scheme == "unsplasher", url.absoluteString.contains("code=") {
      // trim code
      if let code = url.absoluteString.split(separator: "=").last {
        let code = String(code)
        // TODO: grant access token here
        GrantAccessToken().performAuthencation(with: code)
          .then(execute: { response in
            UserDefaults.standard[.accessToken] = response.accessToken
          })
          .catch(execute: { e in
            print(e)
          })
      }
    }
    
    return true
  }

}

