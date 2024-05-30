//
//  ContrllerModel.swift
//  zStore
//
//  Created by Keerthika on 25/05/24.
//

import UIKit

class ContrllerViewModel: NSObject {
    
    var firstCellFrame: CGRect = .zero
    var secondCellFrame: CGRect = .zero
    var thirdCellFrame: CGRect = .zero
    var fouthCellFrame: CGRect = .zero
    
    
    func checkData(completion: @escaping (Result<ApiResponse, Error>) -> Void) {
        fetchCategoriesProductsAndOffers(completion: { result in
            switch result {
            case .success(let apiresponse):
                completion(.success(apiresponse))
            case .failure:
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No products found"])))
            }
        })
    }
    
    func fetchCategoriesProductsAndOffers(completion: @escaping (Result<ApiResponse, Error>) -> Void) {
        let urlString = "https://raw.githubusercontent.com/princesolomon/zstore/main/data.json"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP Error: \(httpResponse.statusCode)"])
                    completion(.failure(error))
                    return
                }
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            
            do {
                if var jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if var productsArray = jsonDictionary["products"] as? [[String: Any]] {
                        for index in 0..<productsArray.count {
                            productsArray[index]["addToFav"] = false
                        }
                        jsonDictionary["products"] = productsArray
                        
                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDictionary, options: [])
                        
                        if CoredataBase.shared.checkIfEntityExists(entityName: "Zstore") {
                            let jsonString = CoredataBase.shared.retrieveDataAsString(entityName: "Zstore", key: "response")
                            guard let coredataValues = jsonString.data(using: .utf8) else {
                                return
                            }
                            
                            let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: coredataValues)
                            completion(.success(apiResponse))
                        } else {
                            
                            let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: jsonData)
                            
                            if let jsonString = String(data: jsonData, encoding: .utf8) {
                                CoredataBase.shared.createData(entityName: "Zstore", key: "response", value: jsonString)
                            }
                            completion(.success(apiResponse))
                        }
                    } else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No products found"])))
                    }
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Data is not a valid JSON dictionary"])))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    // MARK: Dynamic Top Scroll Layout
    
    func calculateCellFrame(index: Int, cell: UICollectionViewCell) {
        switch index {
        case 0:
            cell.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
            firstCellFrame = cell.frame
        case 1:
            cell.frame = CGRect(x: firstCellFrame.maxX + 5, y: 0, width: cell.frame.width, height: cell.frame.height)
            secondCellFrame = cell.frame
        case 2:
            cell.frame = CGRect(x: secondCellFrame.maxX + 5, y: 0, width: cell.frame.width, height: cell.frame.height)
            thirdCellFrame = cell.frame
        case 3:
            cell.frame = CGRect(x: thirdCellFrame.maxX + 5, y: 0, width: cell.frame.width, height: cell.frame.height)
            fouthCellFrame = cell.frame
        default:
            calculateCellPosition(firstFrame: firstCellFrame, secondFrame: secondCellFrame,thirdframe: thirdCellFrame, fourthFrame: fouthCellFrame, cell: cell)
        }
    }
    private func calculateCellPosition(firstFrame: CGRect, secondFrame: CGRect,thirdframe: CGRect, fourthFrame: CGRect, cell: UICollectionViewCell) {
        if firstFrame.maxY + 5 < secondFrame.maxY + 5 {
            cell.frame = CGRect(
                x: 0,
                y: firstFrame.maxY + 10,
                width: cell.frame.width,
                height: cell.frame.height
            )
            firstCellFrame = cell.frame
        }
        else if secondFrame.maxY + 5 < thirdframe.maxY + 5 {
            cell.frame = CGRect(
                x: 0,
                y: firstFrame.maxY + 10,
                width: cell.frame.width,
                height: cell.frame.height
            )
            secondCellFrame = cell.frame
        }else if thirdframe.maxY + 5 < fourthFrame.maxY + 5 {
            cell.frame = CGRect(
                x: secondFrame.maxX - 25,
                y: firstFrame.maxY + 10,
                width: cell.frame.width,
                height: cell.frame.height
            )
            thirdCellFrame = cell.frame
        }
        else {
            cell.frame = CGRect(
                x: thirdframe.maxX - 15,
                y: firstFrame.maxY + 10,
                width: cell.frame.width,
                height: cell.frame.height
            )
            fouthCellFrame = cell.frame
        }
    }
    func applySort(currentSort: String, currentCategory: String) -> ApiResponse {
        var sortedResponse: ApiResponse?
        if currentSort == "ratings" {
            let selectedCategpryvalues = CoredataBase.shared.fetchCoreDataValues(elementId: currentCategory)
            let selectedcategoryFilter = selectedCategpryvalues?.products?.filter{$0.categoryId == currentCategory}
            let sortedProducts = selectedcategoryFilter?.sorted { $0.rating > $1.rating }
            sortedResponse = selectedCategpryvalues
            sortedResponse?.products = sortedProducts
        } else {
            let selectedCategpryvalues = CoredataBase.shared.fetchCoreDataValues(elementId: currentCategory)
            let selectedcategoryFilter = selectedCategpryvalues?.products?.filter{$0.categoryId == currentCategory}
            let sortedProducts = selectedcategoryFilter?.sorted { $0.price > $1.price }
            sortedResponse = selectedCategpryvalues
            sortedResponse?.products = sortedProducts
        }
        return sortedResponse ?? ApiResponse()
    }
    func showAPIFailureAlert(on viewController: UIViewController, message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
