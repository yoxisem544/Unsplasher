//
//  Scene+ViewController.swift
//  Unsplasher
//
//  Created by David on 2018/3/11.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

extension Scene {
  
  func viewController() -> UIViewController {
    switch self {
//    case .appContainer(let viewModel):
//      let appContainer = AppContainer(photoBrowserViewController: <#T##PhotosBrowserViewController#>)
    case .photoBrowser(let viewModel):
      var vc = PhotosBrowserViewController()
      vc.bindViewModel(to: viewModel)
      return vc
    default:
      fatalError()
    }
    
  }
  
}
