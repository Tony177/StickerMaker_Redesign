//
//  addModal.swift
//  StickerMakerStudio
//
//  Created by Antonio Avolio on 15/11/22.
//

import SwiftUI

struct addModal: View {
    @Binding var pickerMod : Bool
    @Binding var stickerList : [StickerPack]
    @State var newSticker: StickerPack = StickerPack()
    var body: some View {
        NavigationStack(){
            Form{
                Section("Info"){
                    TextField("Insert title here",text: $newSticker.title)
                    
                    
                    TextField("Insert author here",text: $newSticker.author)
                    TextField("Image",text:$newSticker.trayIcon)
                }
                    Section("Privacy"){
                    Toggle(isOn: $newSticker.shared) {
                        Text("Share on community")
                    }
                }
                Section{
                    Button {
                        stickerList.append(newSticker)
                        savePack("stickers",stickerList)
                        pickerMod = false
                    } label: {
                        Text("Add element")
                    }
                }
            }.navigationTitle("Add sticker pack")
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
        }


    }
}

struct addModal_Previews: PreviewProvider {
    static var previews: some View {
        addModal(pickerMod: .constant(true),stickerList: .constant([StickerPack()]))
    }
}
