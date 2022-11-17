//
//  DataController.swift
//  StickerMakerStudio
//
//  Created by Antonio Avolio on 16/11/22.
//

import Foundation
import CoreData

final class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "stickers")
    
    init() {
        container.loadPersistentStores{description, error in
            if let error {
                print(error)
            } else {
                print(description)
            }
        }
    }}
