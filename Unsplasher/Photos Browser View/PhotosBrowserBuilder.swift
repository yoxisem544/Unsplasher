//
//  PhotosBrowserBuilder.swift
//  Unsplasher
//
//  Created by David on 2018/3/10.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

public protocol PhotosBrowserBuilderType {
  func buildPhotoBrowserModule() -> UIViewController?
}

final public class PhotosBrowserBuilder : PhotosBrowserBuilderType {
  
  public func buildPhotoBrowserModule() -> UIViewController? {
    let view = PhotosBrowserViewController()
    
    let photoFetcher = GetPhotosService()
    let photoCache = PhotoCachingService(photoFetcher: photoFetcher)
    let interactor = PhotosBrowserInteractor(photoCache: photoCache)
    let router = PhotosBrowserRouter(viewController: view)
    let presenter = PhotosBrowserPresenter(view: view,
                                           router: router,
                                           interactor: interactor)
    
    view.presenter = presenter
    
    return view
  }
  
}
