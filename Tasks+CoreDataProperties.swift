

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: Date?
    @NSManaged public var isFinished: Bool
    @NSManaged public var id: UUID?

}

extension Tasks : Identifiable {

}
