//
//  SceneTransitionType.swift
//  Unsplasher
//
//  Created by David on 2018/3/10.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation

enum SceneTransitionType {
  // you can extend this to add animated transition types.
  // interactive transitions and even child view controllers
  
  case root       // make view controller the root view controller
  case push       // push view controller to navigation stack
  case modal      // present view controller modally
}
