//
//  ContentView.swift
//  StickerMakerStudio
//
//  Created by Antonio Avolio on 14/11/22.
//

import SwiftUI

struct MainView: View {
    @State var isActive : Bool = false
    var body: some View {
        NavigationStack{
            if isActive {
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
                
            } else {
                SplashScreen()
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.2    ){
                isActive = true
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
