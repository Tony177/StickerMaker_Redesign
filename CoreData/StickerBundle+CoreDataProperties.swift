//
//  StickerBundle+CoreDataProperties.swift
//  StickerMakerStudio
//
//  Created by Antonio Avolio on 17/11/22.
//
//

import Foundation
import CoreData


extension StickerBundle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StickerBundle> {
        return NSFetchRequest<StickerBundle>(entityName: "StickerBundle")
    }

    @NSManaged public var author: String?
    @NSManaged public var id: UUID?
    @NSManaged public var shared: Bool
    @NSManaged public var title: String?
    @NSManaged public var trayIcon: Data?
    @NSManaged public var bundletoimage: NSSet?

}

// MARK: Generated accessors for bundletoimage
extension StickerBundle {

    @objc(addBundletoimageObject:)
    @NSManaged public func addToBundletoimage(_ value: StickerImage)

    @objc(removeBundletoimageObject:)
    @NSManaged public func removeFromBundletoimage(_ value: StickerImage)

    @objc(addBundletoimage:)
    @NSManaged public func addToBundletoimage(_ values: NSSet)

    @objc(removeBundletoimage:)
    @NSManaged public func removeFromBundletoimage(_ values: NSSet)

}

extension StickerBundle : Identifiable {

}
