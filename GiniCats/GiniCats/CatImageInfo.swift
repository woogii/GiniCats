//
//  CatImageInfo.swift
//  GiniCats
//
//  Created by siwook on 2017. 10. 15..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - SerializaionError : Error
enum SerializaionError: Error {
  case missing(String)
  case invalid(String, Any)
}

// MARK : - CatImageInfo
struct CatImageInfo {

  // MARK : - Property List
  var url: String
  var imageId: String
  var sourceUrl: String
  var isFavorite: Bool

  // MARK : - Initialization
  init(url: String?, imageId: String?, sourceUrl: String?, isFavorite: Bool) throws {
    guard let url = url else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.URLMissing)
    }
    guard let imageId = imageId else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.ImageIdMissing)
    }
    guard let sourceUrl = sourceUrl else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.SourceURLMissing)
    }
    self.url        = url
    self.imageId    = imageId
    self.sourceUrl  = sourceUrl
    self.isFavorite = isFavorite
  }
}
