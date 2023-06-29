//
//  ContentView.swift
//  VideogameApp
//
//  Created by Cristian on 27/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            GameListView()
                .tabItem {
                    Label("Games", systemImage: "square.and.pencil")
                }
            FavoriteGamesView()
                .tabItem {
                    Label("Favorites", systemImage: "list.dash")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
