//
//  MyStickers.swift
//  StickerMakerStudio
//
//  Created by Antonio Avolio on 14/11/22.
//

import SwiftUI

struct MyStickers: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var bundle: FetchedResults<StickerBundle>
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var searchText : String = ""
    @State var pickerMod : Bool = false
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(searchResults){CDstick in
                    let stick = CDtoObj(CD: CDstick)
                    NavigationLink {
                        stickerView(stPack: .constant(stick))
                    } label: {
                        HStack{
                            stick.trayIcon.resizable().frame(width: 64,height: 64).clipShape(RoundedRectangle(cornerRadius: 8))
                            Spacer()
                            VStack(spacing:8){
                                Text(stick.title).fontWeight(.semibold)
                                Text(stick.author).fontWeight(.ultraLight)
                            }
                            Spacer()
                            Text(stick.shared ? "Shared" : "Private").font(.subheadline).fontWeight(.ultraLight)
                            
                        }
                    }
                }.onDelete(perform: stickerRemove)
            }.searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always),prompt: "Search your stickers").autocorrectionDisabled(true).textInputAutocapitalization(.never)
                .toolbar {
                    Button {
                        pickerMod = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            
        }
        .sheet(isPresented: $pickerMod) {
            addModal(pickerMod: $pickerMod)
        }
    }
    var searchResults: [StickerBundle] {//[StickerPack] {
        if searchText.isEmpty {
            return bundle.sorted(by: {$0.title! < $1.title!})
        } else {
            return bundle.filter { $0.title!.localizedCaseInsensitiveContains(searchText)}
        }
    }
    func stickerRemove(at offset:IndexSet){
        managedObjectContext.delete(bundle.first(where: {$0.id == searchResults[offset.first!].id})!)
        try? managedObjectContext.save()
    }
    func CDtoObj (CD : StickerBundle) -> StickerPack{
        var t : Image
        if let icon = CD.trayIcon {
            t = Image(uiImage: UIImage(data: icon)!)
        } else {
            t = Image(systemName: "x.circle")
        }
        return StickerPack(title: CD.title!, author: CD.author!, shared: CD.shared, trayIcon: t, stickersImage: CD.bundletoimage!)
    }
}
