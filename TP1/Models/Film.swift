//
//  Film.swift
//  TP1
//
//  Created by digital on 17/04/2023.
//

import Foundation


struct Film : Codable{
    let id : Int
    let title : String
    let subTitle : String
    let releaseYear : String
    let lenght : Int
    var categories : [String]
    let desc : String
    let visual : String
    var link : String
    
    
    init(from dtoFilm : DTOFilm){
        self.categories = []
        
        self.id = dtoFilm.id
        
        self.title = dtoFilm.title!
        if let sTitle = dtoFilm.tagline {
            self.subTitle = sTitle
        }else{
            self.subTitle = ""
        }
        if let year = dtoFilm.release_date{
            self.releaseYear = year
        }else{
            self.releaseYear = ""
        }
        if let durée = dtoFilm.runtime {
            self.lenght = durée
        }else{
            self.lenght = 0
        }
        if let summary = dtoFilm.overview {
            self.desc = summary
        }else{
            self.desc = ""
        }
        self.visual = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/" + dtoFilm.poster_path!
        
        
        if let videos = dtoFilm.videos, let key = videos.results.first?.key{
            self.link = "https://www.youtube.com/watch?v=\(key)"
        }else{
            self.link = ""
        }
        
        if let categories = dtoFilm.genres {
            categories.forEach{data in
                if let nom = data.name {
                    self.categories.append(nom)
                }
            }
        }
        

       

 

    }
}
