//
//  Photo+CoreDataProperties.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 6/22/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var comment: String?
    @NSManaged public var tag: String?
    @NSManaged public var image: Data?
    @NSManaged public var thumbnail: Data?

}
