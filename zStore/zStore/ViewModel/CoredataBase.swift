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
    
    var managedContext: NSManagedObjectContext!
    
    override init() {
        super.init()
        initializeManagedContext()
    }
    func initializeManagedContext() {
            if Thread.isMainThread {
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                self.managedContext = appDelegate.persistentContainer.viewContext
            } else {
                DispatchQueue.main.sync {
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                    self.managedContext = appDelegate.persistentContainer.viewContext
                }
            }
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
    func isDataStored(entityName: String, key: String, value: String) async -> Bool {
        return await withCheckedContinuation { continuation in
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            fetchRequest.predicate = NSPredicate(format: "%K == %@", key, value)
            
            do {
                let results = try managedContext.fetch(fetchRequest)
                continuation.resume(returning: results.count > 0)
            } catch {
                print("Failed to fetch data: \(error)")
                continuation.resume(returning: false)
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
   
    func checkIfEntityExists(entityName: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let count = try managedContext.count(for: fetchRequest)
            return count > 0
        } catch {
            return false
        }
    }
    
    func getFavoriteAndUpdate(categoryId: String, isFavorite: Bool) async -> ApiResponse? {
        var jsonString = retrieveDataAsString(entityName: "Zstore", key: "response")
        guard let jsonData = jsonString.data(using: .utf8) else {
            return nil
        }
        
        do {
            guard var json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
                return nil
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
                
                if await self.isDataStored(entityName: "Zstore", key: "response", value: jsonString) {
                    do {
                        let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: updatedJsonData)
                        return apiResponse
                    } catch {
                        return nil
                    }
                } else {
                    return nil
                }
                
            } else {
                return nil
            }
        } catch {
            return nil
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
