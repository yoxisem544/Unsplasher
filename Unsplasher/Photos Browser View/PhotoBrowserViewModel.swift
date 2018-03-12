//
//  PhotoBrowserViewModel.swift
//  Unsplasher
//
//  Created by David on 2018/3/11.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation
import PromiseKit

final public class PhotosBrowserViewModel {
  let photoCache: PhotoCachingServiceType
  let sceneCoordinator: SceneCoordinatorType
  
  public var photos: [PhotosViewModel] = []
  
  init(photoCache: PhotoCachingServiceType, coordinator: SceneCoordinatorType) {
    self.photoCache = photoCache
    self.sceneCoordinator = coordinator
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
  let author: String
  let username: String
  let authorAvatarURL: String?
  
  init(photoResult: GetPhotoResult) {
    photoURLs = photoResult.photo.urls
    photoSize = CGSize(width: photoResult.photo.width.cgFloat,
                       height: photoResult.photo.height.cgFloat)
    author = (photoResult.user.firstName ?? "") + " " + (photoResult.user.lastName ?? "")
    username = photoResult.user.username
    authorAvatarURL = photoResult.user.profileImage.small
  }
  
  public static func build(with photoResults: [GetPhotoResult]) -> [PhotosViewModel] {
    return photoResults.map(PhotosViewModel.init)
  }
}
