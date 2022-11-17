//
//  stickerView.swift
//  StickerMakerStudio
//
//  Created by Antonio Avolio on 16/11/22.
//

import SwiftUI

struct stickerView: View {
    let layout = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),]
    @Binding var stPack : StickerPack
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing:30){
                    Text("Pack System Icon").font(.title2)
                    ZStack{
                        stPack.trayIcon.resizable().frame(width: 100,height: 100).clipShape(RoundedRectangle(cornerRadius: 8))
                        RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).frame(width: 105,height: 105)
                    }
                    Text("Stickers")
                }
                LazyVGrid(columns:layout,spacing:32) {
                    ForEach(Array(stPack.stickersImage as Set), id: \.self){ elem in
                        ZStack{
                            RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).frame(width: 105,height: 105)
                            //elem.img.resizable().frame(width: 100,height: 100)                            
                        }
                        
                    }
                }
            }
        }
    }
}
