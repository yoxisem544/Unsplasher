//
//  SearchUsers.swift
//  Unsplasher
//
//  Created by David on 2018/3/10.
//  Copyright © 2018年 David. All rights reserved.
//

import NetworkRequestKit
import Alamofire
import PromiseKit
import SwiftyJSON

final public class SearchUsers: NetworkRequest, PagingEnabledRequest {
  public typealias ResponseType = SearchUserResultsWithTotalPages
  
  public var endpoint: String { return "search/users" }
  public var method: HTTPMethod { return .get }
  public var parameters: [String : Any]? {
    return [
      "query": query
    ].merged(with: pagingParameters)
  }
  
  private var query: String = ""
  public var page: Int = 1
  public var perPage: Int = 2
  
  public func perform(query: String = "", page: Int = 1) -> Promise<ResponseType> {
    self.page = page
    self.query = query
    return networkClient.performRequest(self).then(execute: responseHandler)
  }
  
  
}
