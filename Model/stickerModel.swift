//
//  stickerModle.swift
//  StickerMakerStudio
//
//  Created by Antonio Avolio on 15/11/22.
//

import Foundation

var stickerJSON: [StickerPack] = loadPack("stickers")

func loadStickers<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: "json")
    else {
        print("WARNING: File doesn't exist. Creating a new one...")
        saveStickers([], filename)
        
        print("Created new JSON file")
        return loadStickers(filename)
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func saveStickers(_ pack: [StickerPack], _ filename: String) -> Void {
    guard let file = Bundle.main.url(forResource: filename, withExtension: "json")
    else {
        fatalError("Couldn't find \(filename) in main bundle. [Save function]")
    }
    
    do {
        let encoder = JSONEncoder()
        try encoder.encode(pack).write(to: file)
    } catch {
        fatalError("Couldn't save \(filename) from main bundle:\n\(error)")
    }
}


func loadPack<T: Decodable>(_ filename: String) -> T {
    let data : Data
    do{
        let file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask,appropriateFor: nil, create: true).appendingPathComponent(filename)
        data = try Data(contentsOf: file)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        savePack(filename,[])
        return loadPack(filename)
    }
}

func savePack (_ filename: String, _ pack: [StickerPack]) -> Void {
    let data: Data
    do {
        let file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask,appropriateFor: nil, create: true).appendingPathComponent(filename)
        let encoder = JSONEncoder()
        data = try encoder.encode(pack)
        try data.write(to: file)
    } catch {
        fatalError("Couldn't save \(filename) from main bundle:\n\(error)")
    }
}
