//
//  DTOFilmList.swift
//  TP1
//
//  Created by digital on 17/04/2023.
//

import Foundation


struct DTOFilmList : Codable {
    let page : Int?
    let dates : DTODatesFilm?
    let results : [DTOFilm]
    let total_pages : Int?
    let total_results : Int?
    
}
