//
//  PhotosBrowserRouter.swift
//  Unsplasher
//
//  Created by David on 2018/3/10.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation
import UIKit

public protocol PhotosBrowserRouterType {
  
}

final public class PhotosBrowserRouter : PhotosBrowserRouterType {
  
  public weak var viewController: UIViewController?
  
  required public init(viewController: UIViewController) {
    self.viewController = viewController
  }
  
}
