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
    case .appContainer(let viewModel):
      // build photo broswer
      let fetcher = GetPhotosService()
      let photoCache = PhotoCachingService(photoFetcher: fetcher)
      let photoBrowserViewModel = PhotosBrowserViewModel(photoCache: photoCache,
                                                         coordinator: viewModel.sceneCoordinator)
      let photoBrowserScene = Scene.photoBrowser(photoBrowserViewModel)
      let photoVC = photoBrowserScene.viewController() as! PhotosBrowserViewController
      
      // build app container
      var appContainer = AppContainer(photoBrowserViewController: photoVC)
      appContainer.bindViewModel(to: viewModel)
      
      return appContainer
    case .photoBrowser(let viewModel):
      var vc = PhotosBrowserViewController()
      vc.bindViewModel(to: viewModel)
      return vc
    }
    
  }
  
}
