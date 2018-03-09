//
//  AppContainerPresenter.swift
//  Unsplasher
//
//  Created by David on 2018/3/9.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation

public protocol AppContainerPresenterType {
  
}

final public class AppContainerPresenter : AppContainerPresenterType {
  private weak var view: AppContainerView?
  private let router: AppContainerRouterType
  private let interactor: AppContainerInteractorType
  
  required public init(view: AppContainerView,
                       router: AppContainerRouterType,
                       interactor: AppContainerInteractorType) {
    self.view = view
    self.router = router
    self.interactor = interactor
  }
  
}
