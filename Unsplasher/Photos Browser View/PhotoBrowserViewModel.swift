//
//  PhotoBrowserViewModel.swift
//  Unsplasher
//
//  Created by David on 2018/3/11.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation
import PromiseKit

public protocol PhotosBrowserViewModelType: class {
  func fetchMorePhotos() -> Promise<()>
  var photos: [PhotosViewModel] { get set }
}

public class PhotosBrowserViewModel: PhotosBrowserViewModelType {
  let photoCache: PhotoCachingServiceType
  
  public var photos: [PhotosViewModel] = []
  
  init(photoCache: PhotoCachingServiceType) {
    self.photoCache = photoCache
  }
  
  public func fetchMorePhotos() -> Promise<()> {
    return photoCache.fetchNextPage().then(execute: { _ -> Void in
      switch self.photoCache.order {
      case .latest:
        self.photos = PhotosViewModel.build(with: self.photoCache.latestPhotos)
      case .popular:
        self.photos = PhotosViewModel.build(with: self.photoCache.popularPhotos)
      }
    })
  }
}


public struct PhotosViewModel {
  
  let photoURLs: UnsplashPhotoURLs
  let photoSize: CGSize
  
  init(photoResult: GetPhotoResult) {
    photoURLs = photoResult.photo.urls
    photoSize = CGSize(width: photoResult.photo.width.cgFloat,
                       height: photoResult.photo.height.cgFloat)
  }
  
  public static func build(with photoResults: [GetPhotoResult]) -> [PhotosViewModel] {
    return photoResults.map(PhotosViewModel.init)
  }
}
