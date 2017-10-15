//
//  RestClient.swift
//  GiniCats
//
//  Created by siwook on 2017. 10. 15..
//  Copyright © 2017년 siwook. All rights reserved.
//

import SWXMLHash

// MARK : - RestClient
struct RestClient {

  // MARK : - Type Alias List
  typealias RequestResult = (_ result: XMLIndexer?, _ error: Error?) -> Void

  // MARK : - URLSession Task For Resource
  func taskForResource(with url: URL, completionHanlder: @escaping RequestResult) {
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completionHanlder(nil, error)
      } else {
        guard let data = data, let httpResponse = response as? HTTPURLResponse,
          200..<300 ~= httpResponse.statusCode else {
            return
        }
        // XML Parsing by using SWXMLHash
        let xml = SWXMLHash.parse(data)
        completionHanlder(xml, nil)
      }
      }.resume()
  }
}
