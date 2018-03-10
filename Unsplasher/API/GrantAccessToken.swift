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

final public class GrantAccessToken : NetworkRequest {
  public typealias ResponseType = UnsplashOAuthData
  
  // Auth code
  private var code: String = ""
  
  public var baseURL: String { return UnsplashAuthAPI.baseURL }
  public var endpoint: String { return "token" }
  public var method: HTTPMethod { return .post }
  public var parameters: [String : Any]? {
    return [
      "client_id": SecretKeys.unsplashAppID,
      "client_secret": SecretKeys.unsplashAppSecret,
      "redirect_uri": UnsplashAuthAPI.redirectURI,
      "code": code,
      "grant_type": "authorization_code",
    ]
  }
  
  public func performAuthencation(with code: String) -> Promise<ResponseType> {
    self.code = code
    return networkClient.performRequest(self).then(execute: responseHandler)
  }
  
}
