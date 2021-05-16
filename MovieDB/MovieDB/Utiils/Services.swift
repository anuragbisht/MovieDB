//
//  Services.swift
//  MovieDB
//
//  Created by Vikram Bisht on 5/15/21.
//

import Foundation


class Services{
  
  func fetchObject<T:Codable>(getParams:[String:Any] = [:], url:String, failureComplitionHandler:@escaping (String)-> (), successComplitionHandler:@escaping (T)->()){
    var defaultParams:[String:Any] = ["api_key": Urls.apiKey,"language":Languages.english]
    var urlComponent = URLComponents(string: url);
    defaultParams.merge(getParams) { current, _ in current }
    urlComponent?.queryItems = []
    defaultParams.forEach { key, value in
      let queryItem = URLQueryItem(name: key, value: value as? String)
      urlComponent?.queryItems?.append(queryItem)
    }
    guard let sourceUrl = urlComponent?.url else {
      return
    }
    URLSession.shared.dataTask(with: sourceUrl){ data, response, error in
      if let err  = error{
        print(err.localizedDescription);
        DispatchQueue.main.async {
          failureComplitionHandler(err.localizedDescription)
        }
      }
      
      guard let dataRecieved  = data else {return };
      if let result = try? JSONDecoder().decode(T.self, from: dataRecieved){
        DispatchQueue.main.async {
          successComplitionHandler(result)
        }
      }
    }.resume();
  }

  
}




