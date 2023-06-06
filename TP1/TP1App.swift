//
//  TP1App.swift
//  TP1
//
//  Created by digital on 04/04/2023.
//

import SwiftUI

@main
struct TP1App: App {
    
    @StateObject var viewModel = MovieViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewModel)
        }
    }
}
