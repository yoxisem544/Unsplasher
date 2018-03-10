//
//  PhotosBrowserInteractor.swift
//  Unsplasher
//
//  Created by David on 2018/3/10.
//  Copyright © 2018年 David. All rights reserved.
//

import PromiseKit

public protocol PhotosBrowserInteractorType {
  func fetchMorePhotos() -> Promise<()>
  var photos: [GetPhotoResult] { get }
}

final public class PhotosBrowserInteractor : PhotosBrowserInteractorType {
  
  let photoCache: PhotoCachingService
  
  public var photos: [GetPhotoResult] {
    get {
      switch photoCache.order {
      case .latest:
        return photoCache.latestPhotos
      case .popular:
        return photoCache.popularPhotos
      }
    }
  }
  
  public init(photoCache: PhotoCachingService) {
    self.photoCache = photoCache
  }
  
  public func fetchMorePhotos() -> Promise<()> {
    return photoCache.fetchNextPage()
  }
  
}
