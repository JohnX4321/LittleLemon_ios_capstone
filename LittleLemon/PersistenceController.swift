//
//  PersistenceController.swift
//  LittleLemon
//
//  Created by Samarth MS on 25/02/23.
//

import Foundation
import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "ExampleDatabase")
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: {_,_ in })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func clear() {
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Dish")
        let delRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let  _ = try? container.persistentStoreCoordinator.execute(delRequest, with: container.viewContext)
    }
    
}
