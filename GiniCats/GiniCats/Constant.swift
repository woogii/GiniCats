//
//  Constant.swift
//  GiniCats
//
//  Created by siwook on 2017. 10. 15..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit

// MARK : - Constants
struct Constants {

  // MARK : - API
  struct API {

    static let BaseURL = "http://thecatapi.com/api"

    // MARK : - API Method List
    struct Methods {
      static let GetImages     = "/images/get"
      static let GetFavourites = "/images/getfavourites"
      static let FavoriteImage = "/images/favorite"
    }

    // MARK : - URL Query List
    struct QueryItem {
      static let FormatKey           = "format"
      static let FormatValue         = "xml"
      static let ResultsPerPageKey   = "results_per_page"
      static let ResultsPerPageValue = "20"
      static let SubIdKey            = "sub_id"
      static let SubIdValue          = "siwook"
      static let ActionKey           = "action"
      static let ActionValue         = "remove"
      static let APIKey              = "api_key"
      static let APIValue            = Secret.APIValue
      static let ImageIdKey          = "image_id"
      static let SizeKey             = "size"
      static let SizeValue           = "small"
    }

    // MARK : - XML Parsing Key List
    struct XMLParsingKeys {
      static let Response  = "response"
      static let Data      = "data"
      static let Url       = "url"
      static let ImageId   = "id"
      static let SubId     = "sub_id"
      static let Created   = "created"
      static let SourceUrl = "source_url"
      static let Images    = "images"
      static let Image     = "image"
      static let ApiError  = "apierror"
      static let Message   = "message"
    }
  }

  // MARK : - Fatal Error
  struct FatalError {
    static let UnExpectedCollectionViewCell = "Unexpected Collection View Cell"
  }

  // MARK : - Cell Identification
  struct CellID {
    static let CatImage         = "catImageCollectionViewCell"
  }

  // MARK : - Serializaion Error Description
  struct SerializaionErrorDesc {
    static let URLMissing         = "URL is missing"
    static let ImageIdMissing     = "Image Id is missing"
    static let UserIdMissing      = "User Id is missing"
    static let CreatedTimeMissing = "Created Time is missing"
    static let SourceURLMissing   = "Source URL is missing"
  }
}
