//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by Vikram Bisht on 5/16/21.
//

import Foundation

class MovieDetailViewModel {
  var refreshViewClosure:(()->())?
  var showAlertClosure:((String)->())?
  var service:Services
  var url:String
  var listOfCast:[Cast] = []
  var movie:Movie?
  var id:Int
  init(id:Int) {
    url = ""
    service = Services();
    self.id  = id;
  }
  
  func getDetailsOfMovie(){
    let url = "\(Urls.baseUrl)\(id)"
    service.fetchObject(url: url) { [weak self] errorDescription in
      
      //show popupin tthis block
      self?.showAlertClosure?(errorDescription);
    } successComplitionHandler: { [weak self](movie:Movie)  in
      //refresh view
      self?.movie = movie
      self?.refreshViewClosure?();
      
      
      
    }
  }
  
  func getCredits(){
    let url  = "\(Urls.baseUrl)\(id)/credits"
    service.fetchObject(url: url) { errorDescription in
      
      //show popupin tthis block
  
    } successComplitionHandler: { [weak self](castRes:CastResponse)  in
      //refresh view
      guard let casts = castRes.cast else {return}
      self?.listOfCast = casts
      self?.refreshViewClosure?();
    }
  }
  
  
}
