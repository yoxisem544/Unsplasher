//
//  SceneCoordinatorType.swift
//  Unsplasher
//
//  Created by David on 2018/3/10.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit
import RxSwift

protocol SceneCoordinatorType {
  /// need to have a root window when setup
  init(window: UIWindow)
  
  /// transition to another scene, push or present
  @discardableResult
  func transition(to scene: Scene, type: SceneTransitionType) -> Observable<Void>
  
  // pop scene from navigation stack or dismiss current modal
  @discardableResult
  func pop(animated: Bool) -> Observable<Void>
}

// default implementation
extension SceneCoordinatorType {
  
  @discardableResult
  func pop() -> Observable<Void> {
    return pop(animated: true)
  }
  
}
