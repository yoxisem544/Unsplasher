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

final public class GetPhotos : NetworkRequest, PagingEnabledRequest {
  public typealias ResponseType = RawJSONResult
  public var page: Int = 1
  
  public var endpoint: String { return "photos" }
  public var method: HTTPMethod { return .get }
  
  public var parameters: [String : Any]? {
    return [
      "order_by": "latest"
    ]
    .merged(with: pagingParameters)
    .merged(with: ["client_id": SecretKeys.unsplashAppID])
  }
  
  public func perform(page: Int) -> Promise<ResponseType> {
    self.page = page
    return networkClient.performRequest(self).then(execute: responseHandler)
  }
  
}
