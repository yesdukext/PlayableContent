//
//  CoreDataManager.swift
//  BrowsePlayableContent
//
//  Created by Yves Dukuze on 06/09/2024.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let  shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "CachedPlayableItem")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data: \(error.localizedDescription)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save Core Data: \(error)")
            }
        }
    }
    
    func fetchCachedPlayableItems() -> [PlayableItem] {
        
        let fetchRequest: NSFetchRequest<CachedPlayableItem> = CachedPlayableItem.fetchRequest()
        
        do {
            let cachedItems = try context.fetch(fetchRequest)
            return cachedItems.map {
                PlayableItem(id: $0.id ?? "", title: $0.title ?? "", imageURL: $0.imageUrl ?? "", stationName: $0.stationName ?? "")
            }
        } catch {
            print("Failed to fetch cached items: \(error)")
            return[]
        }
    }
    
    func cachePlayableItems(_ items: [PlayableItem]) {
        items.forEach { item in
            let cachedItem = CachedPlayableItem(context: context)
            cachedItem.id = item.id
            cachedItem.title = item.title
            cachedItem.imageUrl = item.imageURL
            cachedItem.stationName = item.stationName
        }
        save()
    }
    
    func clearCache() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CachedPlayableItem.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            save()
        } catch {
            print("Failed to clear cache: \(error)")
        }
    }
}
