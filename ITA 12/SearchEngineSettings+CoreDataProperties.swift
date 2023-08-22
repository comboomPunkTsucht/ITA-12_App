//
//  SearchEngineSettings+CoreDataProperties.swift
//  ITA 12
//
//  Created by mcpeaps_HD on 21/08/2023.
//
//

import Foundation
import CoreData


extension SearchEngineSettings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchEngineSettings> {
        return NSFetchRequest<SearchEngineSettings>(entityName: "SearchEngineSettings")
    }

    @NSManaged public var selectedSearchEngine: String

}

extension SearchEngineSettings : Identifiable {

}
