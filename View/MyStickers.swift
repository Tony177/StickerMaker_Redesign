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
                    HStack{
                        Image(stick.trayIcon).resizable().frame(width: 64,height: 64).clipShape(RoundedRectangle(cornerRadius: 8))
                        Spacer()
                        VStack(spacing:8){
                            Text(stick.title).fontWeight(.semibold)
                            Text(stick.author).fontWeight(.ultraLight)
                        }
                        Spacer()
                    }
                }.onDelete(perform: stickerRemove)
            }.toolbar {
                Button {
                    pickerMod = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            
        }
        .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always),prompt: "Search your stickers")
            .sheet(isPresented: $pickerMod) {
                addModal(pickerMod: $pickerMod,stickerList: $stickerList)
            }
    }
    var searchResults: [StickerPack] {
            if searchText.isEmpty {
                return stickerList
            } else {
                return stickerList.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
            }
        }
    func stickerRemove(at offset:IndexSet){
        var t : UUID = searchResults[offset.first!].id
        stickerList.removeAll(where: {$0.id == t})
        saveStickers(stickerList, "stickers")
    }
}



struct MyStickers_Previews: PreviewProvider {
    static var previews: some View {
        MyStickers()
    }
}


//do {
//       let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//               .appendingPathComponent("myPastTrip.json")
//       let encoder = JSONEncoder()
//       try encoder.encode(myTrips).write(to: fileURL)
//   } catch {
//       print(error.localizedDescription)
//   }
//}
