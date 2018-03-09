//
//  SecretKeys.swift
//  Unsplasher
//
//  Created by David on 2018/3/9.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation

final public class SecretKeys {
  
  private init() { }
  
  private class func getAPIKey(file: String, extension: String = "apikey") -> String {
    // The string that results from reading the bundle resource contains a trailing
    // newline character, which we must remove now because Fabric/Crashlytics
    // can't handle extraneous whitespace.
    let resourceURL = Bundle.main.url(forResource: file + "." + `extension`, withExtension: nil)!
    return try! String(contentsOf: resourceURL).trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  public static var unsplashAppID: String {
    return getAPIKey(file: "unsplash", extension: "appid")
  }

}
