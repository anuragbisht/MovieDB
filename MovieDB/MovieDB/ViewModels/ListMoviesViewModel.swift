//
//  ListMoviesModelView.swift
//  MovieDB
//
//  Created by Vikram Bisht on 5/15/21.
//

import Foundation

class ListMoviesViewModel {
  var refreshViewClosure:((Result)->()) = { _ in}
  var showAlertClosure:((String)->())?
  var service:Services
  var listOfMovies:[Movie]
  var pageCount:Int
  
  init(){
    service = Services();
    listOfMovies = []
    pageCount = 1;
  }
  
  func getListOfMovies(shouldPaginate:Bool){
    let url = "\(Urls.baseUrl)popular"
    if shouldPaginate {
      self.pageCount += 1
    }
    let params = ["page":self.pageCount.description] as [String : Any]
    service.fetchObject(getParams:params, url: url) {[weak self] errorDescription in
      //show popupin tthis block
      self?.showAlertClosure?(errorDescription);
    } successComplitionHandler: { [weak self](result:Result)  in
      //refresh view
      if self?.pageCount == 1{
        self?.listOfMovies = result.results ?? [];
      }else{
        self?.listOfMovies += result.results ?? []
      }
      self?.refreshViewClosure(result);
    }

  }
  
}
