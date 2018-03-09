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
    
    let pVC = PhotosViewController()
    pVC.tabBarItem = UITabBarItem(title: "Photos", image: #imageLiteral(resourceName: "Photos_icon"), selectedImage: #imageLiteral(resourceName: "Photos_icon"))
    
    let pVC2 = PhotosViewController()
    pVC2.tabBarItem = UITabBarItem(title: "Photos2", image: #imageLiteral(resourceName: "Photos_icon"), selectedImage: #imageLiteral(resourceName: "Photos_icon"))
    
    setViewControllers([pVC, pVC2], animated: false)
  }
  
  func generateEmptyVC() -> UIViewController {
    // Code below is for testing purposes   // 5
    let emptyViewController = UIViewController()
    emptyViewController.view.backgroundColor = .cyan
    
    return emptyViewController
  }
  
}
