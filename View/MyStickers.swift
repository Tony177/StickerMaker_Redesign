//
//  MyStickers.swift
//  StickerMakerStudio
//
//  Created by Antonio Avolio on 14/11/22.
//

import SwiftUI

struct MyStickers: View {
    @State var searchText : String = ""
    @State var pickerMod : Bool = false
    @State var stickerList : [StickerPack] = stickerJSON
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(searchResults){stick in
                    NavigationLink {
                        StickerView(stickerList: $stickerList,stPack: $stickerList.first(where: {$0.id == stick.id})!)
                    } label: {
                        StickerLabel(stick: $stickerList.first(where: {$0.id == stick.id})!)
                    }
                }.onDelete(perform: stickerRemove)
            }.searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always),prompt: "Search your stickers")
                .autocorrectionDisabled(true)
                .toolbar {
                    Button {
                        pickerMod = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            
        }.toolbar(.visible, for: .navigationBar)
            .sheet(isPresented: $pickerMod) {
                AddModal(pickerMod: $pickerMod,stickerList: $stickerList)
            }
    }
    var searchResults: [StickerPack] {
        if searchText.isEmpty {
            return stickerList
        } else {
            return stickerList.filter { $0.title.localizedCaseInsensitiveContains(searchText)}
        }
    }
    func stickerRemove(at offset:IndexSet){
        let t : UUID = searchResults[offset.first!].id
        stickerList.removeAll(where: {$0.id == t})
        savePack("stickers",stickerList)
    }
}



struct MyStickers_Previews: PreviewProvider {
    static var previews: some View {
        MyStickers()
    }
}
