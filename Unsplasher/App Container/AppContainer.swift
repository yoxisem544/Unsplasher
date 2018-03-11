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
  
  public var viewModel: AppContainerViewModel!
  
  public required init(photoBrowserViewController: PhotosBrowserViewController) {
    self.photoBrowserViewController = photoBrowserViewController
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private var photoBrowserViewController: PhotosBrowserViewController!
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    // Tab bar item styles
    photoBrowserViewController.tabBarItem = UITabBarItem(title: "Photos", image: #imageLiteral(resourceName: "Photos_icon"), selectedImage: #imageLiteral(resourceName: "Photos_icon"))
    
    // set vcs
    setViewControllers([photoBrowserViewController], animated: false)
  }
  
}
