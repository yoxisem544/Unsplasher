//
//  PhotosBrowserPresenter.swift
//  Unsplasher
//
//  Created by David on 2018/3/10.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation

public protocol PhotosBrowserPresenterType {
  func loadMorePhotos()
}

final public class PhotosBrowserPresenter : PhotosBrowserPresenterType {
  private weak var view: PhotosBrowserView?
  private let router: PhotosBrowserRouter
  private let interactor: PhotosBrowserInteractor
  
  required public init(view: PhotosBrowserView,
                       router: PhotosBrowserRouter,
                       interactor: PhotosBrowserInteractor) {
    self.view = view
    self.router = router
    self.interactor = interactor
  }
  
  public func loadMorePhotos() {
    interactor.fetchMorePhotos()
      .then(execute: { [weak self] _ -> Void in
        if let photos = self?.interactor.photos {
          let viewModels = PhotosViewModel.build(with: photos)
          self?.view?.reloadPhotos(photos: viewModels)
        }
      })
  }
  
}

public struct PhotosViewModel {
  
  let photoURLs: UnsplashPhotoURLs
  
  init(photoResult: GetPhotoResult) {
    photoURLs = photoResult.photo.urls
  }
  
  public static func build(with photoResults: [GetPhotoResult]) -> [PhotosViewModel] {
    return photoResults.map(PhotosViewModel.init)
  }
}
