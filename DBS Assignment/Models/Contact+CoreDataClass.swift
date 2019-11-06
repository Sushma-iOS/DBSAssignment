

import Foundation
import CoreData

@objc(Contact)
public class Contact: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case phoneNumber
        case email
        case favourite
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Contact", in: managedObjectContext) else {
                fatalError("Failed to decode Contact")
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)!
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber)!
        self.email = try container.decodeIfPresent(String.self, forKey: .email)!
        self.favourite = try container.decodeIfPresent(Bool.self, forKey: .favourite)!
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(email, forKey: .email)
        try container.encode(id, forKey: .id)
        try container.encode(image, forKey: .image)
        try container.encode(favourite, forKey: .favourite)
        
    }

}
