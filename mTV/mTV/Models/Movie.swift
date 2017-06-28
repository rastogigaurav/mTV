//
//  Movie.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/21/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit

class Movie:NSObject {
    
    var budget:Int?
    var genres:[Genre] =
        []
    var homepage:String?
    var imdbId:String?
    var productionCompanies:[ProductionCompany] = []
    var productionCountries:[ProductionCountry] = []
    var revenue:Int?
    var runtime:Int?
    var spokenLanguages:[Language] = []
    var status:String?
    var tagline:String?
    
    var releaseYear:Int{
        get{
            if let rDate = releaseDate{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let date = dateFormatter.date(from: rDate)
                
                let calendar = Calendar.autoupdatingCurrent
                let components = calendar.dateComponents([.year,.month,.day], from: date!)
                return components.year!
            }
            return 0
        }
    }
    
    var voteCount:Int?
    var id:Int?
    var video:Bool = false
    var voteAverage:Float?
    var title:String?
    var popularity:Float?
    var posterPath:String?
    
    var originalLanguage:String?
    var originalTitle:String?
    var backdropPath:String?
    var adult:Bool = false
    var overview:String?
    var releaseDate:String?
    
    required init(json:Dictionary<String, Any>) {
        if let value = (json["budget"] as AnyObject).integerValue{
            budget = value
        }
        
        if let genres = (json["genres"] as? [Dictionary<String,Any>]){
            for obj:Dictionary<String,Any> in genres{
                let genre:Genre = Genre(gID: obj["id"] as! Int, gName: obj["name"] as! String)
                self.genres.append(genre)
            }
        }
        
        if let value = (json["homepage"] as? String){
            homepage = value
        }

        if let value = (json["imdb_id"] as? String){
            imdbId = value
        }
        
        if let companies = (json["production_companies"] as? [Dictionary<String,Any>]){
            for obj in companies{
                let company:ProductionCompany = ProductionCompany(pID: obj["id"] as! Int, pName: obj["name"] as! String)
                self.productionCompanies.append(company)
            }
        }
        
        if let countries = (json["production_countries"] as? [Dictionary<String,Any>]){
            for obj in countries{
                let country:ProductionCountry = ProductionCountry(iso: obj["iso_3166_1"] as! String, pcName: obj["name"] as! String)
                self.productionCountries.append(country)
            }
        }
        
        
        if let value = (json["revenue"] as AnyObject).integerValue{
            revenue = value
        }
        
        if let value = (json["runtime"] as AnyObject).integerValue{
            runtime = value
        }
        
        if let languages = (json["spoken_languages"] as? [Dictionary<String,Any>]){
            for obj in languages{
                let language:Language = Language(iso: obj["iso_639_1"] as! String, lName: obj["name"] as! String)
                self.spokenLanguages.append(language)
            }
        }
        
        if let value = (json["status"] as? String){
            status = value
        }
        
        if let value = (json["tagline"] as? String){
            tagline = value
        }
        
        if let value = (json["vote_count"] as AnyObject).integerValue{
            voteCount = value
        }
        
        if let value = (json["id"] as AnyObject).integerValue{
            id = value
        }
        
        if let value = (json["video"] as AnyObject).boolValue{
            video = value
        }
        
        if let value = (json["vote_average"] as AnyObject).floatValue{
            voteAverage = value
        }
        
        if let value = (json["title"] as? String){
            title = value
        }
        
        if let value = (json["popularity"] as AnyObject).floatValue{
            popularity = value
        }
        
        if let value = (json["poster_path"] as? String){
            posterPath = value
        }
        
        if let value = (json["original_language"] as? String){
            originalLanguage = value
        }
        
        if let value = (json["original_title"] as? String){
            originalTitle = value
        }
        
        if let value = (json["backdrop_path"] as? String){
            backdropPath = value
        }
        
        if let value = (json["adult"] as AnyObject).boolValue{
            adult = value
        }
        
        if let value = (json["overview"] as? String){
            overview = value
        }
        
        if let value = (json["release_date"] as? String){
            releaseDate = value
        }
    }
    
    func posterPathURL()->String?{
        if let path = posterPath{
            return imageBaseUrl + "p/w300_and_h450_bestv2/" + path
        }
        return nil
    }
}
