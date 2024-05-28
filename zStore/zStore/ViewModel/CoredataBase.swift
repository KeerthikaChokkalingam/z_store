//
//  CoredataBase.swift
//  zStore
//
//  Created by Keerthika on 27/05/24.
//

import UIKit
import CoreData
import Foundation

class CoredataBase: NSObject {
    static let shared = CoredataBase()
    
    private var managedContext: NSManagedObjectContext!
    
    override init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        managedContext = appDelegate.persistentContainer.viewContext
        
    }
    func createDataForString(entityName: String, key: String, value: String) {
        createData(entityName: entityName, key: key, value: value)
    }
    func createData<T>(entityName: String, key: String, value: T?) {
        // Create a private queue context
        let privateContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        privateContext.persistentStoreCoordinator = managedContext.persistentStoreCoordinator
        
        privateContext.perform {
            do {
                // Fetch records
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                fetchRequest.predicate = NSPredicate(format: "%K != nil", key)
                let existingRecords = try privateContext.fetch(fetchRequest)
                
                // Process the fetched records
                if let existingRecord = existingRecords.first as? NSManagedObject {
                    // Update the existing record if found
                    existingRecord.setValue(value, forKey: key)
                } else {
                    // Create a new record if no existing record is found
                    let userEntity = NSEntityDescription.entity(forEntityName: entityName, in: privateContext)!
                    let newRecord = NSManagedObject(entity: userEntity, insertInto: privateContext)
                    newRecord.setValue(value, forKeyPath: key)
                }
                
                // Save changes
                try privateContext.save()
            } catch {
                return
            }
        }
    }
    func retrieveData(entityName: String, key: String) -> [NSManagedObject]? {
        var result : [NSManagedObject]? = nil
        
        // Prepare the request of type NSFetchRequest for the entity
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            // Perform the fetch request
            result = try managedContext.fetch(fetchRequest)
        } catch {
            // Handle fetch errors
            return nil
        }
        
        return result
    }
    func retrieveDataAsString(entityName: String, key: String) -> String {
        if let value = retrieveData(entityName: entityName, key: key)  {
            let valueAsString = value.compactMap({ $0.value(forKey: key) as? String })
            return valueAsString.first ?? ""
        }
        return ""
    }
    func convertManagedObjectsToJSON(managedObjects: [NSManagedObject]) -> String? {
        var jsonArray = [[String: Any]]()
        for object in managedObjects {
            jsonArray.append(object.toDictionary())
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonArray, options: .prettyPrinted)
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        } catch {
            return nil
        }
    }
    func checkIfEntityExists(entityName: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let count = try managedContext.count(for: fetchRequest)
            return count > 0
        } catch {
            return false
        }
    }
    
    func fetchCoreDataValues() -> ApiResponse? {
        var response: ApiResponse?
        let fetchValue = CoredataBase.shared.retrieveDataAsString(entityName: "Zstore", key: "response")
        if let jsonData = fetchValue.data(using: .utf8) {
            do {
                let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: jsonData)
                response = apiResponse
            } catch {
                return nil
            }
        } else {
            return nil
        }
        return response
    }
    
    func getFavoriteAndUpdate(categoryId: String, isFavorite: Bool) {
        var jsonString = retrieveDataAsString(entityName: "Zstore", key: "response")
        guard let jsonData = jsonString.data(using: .utf8) else {
            return
        }
        
        do {
            guard var json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
                return
            }
            
            if var products = json["products"] as? [[String: Any]] {
                for index in 0..<products.count {
                    if let productId = products[index]["id"] as? String, productId == categoryId {
                        products[index]["addToFav"] = isFavorite
                    }
                }
                json["products"] = products
                
                let updatedJsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                jsonString = String(data: updatedJsonData, encoding: .utf8) ?? ""
                
                createData(entityName: "Zstore", key: "response", value: jsonString)
            } else {
                return
            }
        } catch {
            return
        }
    }
    
}

extension NSManagedObject {
    func toDictionary() -> [String: Any] {
        var dict = [String: Any]()
        for attribute in self.entity.attributesByName {
            if let value = self.value(forKey: attribute.key) {
                dict[attribute.key] = value
            }
        }
        return dict
    }
}
