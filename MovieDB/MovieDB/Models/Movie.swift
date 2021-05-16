//   //  Movie.swift
//  MovieDB
//
//  Created by Vikram Bisht on 5/15/21.
//

import Foundation


struct Movie:Codable  {
  let id:Int?
  let releaseDate:String? // release_date
  let title:String?
  let voteAverage:Float? //vote_average
  let overview:String?
  let runtime:Int?
  let genres:[Genre]?
  let posterPath:String?
  let backdropPath:String?
  var imagePosterUrl:URL? {
    return URL(string: "\(Urls.imageBaseUrl)\(posterPath ?? " ")")
  }
 
  enum CodingKeys:String,CodingKey {
    case id;
    case releaseDate = "release_date";
    case title;
    case voteAverage = "vote_average";
    case overview;
    case runtime;
    case genres;
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path";
    
  }
}

struct Genre:Codable {
  let id:Int?
  let name:String?
  
  enum CodingKeys:String,CodingKey {
    case id;
    case name;
  }
}

struct Result:Codable {
  let page:Int?
  let results:[Movie]?
  let totalPages:Int?
  let totalResults:Int?
  
  enum CodingKeys:String,CodingKey{
    case page;
    case results;
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}
struct Cast:Codable{
  let profilePath:String?
  let name:String?
  let character:String?
  
  enum CodingKeys:String,CodingKey{
    case profilePath = "profile_path"
    case name
    case character
  }
  
}

struct CastResponse:Codable{
  let id:Int?
  let cast:[Cast]?
  
  enum CodingKeys:String,CodingKey {
    case id
    case cast
  }
}
