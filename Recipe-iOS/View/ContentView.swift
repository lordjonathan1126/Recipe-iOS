//
//  ContentView.swift
//  Recipe-iOS
//
//  Created by Jonathan Ng on 28/02/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            SavedView()
                .tabItem {
                    Image(systemName: "square.and.arrow.down")
                    Text("Saved")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
