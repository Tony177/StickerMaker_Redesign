//
//  dataStructure.swift
//  StickerMakerStudio
//
//  Created by Antonio Avolio on 15/11/22.
//

import Foundation

struct StickerPack : Identifiable,Codable,Equatable {
    init(title:String,author:String,shared:Bool,trayIcon:String,stickersImage:[StickersImage]) {
        self.id = UUID()
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
        self.trayIcon = ""
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
    init(imagePath:String){
        self.id = UUID()
        self.imagePath = imagePath
    }
    init(){
        self.id = UUID()
        self.imagePath = ""
    }
    var id = UUID()
    var imagePath : String
}
