//
//  addModal.swift
//  StickerMakerStudio
//
//  Created by Antonio Avolio on 15/11/22.
//

import SwiftUI
import PhotosUI

struct addModal: View {
    @State private var emptyAlt : Bool = false
    @State private var newSticker: StickerPack = StickerPack()
    @State private var selectedItem: PhotosPickerItem? = nil
    @Binding var pickerMod : Bool
    @Binding var stickerList : [StickerPack]
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Info"){
                    TextField("Insert title here",text: $newSticker.title)
                    TextField("Insert author here",text: $newSticker.author)
                }
                Section("Pack icon"){
                    PhotosPicker(selection: $selectedItem, matching: .images)
                    {
                        HStack{
                            Label("Select image", systemImage: "photo")
                            Spacer()
                            Image(systemName: "checkmark").opacity(selectedItem == nil ? 0.0 : 1.0)
                            
                        }
                    }.onChange(of: selectedItem, perform: { newItem in
                        Task{
                            if let data = try? await newItem?.loadTransferable(type: Data.self){
                                newSticker.trayIcon = data.base64EncodedString()
                            }
                        }
                    })
                }
                Section("Privacy"){
                    Toggle(isOn: $newSticker.shared) {
                        Text("Share on community")
                    }
                }
                Section{
                    Button {
                        if (newSticker.author == "" || newSticker.title == "" || selectedItem == nil){
                                    emptyAlt = true
                        } else {
                            stickerList.append(newSticker)
                            savePack("stickers",stickerList)
                            pickerMod = false
                        }
                    } label: {
                        Text("Add element")
                    }
                }
            }.navigationTitle("Add sticker pack")
                .autocorrectionDisabled(true)
        }.alert("You need to insert all the values in order to add a new element!", isPresented: $emptyAlt) {}
    }
}
