//
//  Member+CoreDataProperties.swift
//  feb21SimplePage
//
//  Created by Tiparpron Sukanya on 2/23/24.
//
//

import Foundation
import CoreData


extension Member {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Member> {
        return NSFetchRequest<Member>(entityName: "Member")
    }

    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var phone: String?
    @NSManaged public var email: String?

}

extension Member : Identifiable {

}
