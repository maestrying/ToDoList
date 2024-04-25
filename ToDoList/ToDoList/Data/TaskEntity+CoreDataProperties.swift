//
//  TaskEntity+CoreDataProperties.swift
//  ToDoList
//
//  Created by Дывак Максим on 24.04.2024.
//
//

import Foundation
import CoreData

@objc(TaskEntity)
public class TaskEntity: NSManagedObject {

}

extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var descr: String?

}

extension TaskEntity : Identifiable {

}
