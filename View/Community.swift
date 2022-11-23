//
//  Community.swift
//  StickerMakerStudio
//
//  Created by Antonio Avolio on 14/11/22.
//

import SwiftUI

struct Community: View {
    @State var stickerList : [StickerPack] = loadPack("stickers")
    var body: some View {
        NavigationStack{
            List{
                ForEach(stickerList.filter({$0.shared})) { elem in
                    StickerLabel(stick: $stickerList.first(where: {$0.id == elem.id})!)
                }
            }
        }
    }
}

