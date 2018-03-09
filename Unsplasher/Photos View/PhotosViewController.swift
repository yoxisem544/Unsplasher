//
//  PhotosViewController.swift
//  Unsplasher
//
//  Created by David on 2018/3/9.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

final public class PhotosViewController: UIViewController {
  
  private var navigationBar: UnsplasherNavigationBar!
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    configuerNavigationBar()
  }
  
  private func configuerNavigationBar() {
    navigationBar = UnsplasherNavigationBar()
    navigationBar.anchor(to: view)
    navigationBar.title = "yaaa"
  }
  
}
