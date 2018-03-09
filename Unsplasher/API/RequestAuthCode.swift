//
//  RequestAuthCode.swift
//  Unsplasher
//
//  Created by David on 2018/3/9.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

final public class RequestAuthCode {
  
  public func perform(scopes: [UnsplashAPIPermissionScope]) {
    let joinedScoped = UnsplashAPIPermissionScope.join(scopes: scopes)
    let url = "\(UnsplashAuthAPI.baseURL)authorize?client_id=\(SecretKeys.unsplashAppID)&redirect_uri=\(UnsplashAuthAPI.redirectURI)&response_type=code&scope=\(joinedScoped)".url!

    UIApplication.shared.open(url, options: [:])
  }
  
}
