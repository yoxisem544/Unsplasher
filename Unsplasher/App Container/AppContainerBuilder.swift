//
//  AppContainerBuilder.swift
//  Unsplasher
//
//  Created by David on 2018/3/9.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

public protocol AppContainerBuilderType {
  func buildContainer() -> UIViewController?
}

final public class AppContainerBuilder : AppContainerBuilderType {
  
  public func buildContainer() -> UIViewController? {
    let photosBrowserModule = PhotosBrowserViewController()
    let getPhoto = GetPhotosService()
    let photoCacheService = PhotoCachingService(photoFetcher: getPhoto)
    photosBrowserModule.viewModel = PhotosBrowserViewModel(photoCache: photoCacheService)
    
    let view = AppContainer(photoBrowserViewController: photosBrowserModule)
    
    let interactor = AppContainerInteractor()
    let router = AppContainerRouter(viewController: view)
    let presenter = AppContainerPresenter(view: view,
                                          router: router,
                                          interactor: interactor)
    
    view.presenter = presenter
    
    return view
  }
  
}
