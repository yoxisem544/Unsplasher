//
//  GetPhotos.swift
//  Unsplasher
//
//  Created by David on 2018/3/9.
//  Copyright © 2018年 David. All rights reserved.
//

import NetworkRequestKit
import Alamofire
import PromiseKit
import SwiftyJSON

public enum PhotoOrderType: String {
  case latest, popular
}

public protocol GetPhotosService {
  func perform(page: Int, order: PhotoOrderType) -> Promise<[GetPhotoResult]>
}

final public class GetPhotos : NetworkRequest, PagingEnabledRequest, GetPhotosService {
  public typealias ResponseType = [GetPhotoResult]
  public var page: Int = 1
  public var order: PhotoOrderType = .latest
  
  public var endpoint: String { return "photos" }
  public var method: HTTPMethod { return .get }
  
  public var parameters: [String : Any]? {
    return [
      "order_by": order.rawValue
    ]
    .merged(with: pagingParameters)
    .merged(with: ["client_id": SecretKeys.unsplashAppID])
  }
  
  
  public func perform(page: Int, order: PhotoOrderType) -> Promise<[GetPhotoResult]> {
    self.page = page
    self.order = order
    return networkClient.performRequest(self).then(execute: responseHandler)
  }
  
}
