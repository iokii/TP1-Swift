//
//  movieViewModel.swift
//  TP1
//
//  Created by digital on 22/05/2023.
//

import Foundation
import SwiftUI



class MovieViewModel:ObservableObject{
    
    @Published var movies : [Film] = []
    @Published var categories : [Categories] = []
    
    let baseURL = "https://api.themoviedb.org/3/movie/"
     
    let baseCatURL = "https://api.themoviedb.org/3/discover/movie"
    
    let CatURL = "https://api.themoviedb.org/3/genre/movie/list"
    
    let api_key = "api_key=9a8f7a5168ace33d2334ba1fe14a83fb"
    
    let URLlanguage = "language=" + Locale.preferredLanguages[0]
    
    let videosURL = "append_to_response=videos"
    
    
    private func fetchMovieList(urlString: String){
        self.movies = []
        
        guard let url = URL(string: urlString) else{
            print("noURL")
            return
        }

        let tesk = URLSession.shared.dataTask(with: url) { ndata,response,error in
            guard let data = ndata else{
                print("Error query data")
                return
            }
                let decoder = JSONDecoder()
                do {
                    let decoded = try decoder.decode(DTOFilmList.self, from: data)
                    DispatchQueue.main.async {
                        decoded.results.forEach{ movie in
                            self.movies.append(Film(from: movie))
                        }
                    }
                } catch{
                    
                    print("fail decode")
                }
            
        }
        tesk.resume()
    }
    
    
    func fetchHomePage(page : Int,filter : String){
        let URL = baseURL+filter+"?"+api_key+"&"+URLlanguage+"&"+videosURL+"&page=\(page)"
        self.fetchMovieList(urlString: URL)
    }
    
    func fetchMoviesByGenres(cat:Categories,page : Int){
        let sCat = cat.id
        let URL = "\(baseCatURL)?\(api_key)&\(URLlanguage)&with_genres=\(sCat)&page=\(page)"
        self.fetchMovieList(urlString: URL)
    }
    
    func fetchCat(){
        let bURL = "\(CatURL)?\(api_key)&\(URLlanguage)"
        
        guard let url = URL(string: bURL) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else{
                print("Error query data")
                return
            }
            let decoder = JSONDecoder()
                do{
                    let decode = try decoder.decode(DTOCategories.self, from: data)
                    DispatchQueue.main.async {
                        decode.genres.forEach{catDTO in
                            self.categories.append(Categories(from: catDTO))
                        }
                        
                    }
                    
                }catch{
                    print("fail decode")
                }
                
            
            
            
        }
        task.resume()
        
    }
    
    func fetchMovie(id: Int, completion: @escaping (Film?) -> Void) {
        let movieDetailsURL = "\(self.baseURL)\(id)?\(self.api_key)&\(self.URLlanguage)"
        guard let url = URL(string: movieDetailsURL) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else{
                print("Error query data")
                return
            }
                let decoder = JSONDecoder()
                
                do {
                    let dtoMovie = try decoder.decode(DTOFilm.self, from: data)
                    var movie = Film(from: dtoMovie)
                    
                    let trailerURL = "\(self.baseURL)\(id)/videos?\(self.api_key)&\(self.URLlanguage)"
                    guard let url = URL(string: trailerURL) else {
                        print("Invalid URL for trailer")
                        DispatchQueue.main.async {
                            completion(nil)
                        }
                        return
                    }
                    URLSession.shared.dataTask(with: url) { data, response, error in
                        if let data = data {
                            do {
                                let dtoTrailer = try decoder.decode(DTOTrailer.self, from: data)
                                if let trailer = dtoTrailer.results.filter({ $0.site == "YouTube" }).first {
                                    movie.link += trailer.key
                                }
                            } catch {
                                print("Failed to decode trailer JSON: \(error)")
                            }
                        } else {
                            print("Failed to fetch trailer data: \(error?.localizedDescription ?? "Unknown error")")
                        }
                        DispatchQueue.main.async {
                            completion(movie)
                        }
                    }.resume()
                    
                } catch {
                    print("Failed to decode JSON: \(error)")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            
        }
        
        task.resume()
    }
    
    
    
}
