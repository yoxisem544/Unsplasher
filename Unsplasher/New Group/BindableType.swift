//
//  BindableType.swift
//  Unsplasher
//
//  Created by David on 2018/3/11.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

protocol BindableType {
  associatedtype ViewModelType
  
  // type ViewModelType will be defined later in the code
  var viewModel: ViewModelType! { get set }
  
  // where you should bind your observer
  func bindViewModel()
}

extension BindableType where Self: UIViewController {
  
  // bindViewModel(to:) will be called while binding to vc when coordinator is about to transit scene
  mutating func bindViewModel(to model: Self.ViewModelType) {
    viewModel = model
    loadViewIfNeeded()
    bindViewModel()
  }
}
