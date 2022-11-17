//
//  ContentView.swift
//  StickerMakerStudio
//
//  Created by Antonio Avolio on 14/11/22.
//

import SwiftUI

struct MainView: View {
    @StateObject var dataController = DataController()
    var body: some View {
        NavigationStack{
            TabView{
                MyStickers()
                    .tabItem {
                        Label("My stickers",systemImage: "bookmark")
                    }
                Community()
                    .tabItem {
                        Label("Community",systemImage: "globe.americas.fill")
                    }
            }
        }.environment(\.managedObjectContext,dataController.container.viewContext)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
