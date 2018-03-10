//
//  PhotosBrowserViewController.swift
//  Unsplasher
//
//  Created by David on 2018/3/9.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

public protocol PhotosBrowserView: class {
  func reloadPhotos(photos: [PhotosViewModel])
}

final public class PhotosBrowserViewController: UIViewController, PhotosBrowserView {
  
  private var navigationBar: UnsplasherNavigationBar!
  private var photoDisplayingView: PhotoDisplayView!
  
  public var presenter: PhotosBrowserPresenterType?
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    configuerNavigationBar()
    configurePhotoDisplayingView()
    
    presenter?.loadMorePhotos()
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
  
  public func reloadPhotos(photos: [PhotosViewModel]) {
    photoDisplayingView.photos = photos
  }
  
}
