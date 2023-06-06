//
//  HomeView.swift
//  TP1
//
//  Created by digital on 17/04/2023.
//

import Foundation
import SwiftUI

struct HomeView: View {
    
    var body : some View{
        ScrollView(.vertical){
            LazyVGrid(columns: rows){
                ForEach(donneeTxt, id: \.title){ data in
                    VStack(){
                        ZStack(){
                            Color.gray.frame(height : 200)
                        }
                        Text(data.title)
                    }
                    
                    
                    
                }
                
                
            }
        }
    }
}
