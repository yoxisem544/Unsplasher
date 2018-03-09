//
//  DefaultKeys.swift
//  Unsplasher
//
//  Created by David on 2018/3/9.
//  Copyright © 2018年 David. All rights reserved.
//

import SwiftyUserDefaults

fileprivate let identifier = "io.hello.unsplasher"

extension DefaultsKeys {

  static let accessToken = DefaultsKey<String?>("\(identifier).user.accesstoken")
  
}
