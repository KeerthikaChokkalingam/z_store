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
    func fetchCategoriesProductsAndOffers(completion: @escaping (Result<[String:Any], Error>) -> Void) {
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
                if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    completion(.success(jsonDictionary))
                } else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Data is not a valid JSON dictionary"])
                    completion(.failure(error))
                }
            } catch let parseError {
                completion(.failure(parseError))
            }
        }
        
        task.resume()
    }
    func calculateCellFrame(index: Int, cell: UICollectionViewCell) {
        switch index {
        case 0:
            cell.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
            firstCellFrame = cell.frame
        case 1:
            cell.frame = CGRect(x: firstCellFrame.maxX + 15, y: 0, width: cell.frame.width, height: cell.frame.height)
            secondCellFrame = cell.frame
        case 2:
            cell.frame = CGRect(x: secondCellFrame.maxX + 15, y: 0, width: cell.frame.width, height: cell.frame.height)
            thirdCellFrame = cell.frame
        case 3:
            cell.frame = CGRect(x: thirdCellFrame.maxX + 15, y: 0, width: cell.frame.width, height: cell.frame.height)
            fouthCellFrame = cell.frame
        default:
            calculateCellPosition(firstFrame: firstCellFrame, secondFrame: secondCellFrame,thirdframe: thirdCellFrame, fourthFrame: fouthCellFrame, cell: cell)
        }
    }
    private func calculateCellPosition(firstFrame: CGRect, secondFrame: CGRect,thirdframe: CGRect, fourthFrame: CGRect, cell: UICollectionViewCell) {
        if firstFrame.maxY + 15 < secondFrame.maxY + 15 {
            cell.frame = CGRect(
                x: 0,
                y: firstFrame.maxY + 15,
                width: cell.frame.width,
                height: cell.frame.height
            )
            firstCellFrame = cell.frame
        }
        else if secondFrame.maxY + 15 < thirdframe.maxY + 15 {
            cell.frame = CGRect(
                x: 0,
                y: firstFrame.maxY + 15,
                width: cell.frame.width,
                height: cell.frame.height
            )
            secondCellFrame = cell.frame
        }else if thirdframe.maxY + 15 < fourthFrame.maxY + 15 {
            cell.frame = CGRect(
                x: secondFrame.maxX - 25,
                y: firstFrame.maxY + 15,
                width: cell.frame.width,
                height: cell.frame.height
            )
            thirdCellFrame = cell.frame
        }
        else {
            cell.frame = CGRect(
                x: thirdframe.maxX - 25,
                y: firstFrame.maxY + 15,
                width: cell.frame.width,
                height: cell.frame.height
            )
            fouthCellFrame = cell.frame
        }
    }
    
    
    func calculateWaterFallCellFrame(index: Int, cell: UICollectionViewCell, updatedheight: CGFloat, updatedWidth: CGFloat) -> CGRect {
        switch index {
        case 0:
            cell.frame = CGRect(x: 0, y: 0, width: updatedWidth, height: updatedheight)
            firstCellFrame = cell.frame
        case 1:
            cell.frame = CGRect(x: firstCellFrame.maxX, y: 0, width: updatedWidth, height: updatedheight)
            secondCellFrame = cell.frame
        default:
            cell.frame = calculateWaterFallCellPosition(firstFrame: firstCellFrame, secondFrame: secondCellFrame, cell: cell, updatedheight: updatedheight, updatedWidth: updatedWidth)
        }
        return cell.frame
    }

    
    private func calculateWaterFallCellPosition(firstFrame: CGRect, secondFrame: CGRect, cell: UICollectionViewCell, updatedheight: CGFloat, updatedWidth: CGFloat) -> CGRect {
        if firstFrame.maxY < secondFrame.maxY {
            cell.frame = CGRect(
                x: 0,
                y: firstFrame.maxY,
                width: updatedWidth,
                height: updatedheight
            )
            firstCellFrame = cell.frame
        } else {
            cell.frame = CGRect(
                x: firstFrame.maxX,
                y: secondFrame.maxY,
                width: updatedWidth,
                height: updatedheight
            )
            secondCellFrame = cell.frame
        }
        return cell.frame
    }
    
}
