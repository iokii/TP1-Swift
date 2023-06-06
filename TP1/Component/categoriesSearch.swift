//
//  categoriesSearch.swift
//  TP1
//
//  Created by digital on 22/05/2023.
//

import Foundation
import SwiftUI

struct categoriesSearch: View {
    
    @State private var movies : [Film] = []
    
    let rows : [GridItem] = [
        GridItem(.fixed(150), spacing: 40),
        GridItem(.fixed(150), spacing: 40),
    ]
    
    init(movies: [Film]) {
        self.movies = movies
    }

    var body: some View {

        
        
        NavigationView{
            VStack{

                Text("Categories").foregroundColor(Color.white).background(Color.black).font(.largeTitle).bold().underline()
                ScrollView(.vertical){
                    LazyVGrid(columns: rows){
                        ForEach(movies, id: \.title){ data in
                            NavigationLink(destination: InfoFilm(movie: data.id)){
                                VStack{
                                    AsyncImage(url: URL(string: data.visual),content : {
                                        image in
                                        if let img = image.image {
                                            img.resizable().aspectRatio(contentMode: .fit).frame(height: 250)
                                            
                                        }else{
                                            
                                            Color.gray.frame(height: 250)
                                            
                                        }
                                    })
                                    Text(data.title).foregroundColor(Color.white)
                                }
                                
                            }
                        }
                    }
              }
            }.background(Color.black)

        }.task {
            do {

                let data = try await balekouil(url: "https://api.themoviedb.org/3/movie/now_playing?api_key=9a8f7a5168ace33d2334ba1fe14a83fb&language=fr-FR&append_to_response=videos")
                let DTOfilmList : DTOFilmList = try JSONDecoder().decode(DTOFilmList.self, from: data)
                print(DTOfilmList)
                
                if let list = DTOfilmList.results{
                    list.forEach{
                        data in
                        self.movies.append(Film(dtoFilm: data))
                    }
                    
                }
            }
            catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
}

