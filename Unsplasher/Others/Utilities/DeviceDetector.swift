//
//  DeviceDetector.swift
//  Unsplasher
//
//  Created by David on 2018/3/9.
//  Copyright © 2018年 David. All rights reserved.
//
import UIKit

public struct DeviceDetector {
  
  static var isiPhoneX: Bool {
    get {
      if UIDevice().userInterfaceIdiom == .phone {
        if UIScreen.main.nativeBounds.height == 2436 {
          // iphone x's height
          return true
        }
      }
      
      return false
    }
  }
  
}
