//
//  StickerLabel.swift
//  StickerMakerStudio
//
//  Created by Antonio Avolio on 23/11/22.
//

import SwiftUI

struct StickerLabel: View {
    @Binding var stick : StickerPack
    var body: some View {
        HStack{
            base64toImage(stick.trayIcon).resizable().frame(width: 64,height: 64).clipShape(RoundedRectangle(cornerRadius: 8))
            Spacer()
            VStack(spacing:8){
                Text(stick.title).fontWeight(.semibold)
                Text(stick.author).fontWeight(.ultraLight)
            }
            Spacer()
            Text(stick.shared ? "Shared" : "Private").font(.subheadline).fontWeight(.ultraLight)
            
        }
    }
}
