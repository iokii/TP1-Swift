//
//  Categories.swift
//  TP1
//
//  Created by digital on 17/04/2023.
//

import Foundation


struct Categories : Codable,Identifiable,Hashable{
    let id : Int
    let name : String?
    
    init(from dtoCat: DTOCategorie ) {
        self.id = dtoCat.id
        
        if let sname = dtoCat.name{
            self.name = sname
        }else{
            self.name = ""
        }
    }
    
    init(id:Int,name:String) {
        self.id = id
        self.name = name
    }
}
