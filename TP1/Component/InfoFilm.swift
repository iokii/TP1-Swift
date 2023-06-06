//
//  infoFilm.swift
//  TP1
//
//  Created by digital on 17/04/2023.
//

import Foundation
import SwiftUI

struct InfoFilm: View {
    
    var idMovie:Int
    @State private var movie : Film?
    @EnvironmentObject var viewModel : MovieViewModel

    
    init(movie : Int){
        self.idMovie = movie
    }
    
    
    var body: some View {
        ScrollView{
            if let movie = movie {
                Spacer(minLength: 50)
                Text(movie.title).bold().font(.title).foregroundColor(Color.white)
                VStack{
                    if let url = URL(string:"https://www.youtube.com/watch?v=\(movie.link)"), movie.link != "" {
                            Link(destination: url){
                                AsyncImage(url: URL(string: movie.visual),content : {
                                image in
                                if let img = image.image {
                                    img.resizable().aspectRatio(contentMode: .fit).frame(height: 250)
                                }else{
                                    Color.gray.frame(width: 150,height: 250)
                                }
                            })
                        }
                    }else{
                        AsyncImage(url: URL(string: movie.visual),content : {
                        image in
                        if let img = image.image {
                            img.resizable().aspectRatio(contentMode: .fit).frame(height: 250)
                        }else{
                            Color.gray.frame(width: 150,height: 250)
                        }
                    })
                    }
                                
                        
                        

                    
                    Text(movie.releaseYear.prefix(4)).font(.caption).foregroundColor(Color.white)
                    Spacer(minLength: 10)
                    Text(movie.subTitle).italic().font(.title2).foregroundColor(Color.white)
                    ScrollView(.horizontal){
                        HStack(){
                            ForEach(movie.categories,id : \.self){
                                cat in
                                ZStack{
                                    Color.blue.frame(width: 110,height: 25).cornerRadius(10)
                                    Text(cat)
                                        .foregroundColor(Color.white)
                                    
                                }
                                
                            }
                        }
                    }
                    Text("RESUME").foregroundColor(Color.white).frame(alignment: .leading)
                    Text(movie.desc).foregroundColor(Color.white).multilineTextAlignment(.center)
                    Spacer(minLength: 30)
                    HStack{
                        Text("LENGHT").foregroundColor(Color.white)
                        Text(": \(movie.lenght) min ").foregroundColor(Color.white)
                    }
                    
                }
            } else {
                ProgressView()
            }
            
        }.frame(width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height).background(Color.black)
            .onAppear{
                viewModel.fetchMovie(id: idMovie){
                    fetched in
                    movie = fetched
                }
            }
    }
    
    
    
}
