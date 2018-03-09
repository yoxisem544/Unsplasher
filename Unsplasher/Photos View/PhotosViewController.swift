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
  private var photoDisplayingView: PhotoDisplayView!
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    configuerNavigationBar()
    configurePhotoDisplayingView()
  }
  
  private func configuerNavigationBar() {
    navigationBar = UnsplasherNavigationBar()
    navigationBar.anchor(to: view)
    navigationBar.title = "yaaa"
  }
  
  private func configurePhotoDisplayingView() {
    let height = view.bounds.height - navigationBar.bounds.height
    let width = view.bounds.width
    photoDisplayingView = PhotoDisplayView(height: height, width: width)
    photoDisplayingView.backgroundColor = .green
    photoDisplayingView.anchor(to: view, below: navigationBar)
    photoDisplayingView.move(0, pointBelow: navigationBar)
  }
  
}
