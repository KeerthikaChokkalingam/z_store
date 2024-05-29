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
    weak var sortFloatingButton: UIButton!
    weak var indicatorView: UIActivityIndicatorView!
    
    var viewModel: ContrllerViewModel?
    var searchTapped: Bool = false
    var isLinearLayout: Bool = false
    var reloadOffersCell: Bool = false
    var currentSort: String = "ratings"
    var offerCellHeight: CGFloat = 0
    var selectedCategoryID: String = "100023"
    var uiMappingValue: ApiResponse?
    var copySearchBase: ApiResponse?
    var sortBase: ApiResponse?
    let cellSpacing: CGFloat = 10


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
        self.sortFloatingButton.addTarget(self, action: #selector(showSortView(_:)), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(offerCellHeight(_:)), name: NSNotification.Name(rawValue: "increase"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(offerCellHeight(_:)), name: NSNotification.Name(rawValue: "decrease"), object: nil)


    }
    func setUpDelegate() {
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
    func apiCall() {
        showActivityIndicator()
        viewModel?.checkData(completion: { result in
            switch result {
            case .success(let apiResponse):
                self.uiMappingValue = apiResponse
                self.copySearchBase = apiResponse
                self.sortBase = apiResponse
                let selectedcategoryFilter = apiResponse.products?.filter{$0.categoryId == self.selectedCategoryID}
                let sortedProducts = selectedcategoryFilter?.sorted { $0.rating > $1.rating }
                self.uiMappingValue?.products = sortedProducts
                DispatchQueue.main.async {
                    self.setUpDelegate()
                    self.hideActivityIndicator()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.hideActivityIndicator()
                }
                print("Failed to fetch data: \(error.localizedDescription)")
            }
        })
        
    }
    func ratingsSort(sortString: String) {
        if sortString == "ratings" {
            let selectedcategoryFilter = self.copySearchBase?.products?.filter{$0.categoryId == selectedCategoryID}
            let sortedProducts = selectedcategoryFilter?.sorted { $0.rating > $1.rating }
            self.uiMappingValue?.products = sortedProducts
        } else {
            let selectedcategoryFilter = self.copySearchBase?.products?.filter{$0.categoryId == selectedCategoryID}
            let sortedProducts = selectedcategoryFilter?.sorted { $0.price > $1.price }
            self.uiMappingValue?.products = sortedProducts
        }
        
        if isLinearLayout == true {
            linearLayout.delegate = self
            linearLayout.dataSource = self
            linearLayout.reloadData()
        } else  {
            waterfalllayout.reloadData()
        }
              
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
        self.searchField.text = ""
        self.searchField.resignFirstResponder()
        self.view.endEditing(true)
        
        self.uiMappingValue = self.copySearchBase
        if isLinearLayout == true {
            self.reloadOffersCell = true
            self.linearLayout.reloadData()
        } else {
            self.reloadOffersCell = true
            self.waterfalllayout.reloadData()
        }
        
    }
    @objc func showSortView(_ sender: UIButton) {
        let temporaryView = UIView()
        temporaryView.frame = self.view.bounds
        temporaryView.backgroundColor = UIColor(red: 8/255, green: 21/255, blue: 36/255, alpha: 0.6)
        let sortView = SortView(frame: CGRect(x: sender.frame.maxX - (250 + 30), y: sender.frame.minY - 157, width: 270, height: 167))
        sortView.selectedValue = currentSort
        sortView.clipsToBounds = true
        sortView.layer.cornerRadius = 23
        sortView.delegate = self
        temporaryView.tag = 30
        temporaryView.addSubview(sortView)
        temporaryView.bringSubviewToFront(sortView)
        self.view.addSubview(temporaryView)
        self.view.bringSubviewToFront(temporaryView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeSortView(_:)))
        tapGesture.delegate = self
        temporaryView.isUserInteractionEnabled = true
        temporaryView.addGestureRecognizer(tapGesture)
    }
    @objc func removeSortView(_ sender: UITapGestureRecognizer) {
        if let backgroundView = self.view.viewWithTag(30) {
            backgroundView.removeFromSuperview()
        }
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
            return uiMappingValue?.category?.count ?? 0
        } else {
            if section == 0 {
                if ((self.uiMappingValue?.cardOffers?.count ?? 0) > 0) {
                    return 1
                } else {
                    return 0
                }
            } else {
                return self.uiMappingValue?.products?.count ?? 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topCategoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            let currentdata = self.uiMappingValue?.category?[indexPath.row]
            cell.categoryLabel.text = currentdata?.name
            cell.categoryLabel.accessibilityIdentifier = currentdata?.name
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
            if indexPath.section == 0 && ((self.uiMappingValue?.cardOffers?.count ?? 0) > 0) {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferListCollectionCell", for: indexPath) as? OfferListCollectionCell else {return UICollectionViewCell()}
                cell.isSearchApply = reloadOffersCell
                if reloadOffersCell {
                    cell.searchApply()
                }
                if let cardOffers = self.uiMappingValue?.cardOffers {
                    cell.cardOffersArray = cardOffers
                }
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WaterfallListCell", for: indexPath) as? WaterfallListCell else {return UICollectionViewCell()}
                if (self.uiMappingValue?.products?.count ?? 0) > indexPath.row {
                    let currentData = self.uiMappingValue?.products?[indexPath.row]
                    cell.updateUI(singleData: currentData)
                }
                cell.localInstance = self
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topCategoriesCollectionView {
            let currentdata = self.uiMappingValue?.category?[indexPath.row]
            let labelSize = (currentdata?.name as? String)?.boundingRect(with: CGSize(width: 0, height: 32),
                                                                          options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                          attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)],
                                                                          context: nil).size
            return CGSize(width: labelSize!.width + 30, height: 32)
        } else {
            if indexPath.section == 0 {
                if ((self.uiMappingValue?.cardOffers?.count ?? 0) > 0) {
                    return CGSize(width: 390, height: 186 + offerCellHeight)
                } else { return CGSize(width: 0, height: 0)}
            } else {
                let selectedcategoryFilter = self.uiMappingValue?.products?.filter { $0.categoryId == selectedCategoryID }
                let currentData = selectedcategoryFilter?[indexPath.row]
                let productName = currentData?.name ?? ""
                let nameLabelFont = UIFont.systemFont(ofSize: 14)
                let nameLabelLineHeight = nameLabelFont.lineHeight
                let maxNameLabelHeight = nameLabelLineHeight * 4
                let nameLabelSize = CGSize(width:((self.view.frame.size.width/2) - 20), height: CGFloat.greatestFiniteMagnitude)
                var nameLabelRect = productName.boundingRect(with: nameLabelSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: nameLabelFont], context: nil)
                nameLabelRect.size.height = min(nameLabelRect.size.height, maxNameLabelHeight)
                let productDescription = currentData?.description ?? ""
                let deliveryLabelFont = UIFont.boldSystemFont(ofSize: 12)
                let deliveryLabelLineHeight = deliveryLabelFont.lineHeight
                let maxDeliveryLabelHeight = deliveryLabelLineHeight * 3
                let deliveryLabelSize = CGSize(width: ((self.view.frame.size.width/2) - 20), height: CGFloat.greatestFiniteMagnitude)
                var deliveryLabelRect = productDescription.boundingRect(with: deliveryLabelSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: deliveryLabelFont], context: nil)
                deliveryLabelRect.size.height = min(deliveryLabelRect.size.height, maxDeliveryLabelHeight)
                let totalHeight = 200 + nameLabelRect.height + 10 + 18 + 25 + deliveryLabelRect.height + 36 + 40
                
                return CGSize(width: (self.view.frame.size.width/2) - 10, height: totalHeight)
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
            let currentdata = self.uiMappingValue?.category?[indexPath.row]
            selectedCategoryID = currentdata?.id as? String ?? "100023"
            let layoutValue = (currentdata?.layout as? String) ?? ""
            isLinearLayout = (layoutValue == "waterfall") ? false : true
            linearLayout.isHidden = (isLinearLayout == true) ? false : true
            waterfalllayout.isHidden = (isLinearLayout == true) ? true : false
            if searchField.text != "" {
                searchField.text = ""
            }
            
            ratingsSort(sortString: currentSort)


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
            if ((self.uiMappingValue?.cardOffers?.count ?? 0) > 0) {
                return 1
            } else {
                return 0
            }
        } else {
            return self.uiMappingValue?.products?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 && ((self.uiMappingValue?.cardOffers?.count ?? 0) > 0){
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OffersListCell")  as? OffersListCell else {
                return UITableViewCell()
            }
            cell.isSearchApply = reloadOffersCell
            if reloadOffersCell {
                cell.searchApply()
            }
            cell.selectionStyle = .none
            if let cardOffers = self.uiMappingValue?.cardOffers {
                cell.cardOffersArray = cardOffers
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LinearListCell") as? LinearListCell  else {
                return UITableViewCell()
            }
            let currentData = self.uiMappingValue?.products?[indexPath.row]
            cell.selectionStyle = .none
            cell.updateCell(listVlaue: currentData)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            if ((self.uiMappingValue?.cardOffers?.count ?? 0) > 0) {
                return 186 + offerCellHeight
            } else {
                return 0
            }
        } else {
            return 179
        }
    }
    
}
