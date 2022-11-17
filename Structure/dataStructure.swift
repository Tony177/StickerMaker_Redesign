//
//  dataStructure.swift
//  StickerMakerStudio
//
//  Created by Antonio Avolio on 15/11/22.
//

import Foundation
import SwiftUI

struct StickerPack : Identifiable,Equatable {
    init(title:String,author:String,shared:Bool,trayIcon:Image,stickersImage:NSSet) {
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
        self.trayIcon = Image(systemName: "square.and.arrow.up")
        self.stickersImage = NSSet(array: AnyIterator {}.prefix(30).map{StickerElem(img:Image(systemName: "square.and.arrow.up"))})
    }
    var id = UUID()
    var title : String
    var author: String
    var shared : Bool
    var trayIcon : Image
    var stickersImage: NSSet
}

struct StickerElem : Identifiable,Equatable{
    init(img:Image){
        self.id = UUID()
        self.img = img
    }
    var id = UUID()
    var img : Image
}
