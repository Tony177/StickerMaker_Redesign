//
//  Community.swift
//  StickerMakerStudio
//
//  Created by Antonio Avolio on 14/11/22.
//

import SwiftUI
let randsn = ["snowflake","hare.fill","tortoise.fill","lizard.fill","bird.fill","ant.fill","fish.fill","leaf.fill","tree.fill","carrot.fill"]
let tray = UIImage(systemName: "pin.fill")!.withTintColor(.label).pngData()!.base64EncodedString()
let images = [StickersImage(id: UUID(), uiImage: UIImage(systemName: randsn.randomElement()!)!.withTintColor(.label), used: true),
              StickersImage(id: UUID(), uiImage: UIImage(systemName: randsn.randomElement()!)!.withTintColor(.label), used: true),
              StickersImage(id: UUID(), uiImage: UIImage(systemName: randsn.randomElement()!)!.withTintColor(.label), used: true),
              StickersImage(id: UUID(), uiImage: UIImage(systemName: randsn.randomElement()!)!.withTintColor(.label), used: true),
              StickersImage(id: UUID(), uiImage: UIImage(systemName: randsn.randomElement()!)!.withTintColor(.label), used: true),
              StickersImage(id: UUID(), uiImage: UIImage(systemName: randsn.randomElement()!)!.withTintColor(.label), used: true),
              StickersImage(id: UUID(), uiImage: UIImage(systemName: randsn.randomElement()!)!.withTintColor(.label), used: true),
              StickersImage(id: UUID(), uiImage: UIImage(systemName: randsn.randomElement()!)!.withTintColor(.label), used: true),
              StickersImage(id: UUID(), uiImage: UIImage(systemName: randsn.randomElement()!)!.withTintColor(.label), used: true),
              StickersImage(id: UUID(), uiImage: UIImage(systemName: randsn.randomElement()!)!.withTintColor(.label), used: true)]

struct Community: View {
    let packs : [StickerPack] = [StickerPack(id: UUID(), title: "sticker1", author: "Antonio", shared: true, trayIcon: tray,                                            stickersImage: images.shuffled()),
                                 StickerPack(id: UUID(), title: "sticker2", author: "Luca", shared: true, trayIcon: tray, stickersImage: images.shuffled()),
                                 StickerPack(id: UUID(), title: "sticker3", author: "Lorenzo", shared: true, trayIcon: tray, stickersImage: images.shuffled()),
                                 StickerPack(id: UUID(), title: "sticker4", author: "Giuseppe", shared: true, trayIcon: tray, stickersImage: images.shuffled()),
                                 StickerPack(id: UUID(), title: "sticker5", author: "Alessia", shared: true, trayIcon: tray, stickersImage: images.shuffled()),
                                 StickerPack(id: UUID(), title: "sticker6", author: "Maria", shared: true, trayIcon: tray, stickersImage: images.shuffled()),
                                 StickerPack(id: UUID(), title: "sticker7", author: "Stefano", shared: true, trayIcon: tray, stickersImage: images.shuffled()),
                                 StickerPack(id: UUID(), title: "sticker8", author: "Arianna", shared: true, trayIcon: tray, stickersImage: images.shuffled())
    ]
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing:50){
                    ForEach(packs) { pack in
                        VStack{
                            HStack(spacing:40){
                                base64toImage(pack.trayIcon).resizable().frame(width: 50,height: 50).clipShape(RoundedRectangle(cornerRadius: 5))
                                VStack{
                                    Text(pack.title).font(.headline)
                                    Text(pack.author).font(.subheadline)
                                }
                                Spacer()
                            }
                            ScrollView(.horizontal){
                                HStack{
                                    ForEach(pack.stickersImage) { stick in
                                        base64toImage(stick.image64).resizable().frame(width: 50,height: 50).clipShape(RoundedRectangle(cornerRadius: 5))
                                    }
                                }
                            }
                        }
                    }
                }
            }.padding()
        }
    }
}
struct Community_Previews: PreviewProvider {
    static var previews: some View {
        Community()
    }
}
