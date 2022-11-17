//
//  addModal.swift
//  StickerMakerStudio
//
//  Created by Antonio Avolio on 15/11/22.
//

import SwiftUI
import PhotosUI

struct addModal: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var bundle: FetchedResults<StickerBundle>
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var newSticker: StickerPack = StickerPack()
    @State var selectedItem: PhotosPickerItem? = nil
    @Binding var pickerMod : Bool
    
    
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
                            Label("Select image", systemImage: "photo")
                        }
                    }
                Section("Privacy"){
                    Toggle(isOn: $newSticker.shared) {
                        Text("Share on community")
                    }
                }
                Section{
                    Button {
                        let stick = StickerBundle(context: managedObjectContext)
                        let stickImgs = [StickerImage](repeating:StickerImage(context: managedObjectContext),count:30)
                        
                        stick.id = UUID()
                        stick.author = newSticker.author
                        stick.title = newSticker.title
                        Task{
                            if let data = try await selectedItem?.loadTransferable(type: Data.self){
                                stick.trayIcon = data
                            }
                        }
                        stick.shared = newSticker.shared
                        stick.bundletoimage = NSSet(array: stickImgs)
                        try? managedObjectContext.save()
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

//struct addModal_Previews: PreviewProvider {
//    static var previews: some View {
//        addModal(pickerMod: .constant(true),stickerList: .constant([StickerPack()]))
//    }
//}
