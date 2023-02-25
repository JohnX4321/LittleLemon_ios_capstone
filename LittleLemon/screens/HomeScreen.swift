//
//  HomeScreen.swift
//  LittleLemon
//
//  Created by Samarth MS on 25/02/23.
//

import SwiftUI
import Foundation

let persistence = PersistenceController().self

struct HomeScreen: View {
    var body: some View {
        TabView(content: {
            Menu()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            ProfileScreen()
                .tabItem {
                    Label("Profile",systemImage: "square.and.pencil")
                }
                .toolbarBackground(styleGreen, for: .tabBar)
        })
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
