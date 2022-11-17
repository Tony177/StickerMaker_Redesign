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
    @State var pickerAlt : Bool = false
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
                        saveStick()
                    } label: {
                        Text("Add element")
                    }
                }
            }.navigationTitle("Add sticker pack")
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
        }.alert("You need to insert all the values in order to add a new element!", isPresented: $pickerAlt) {}
        
        
    }
    func saveStick() -> Void{
        if (newSticker.author == "" || newSticker.title == "" || selectedItem == nil){
            pickerAlt = true
            return
        }
        let stick = StickerBundle(context: managedObjectContext)
        var stickImgs : [StickerImage] = []
        for _ in 0..<30{
            let t = StickerImage(context: managedObjectContext)
            t.id = UUID()
            t.image = UIImage(systemName: "square.and.arrow.up")!.jpegData(compressionQuality: 1)
            stickImgs.append(t)
        }
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
    }
}
