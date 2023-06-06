//
//  ContentView.swift
//  TP1
//
//  Created by digital on 04/04/2023.
//

import SwiftUI


struct ContentView: View {
    
    

    @State private var page = 1
    @State private var selectCat : Categories?
    @State private var selectFilter : String = "now_playing"
    @EnvironmentObject var viewModel : MovieViewModel

    
    let rows : [GridItem] = [
        GridItem(.fixed(150), spacing: 40),
        GridItem(.fixed(150), spacing: 40),
    ]

    
    var body: some View {

        
        
        NavigationView{
            VStack{
                HStack{
                    Text("MOVIE").foregroundColor(Color.white).background(Color.black).font(.largeTitle).bold().underline()
                    Spacer(minLength: 5)
                    Picker("FILTER", selection: $selectFilter) {
                        Text("NOWPLAYING").tag("now_playing")
                        Text("POPULAR").tag("popular")
                        Text("TOPRATED").tag("top_rated")
                        Text("UPCOMING").tag("upcoming")
                    }.pickerStyle(MenuPickerStyle())
                    .onChange(of: selectFilter){filter in
                        page = 1
                        viewModel.fetchHomePage(page: page, filter: filter)
                        
                    }
                    Picker("Categories", selection: $selectCat) {
                        Text("ALLCATEGORIES").tag(Categories(id: -1, name: "All Categories") as Categories?)
                        ForEach(viewModel.categories) { cat in
                            Text(cat.name ?? "").tag(cat as Categories?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onChange(of: selectCat) { genre in

                        if let genre = genre, genre.id != -1 {
                            viewModel.fetchMoviesByGenres(cat:genre,page : 1)
                        } else {

                            viewModel.fetchHomePage(page: page, filter: selectFilter)

                        }
                    }
                }
                ScrollView(.vertical){
                    LazyVGrid(columns: rows){
                        ForEach(viewModel.movies, id: \.title){ data in
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
                if page != 1 {
                    Button(action: {
                        page -= 1
                        viewModel.fetchHomePage(page: page,filter: "now_playing")
                    }){
                        Text("PAGEPREC")
                    }
                }
                Button(action: {
                    page += 1
                    
                    viewModel.fetchHomePage(page: page,filter: "now_playing")
                }){
                    Text("PAGENEXT")
                }
            }.background(Color.black)

        }.onAppear{

            viewModel.fetchHomePage(page: page, filter: "now_playing")
            viewModel.fetchCat()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    
    
    
    static var previews: some View {
        
        let viewModels = MovieViewModel()
        
        viewModels.movies = []
        
        
        return ContentView().environmentObject(viewModels)
    }
}
