//
//  Favorites+CoreDataClass.swift
//  listOfGames
//
//  Created by Роман Цуприк on 24.04.23.
//
//

import Foundation
import CoreData

@objc(Favorites)
public class Favorites: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManagers.instance.entityForName(entityName: "Favorites"), insertInto: CoreDataManagers.instance.context)
    }
}
