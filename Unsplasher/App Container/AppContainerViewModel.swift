//
//  AppContainerViewModel.swift
//  Unsplasher
//
//  Created by David on 2018/3/11.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation

public struct AppContainerViewModel {
  
  let sceneCoordinator: SceneCoordinatorType
  
  init(coordinator: SceneCoordinatorType) {
    self.sceneCoordinator = coordinator
  }
  
}
