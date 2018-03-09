//
//  AppContainerRouter.swift
//  Unsplasher
//
//  Created by David on 2018/3/9.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

public protocol AppContainerRouterType {
  
}

final public class AppContainerRouter : AppContainerRouterType {
  
  public weak var viewController: UIViewController?
  
  required public init(viewController: UIViewController) {
    self.viewController = viewController
  }
  
}
