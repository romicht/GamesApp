//
//  Favorites+CoreDataProperties.swift
//  listOfGames
//
//  Created by Роман Цуприк on 24.04.23.
//
//

import Foundation
import CoreData


extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var genres: String?
    @NSManaged public var backgroudImage: String?
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var rating: Double
    @NSManaged public var released: String?

}

extension Favorites : Identifiable {

}
