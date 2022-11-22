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
    @Environment(\.colorScheme) var colorScheme
    @State var onConfermation : Bool = false
    @State var alertFull : Bool = false
    @State var selectedItem : [PhotosPickerItem?] = [PhotosPickerItem?](repeating: nil, count: 30)
    @State var idxSticker : Int = 0
    @Binding var stickerList : [StickerPack]
    @Binding var stPack : StickerPack
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing:30){
                    Text("Pack System Icon").font(.title2)
                    base64toImage(stPack.trayIcon).resizable().frame(width: 100,height: 100).clipShape(RoundedRectangle(cornerRadius: 8))
                    Text("Stickers").font(.title3)
                }
                LazyVGrid(columns:layout,spacing:32) {
                    ForEach($stPack.stickersImage.indices, id:\.self){ idx in
                        ZStack{
                            RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).frame(width: 101,height: 101).opacity(colorScheme == .dark ? 0.8 : 0.1)
                            if (stPack.stickersImage[idx].used){
                                Button {
                                    idxSticker = idx
                                    onConfermation = true
                                } label: {
                                    base64toImage(stPack.stickersImage[idx].image64).resizable().frame(width: 100,height: 100).clipShape(RoundedRectangle(cornerRadius: 8))
                                }

                                
                            } else {
                                PhotosPicker(selection: $selectedItem[idx], matching: .images)
                                {
                                    Image(systemName: "plus").font(.title).frame(width: 100,height: 100)
                                }.onChange(of:selectedItem[idx]) { newValue in
                                    Task {
                                        if let data = try? await newValue!.loadTransferable(type: Data.self) {
                                            stPack.stickersImage[idx].image64 = data.base64EncodedString()
                                            stPack.stickersImage[idx].used = true
                                        }
                                        savePack("stickers",stickerList)
                                    }
                                }
                            }
                        }
                    }
                }
            }.confirmationDialog("Prova", isPresented: $onConfermation) {
                Button ("Remove sticker",role:.destructive) {
                    let idxSl = stickerList.firstIndex(where: {$0.id == stPack.id})!
                    stickerList[idxSl].stickersImage[idxSticker].used = false
                    stickerList[idxSl].stickersImage[idxSticker].image64 = ""
                }
                Button("Bring on top"){
                    let idxSl = stickerList.firstIndex(where: {$0.id == stPack.id})!
                    if let idxFree = stickerList[idxSl].stickersImage.firstIndex(where: { !$0.used}) {
                        stickerList[idxSl].stickersImage[idxSticker].used = false
                        stickerList[idxSl].stickersImage[idxFree].image64 = stickerList[idxSl].stickersImage[idxSticker].image64
                        stickerList[idxSl].stickersImage[idxFree].used = true
                        stickerList[idxSl].stickersImage[idxSticker].image64 = ""
                    }
                    else{
                        alertFull = true
                    }
                }
            }
        }.alert("There isn't any free space to relocate the sticker.", isPresented: $alertFull) {}
    }
}
