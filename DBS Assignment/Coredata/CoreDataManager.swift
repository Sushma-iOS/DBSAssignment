import Foundation
import CoreData

final class CoredataManager {
    
    private init() {  }
    
    static let shared = CoredataManager()
    
    lazy var context = self.persistentContainer.viewContext
    
    lazy var persistentContainer: NSPersistentContainer = {
     
        let container = NSPersistentContainer(name: "DBS_Assignment")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
               
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T]? {
        
        let object = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: object)        
        do {
            let contacts = try context.fetch(fetchRequest) as? [T]
            return contacts
        } catch let error {
            print(error)
            return [T]()
        }
    }
    func updateContactFavourite<T: NSManagedObject>(_ objectType: T.Type, idStr: String, value: Bool) {
        let context = persistentContainer.viewContext
        let object = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: object)
        fetchRequest.predicate = NSPredicate(format: "id = %@", idStr)
        do {
            let contacts = try context.fetch(fetchRequest) as? [T]
            let contactUpdate = contacts![0]
            contactUpdate.setValue(value, forKey: "favourite")
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved update error \(nserror), \(nserror.userInfo)")
            }
        } catch let error {
            print(error)
        }
    }
    func deleteContact<T: NSManagedObject>(_ objectType: T.Type, idStr: String) {
        let context = persistentContainer.viewContext
        let object = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: object)
        fetchRequest.predicate = NSPredicate(format: "id = %@", idStr)
        do {
            let contacts = try context.fetch(fetchRequest) as? [T]
            context.delete(contacts![0])
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved delete error \(nserror), \(nserror.userInfo)")
            }
        } catch let error {
            print(error)
        }
    }
    
}
