

import Foundation

protocol ParsingHandler {
    
}

extension ParsingHandler {
    func readJson() -> [Contact]? {
        
        guard let fileUrl = Bundle.main.url(forResource: "Contacts", withExtension: "json") else {
            return nil
        }
        do {
            let jsonData = try Data(contentsOf: fileUrl)
            
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                fatalError("Failed to retrieve managed object conext")
            }
            let managedobjectContext = CoredataManager.shared.context
            let decoder = JSONDecoder()
            decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedobjectContext
            let parsedData = try decoder.decode([Contact].self, from: jsonData)
            try managedobjectContext.save()
            return parsedData
            
        } catch {
            
            print("Error: \(error)")
            
        }
        
        return nil
        
    }
    
    func initViewModels(_ contactsModel: [Contact]) -> [ContactsViewModel]? {
        return contactsModel.map({ return ContactsViewModel(coreDataModel: $0)})
    }
}
