//
//  ViewController.swift
//  zStore
//
//  Created by Keerthika on 25/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    weak var backView: UIView!
    weak var topView: UIView!
    weak var topTitleView: UIView!
    weak var topTitlelabel: UILabel!
    weak var searchButton: UIButton!
    weak var topSearchViewView: UIView!
    weak var searchField: UITextField!
    weak var searchCancelButton: UIButton!
    weak var topCategoriesView: UIView!
    weak var topCategoriesCollectionView: UICollectionView!
    weak var contentView: UIView!
    weak var linearLayout: UITableView!
    weak var waterfalllayout: UICollectionView!
    
    var viewModel: ContrllerViewModel?
    var searchTapped: Bool = false
    var categoryArray: [[String:Any]] = []
    var productsArray: [[String:Any]] = []
    var cardOffersArray: [[String:Any]] = []
    var isLinearLayout: Bool = false
    var offerCellHeight: CGFloat = 0
    var selectedCategoryID: String = "100023"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setupConstraints()
        loadContent()
        apiCall()
        
    }
    deinit {
        viewModel = nil
    }
    func loadContent() {
        viewModel = ContrllerViewModel()
        self.searchButton.addTarget(self, action: #selector(searchButtonAction(_:)), for: .touchUpInside)
        self.searchCancelButton.addTarget(self, action: #selector(cancelButtonAction(_:)), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(offerCellHeight(_:)), name: NSNotification.Name(rawValue: "increase"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(offerCellHeight(_:)), name: NSNotification.Name(rawValue: "decrease"), object: nil)


    }
    func setUpDelegate() {
        DispatchQueue.main.async {
            self.waterfalllayout.delegate = self
            self.waterfalllayout.dataSource = self
            self.waterfalllayout.register(OfferListCollectionCell.self, forCellWithReuseIdentifier: "OfferListCollectionCell")
            self.waterfalllayout.register(WaterfallListCell.self, forCellWithReuseIdentifier: "WaterfallListCell")
            self.waterfalllayout.reloadData()
            self.linearLayout.register(OffersListCell.self, forCellReuseIdentifier: "OffersListCell")
            self.linearLayout.register(LinearListCell.self, forCellReuseIdentifier: "LinearListCell")
            self.linearLayout.reloadData()
            self.topCategoriesCollectionView.delegate = self
            self.topCategoriesCollectionView.dataSource = self
            self.topCategoriesCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
            self.topCategoriesCollectionView.reloadData()
        }
    }
    func apiCall() {
        viewModel?.fetchCategoriesProductsAndOffers(completion: { result in
            switch result {
            case .success(let apiResponse):
                if let categoryArray = apiResponse["category"] {
                    self.categoryArray = categoryArray as! [[String : Any]]
                }
                if let productsArray = apiResponse["products"] {
                    self.productsArray = productsArray as! [[String : Any]]
                }
                if let productsArray = apiResponse["card_offers"] {
                    self.cardOffersArray = productsArray as! [[String : Any]]
                }
                self.setUpDelegate()
            case .failure(let error):
                print("Failed to fetch data: \(error.localizedDescription)")
            }
        })
        
    }
    @objc func searchButtonAction(_ sender: UIButton) {
        searchTapped = true
        topTitleView.isHidden = true
        topSearchViewView.isHidden = false
        searchCancelButton.isHidden = false
        searchField.isHidden = false
    }
    @objc func cancelButtonAction(_ sender: UIButton) {
        searchTapped = false
        topTitleView.isHidden = false
        topSearchViewView.isHidden = true
        searchCancelButton.isHidden = true
        searchField.isHidden = true
    }
    @objc func offerCellHeight(_ notification: Notification) {
        if notification.name.rawValue == "increase" {
            offerCellHeight = 42
        } else {
            offerCellHeight = 0
        }
        linearLayout.reloadData()
        waterfalllayout.reloadData()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == topCategoriesCollectionView {
            return 1
        } else {
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topCategoriesCollectionView {
            return categoryArray.count
        } else {
            if section == 0 {
                if (self.cardOffersArray.count > 0) {
                    return 1
                } else {
                    return 0
                }
            } else {
                let selectedcategoryFilter = productsArray.filter{$0["category_id"] as! String == selectedCategoryID}
                return selectedcategoryFilter.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topCategoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            let currentdata = categoryArray[indexPath.row]
            cell.categoryLabel.text = currentdata["name"] as? String
            cell.categoryLabel.accessibilityIdentifier = currentdata["name"] as? String
            if indexPath.row == 0 {
                cell.categoryView.backgroundColor =  UIColor(red: 254/255, green: 242/255, blue: 235/255, alpha: 1)
                cell.categoryView.layer.borderColor = UIColor(red: 230/255, green: 86/255, blue: 15/255, alpha: 1).cgColor
                cell.categoryLabel.textColor = UIColor(red: 230/255, green: 86/255, blue: 15/255, alpha: 1)
            } else {
                cell.categoryView.layer.borderColor =  UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1).cgColor
                cell.categoryView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
                cell.categoryLabel.textColor = UIColor(red: 84/255, green: 84/255, blue: 84/255, alpha: 1)
            }
            viewModel?.calculateCellFrame(index: indexPath.row, cell: cell)
            return cell
        } else {
            if indexPath.section == 0 && (self.cardOffersArray.count > 0) {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferListCollectionCell", for: indexPath) as? OfferListCollectionCell else {return UICollectionViewCell()}
                cell.backgroundColor = UIColor.yellow
                cell.cardOffersArray = self.cardOffersArray
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WaterfallListCell", for: indexPath) as? WaterfallListCell else {return UICollectionViewCell()}
                let selectedcategoryFilter = productsArray.filter{$0["category_id"] as! String == selectedCategoryID}
                let currentData = selectedcategoryFilter[indexPath.row]
                cell.updateUI(singleData: currentData)
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topCategoriesCollectionView {
            let currentdata = categoryArray[indexPath.row]
            let labelSize = (currentdata["name"] as! String).boundingRect(with: CGSize(width: 0, height: 32),
                                                                          options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                          attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)],
                                                                          context: nil).size
            return CGSize(width: labelSize.width + 30, height: 32)
        } else {
            if indexPath.section == 0 {
                if (self.cardOffersArray.count > 0) {
                    return CGSize(width: 390, height: 186 + offerCellHeight)
                } else {
                    return CGSize()
                }
            } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WaterfallListCell", for: indexPath) as! WaterfallListCell
                    let cellWidth = (collectionView.frame.width / 2) // Adjust for padding

                    let productName = productsArray[indexPath.row]["name"] as? String ?? ""
                    let nameLabelSize = CGSize(width: cellWidth - 20, height: CGFloat.greatestFiniteMagnitude)
                    let nameLabelRect = productName.boundingRect(with: nameLabelSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)], context: nil)
                    
                    let productDescription = productsArray[indexPath.row]["description"] as? String ?? ""
                    let deliveryLabelSize = CGSize(width: cellWidth - 20, height: CGFloat.greatestFiniteMagnitude)
                    let deliveryLabelRect = productDescription.boundingRect(with: deliveryLabelSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)

                    let totalHeight = 200 + nameLabelRect.height + 18 + 25 + deliveryLabelRect.height + 36 + 20 // additional padding
                let dynamicRect = (viewModel?.calculateWaterFallCellFrame(index: indexPath.row, cell: cell, updatedheight: totalHeight, updatedWidth:cellWidth))!
                cell.frame = dynamicRect
                return CGSize(width: dynamicRect.width, height: dynamicRect.height)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == topCategoriesCollectionView {
            return 5
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == topCategoriesCollectionView {
            return 0
        } else {
            return 5
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topCategoriesCollectionView {
            let currentdata = categoryArray[indexPath.row]
            selectedCategoryID = currentdata["id"] as? String ?? "100023"
            let layoutValue = (currentdata["layout"] as? String) ?? ""
            isLinearLayout = (layoutValue == "waterfall") ? false : true
            linearLayout.isHidden = (isLinearLayout == true) ? false : true
            waterfalllayout.isHidden = (isLinearLayout == true) ? true : false
            
            if isLinearLayout == true {
                linearLayout.delegate = self
                linearLayout.dataSource = self
                linearLayout.reloadData()
            } else {
                waterfalllayout.reloadData()
            }
                        
            for cell in collectionView.visibleCells {
                if let categoryCell = cell as? CategoryCell {
                    categoryCell.categoryView.layer.borderColor =  UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1).cgColor
                    categoryCell.categoryView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
                    categoryCell.categoryLabel.textColor = UIColor(red: 84/255, green: 84/255, blue: 84/255, alpha: 1)
                }
            }
            
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
                cell.categoryView.backgroundColor =  UIColor(red: 254/255, green: 242/255, blue: 235/255, alpha: 1)
                cell.categoryView.layer.borderColor = UIColor(red: 230/255, green: 86/255, blue: 15/255, alpha: 1).cgColor
                cell.categoryLabel.textColor = UIColor(red: 230/255, green: 86/255, blue: 15/255, alpha: 1)
            }
            
        } else {
            // do waterfall card action
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if (self.cardOffersArray.count > 0) {
                return 1
            } else {
                return 0
            }
        } else {
            let selectedcategoryFilter = productsArray.filter{$0["category_id"] as! String == selectedCategoryID}
            return selectedcategoryFilter.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 && (self.cardOffersArray.count > 0){
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OffersListCell")  as? OffersListCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.cardOffersArray = self.cardOffersArray
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LinearListCell") as? LinearListCell  else {
                return UITableViewCell()
            }
            let selectedcategoryFilter = productsArray.filter{$0["category_id"] as! String == selectedCategoryID}
            let currentData = selectedcategoryFilter[indexPath.row]
            cell.selectionStyle = .none
            cell.updateCell(listVlaue: currentData)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            if (self.cardOffersArray.count > 0) {
                return 186 + offerCellHeight
            } else {
                return 0
            }
        } else {
            return 179
        }
    }
    
}
