//
//  Film.swift
//  TP1
//
//  Created by digital on 17/04/2023.
//

import Foundation


struct DTOFilm: Codable {
    let adult: Bool?
    let backdrop_path: String?
    let budget: Int?
    let belongs_to_collection: DTOBelongsToCollection?
    let genres: [DTOCategorie]?
    let homepage: String?
    let id: Int
    let imdb_id: String?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let popularity: Double?
    let poster_path: String?
    let production_companies: [DTOCompanies]?
    let production_countries: [DTOCountries]?
    let release_date: String?
    let revenue: Int?
    let runtime: Int?
    let spoken_languages: [DTOLanguage]?
    let status: String?
    let tagline: String?
    let title: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
    let videos : DTOTrailer?
}





 









