//
//  AppContainer.swift
//  Unsplasher
//
//  Created by David on 2018/3/9.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

public protocol AppContainerView: class {
  
}

final public class AppContainer: UITabBarController, AppContainerView {
  
  public var presenter: AppContainerPresenterType?
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    setViewControllers([generateEmptyVC()], animated: false)
  }
  
  func generateEmptyVC() -> UIViewController {
    // Code below is for testing purposes   // 5
    let emptyViewController = UIViewController()
    emptyViewController.view.backgroundColor = .cyan
    
    return emptyViewController
  }
  
}
