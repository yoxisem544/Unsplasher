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

final public class PhotosBrowserViewController: UIViewController, PhotosBrowserView, BindableType {
  
  private var navigationBar: UnsplasherNavigationBar!
  private var photoDisplayingView: PhotoDisplayView!
  
  public var viewModel: PhotosBrowserViewModel!
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    configuerNavigationBar()
    configurePhotoDisplayingView()
    
    viewModel.fetchMorePhotos().then(execute: {
      self.reloadPhotos(photos: self.viewModel.photos)
    })
  }
  
  func bindViewModel() {
    // do something
  }
  
  private func configuerNavigationBar() {
    navigationBar = UnsplasherNavigationBar()
    navigationBar.anchor(to: view)
    navigationBar.title = "yaaa"
    navigationBar.delegate = self
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

extension PhotosBrowserViewController : UnsplasherNavigationBarDelegate {
  
  public func changeViewModeButtonTapped(_ button: UIButton, mode: PhotoDisplayStyle) {
    photoDisplayingView.style = mode
  }
  
}
