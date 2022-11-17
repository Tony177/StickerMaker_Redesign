//
//  StickerImage+CoreDataProperties.swift
//  StickerMakerStudio
//
//  Created by Antonio Avolio on 17/11/22.
//
//

import Foundation
import CoreData


extension StickerImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StickerImage> {
        return NSFetchRequest<StickerImage>(entityName: "StickerImage")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var imagetobundle: StickerBundle?

}

extension StickerImage : Identifiable {

}
