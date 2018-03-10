//
//  FetchPhotoService.swift
//  Unsplasher
//
//  Created by David on 2018/3/10.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation
import PromiseKit

public protocol PhotoCachingServiceType {
  var order: PhotoOrderType { get set }
  var latestPhotos: [GetPhotoResult] { get set }
  var popularPhotos: [GetPhotoResult] { get set }
  var currentLatestPhotosPage: Int { get set }
  var currentPopularPhotosPage: Int { get set }
  func fetchNextPage() -> Promise<()>
  func refreshContent() -> Promise<()>
}

/// FetchPhotoService
///
/// Do the job to fetch photo, cache page, image
final public class PhotoCachingService : PhotoCachingServiceType {
  
  public var currentLatestPhotosPage: Int = 0
  public var currentPopularPhotosPage: Int = 0
  public var order: PhotoOrderType = .latest
  public var latestPhotos: [GetPhotoResult] = []
  public var popularPhotos: [GetPhotoResult] = []
  
  
  private let photoFetcher: GetPhotosServiceType
  
  init(photoFetcher: GetPhotosServiceType) {
    self.photoFetcher = photoFetcher
  }
  
  public func fetchNextPage() -> Promise<()> {
    switch order {
    case .latest:
      currentLatestPhotosPage += 1
      return photoFetcher
        .perform(page: currentLatestPhotosPage, order: order)
        .then(execute: { [weak self] results in
          self?.latestPhotos.append(contentsOf: results)
          return Promise<Void>()
        })
    case .popular:
      currentPopularPhotosPage += 1
      return photoFetcher
        .perform(page: currentPopularPhotosPage, order: order)
        .then(execute: { [weak self] results in
          self?.popularPhotos.append(contentsOf: results)
          return Promise<Void>()
        })
    }
  }
  
  public func refreshContent() -> Promise<()> {
    switch order {
    case .latest: currentLatestPhotosPage = 0
    case .popular: currentPopularPhotosPage = 0
    }
    return fetchNextPage()
  }
  
}
