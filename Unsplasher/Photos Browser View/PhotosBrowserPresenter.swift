//
//  PhotosBrowserPresenter.swift
//  Unsplasher
//
//  Created by David on 2018/3/10.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation

public protocol PhotosBrowserPresenterType {
  
}

final public class PhotosBrowserPresenter : PhotosBrowserPresenterType {
  private weak var view: PhotosBrowserViewController?
  private let router: PhotosBrowserRouter
  private let interactor: PhotosBrowserInteractor
  
  required public init(view: PhotosBrowserViewController,
                       router: PhotosBrowserRouter,
                       interactor: PhotosBrowserInteractor) {
    self.view = view
    self.router = router
    self.interactor = interactor
  }
  
}
