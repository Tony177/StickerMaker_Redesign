//
//  stickerView.swift
//  StickerMakerStudio
//
//  Created by Antonio Avolio on 16/11/22.
//

import SwiftUI
import PhotosUI

struct stickerView: View {
    let layout = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),]
    @State var selectedItem : PhotosPickerItem? = nil
    @Binding var stPack : StickerPack
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing:30){
                    Text("Pack System Icon").font(.title2)
                    base64toImage(stPack.trayIcon).resizable().frame(width: 100,height: 100).clipShape(RoundedRectangle(cornerRadius: 8))
                    Text("Stickers")
                }
                LazyVGrid(columns:layout,spacing:32) {
                    ForEach($stPack.stickersImage.indices, id:\.self){ idx in
                        ZStack{
                            RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).frame(width: 105,height: 105).opacity(0.1)
                            if (stPack.stickersImage[idx].used){
                                base64toImage(stPack.stickersImage[idx].image64).resizable().frame(width: 100,height: 100)
                            } else {
                                PhotosPicker(selection: $selectedItem, matching: .images)
                                {
                                    Image(systemName: "square.and.arrow.up").font(.title)
                                }.onChange(of:selectedItem) { newValue in
                                    Task {
                                        if let data = try? await newValue!.loadTransferable(type: Data.self) {
                                            stPack.stickersImage[idx].image64 = data.base64EncodedString()
                                            stPack.stickersImage[idx].used = true
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    }
}

/*
 il problema sussiste perchè onChange, che si applica al cambiamento del valore selezionato, si applica a tutte le schermate
 che hanno il photopickers perchè vuote, in quanto cambierà valore per tutte, non solo quella che ha chiamato il PP
 */
