//
//  AuthUser.swift
//  Unsplasher
//
//  Created by David on 2018/3/9.
//  Copyright © 2018年 David. All rights reserved.
//

import NetworkRequestKit
import Alamofire
import PromiseKit
import SwiftyJSON

public struct AuthUser : NetworkRequest {
  public typealias ResponseType = RawJSONResult
  
  public var baseURL: String { return "https://unsplash.com/oauth/" }
  public var endpoint: String { return "authorize" }
  public var method: HTTPMethod { return .get }
  public var parameters: [String : Any]? {
    return [
      "client_id": SecretKeys.unsplashAppID,
      "redirect_uri": "",
      "response_type": "code",
      "scope": UnsplashAPIPermissionScope.allScopes,
    ]
  }
  
  public func performRequest() -> Promise<Data> {
    return networkClient.performRequest(self)
  }
  
}
