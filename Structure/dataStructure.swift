//
//  dataStructure.swift
//  StickerMakerStudio
//
//  Created by Antonio Avolio on 15/11/22.
//

import Foundation
import SwiftUI

func base64toImage(_ b64:String) -> Image {
    return Image(uiImage: UIImage(data: Data(base64Encoded: b64)!)!)
}
struct StickerPack : Identifiable,Codable,Equatable {
    init(id:UUID,title:String,author:String,shared:Bool,trayIcon:String,stickersImage:[StickersImage]) {
        self.id = id
        self.title = title
        self.author = author
        self.shared = shared
        self.trayIcon = trayIcon
        self.stickersImage = stickersImage
    }
    init(){
        self.id = UUID()
        self.title = ""
        self.author = ""
        self.shared = false
        self.trayIcon = UIImage(systemName: "x.circle")!.withTintColor(.label).pngData()!.base64EncodedString()
        self.stickersImage = AnyIterator {}.prefix(30).map{StickersImage()}
    }
    var id = UUID()
    var title : String
    var author: String
    var shared : Bool
    var trayIcon : String
    var stickersImage: [StickersImage]
}

struct StickersImage : Identifiable,Codable,Equatable{
    init(id:UUID,uiImage: UIImage,used : Bool){
        self.id = id
        self.image64 = uiImage.withTintColor(.label).pngData()!.base64EncodedString()
        self.used = used
    }
    init(){
        self.id = UUID()
        self.image64 = ""
        self.used = false
    }
    var id = UUID()
    var image64 : String
    var used : Bool
}

