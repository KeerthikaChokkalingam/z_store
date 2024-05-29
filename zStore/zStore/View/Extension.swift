//
//  DashboardExtension.swift
//  zStore
//
//  Created by Keerthika on 25/05/24.
//
weak var searchField: UITextField!
weak var searchCancelButton: UIButton!
import UIKit

extension ViewController {
    func setUpUI(){
        
        self.view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        
        let backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        self.backView = backView
        self.view.addSubview(backView)
        
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        self.topView = topView
        self.backView.addSubview(topView)
        
        
        let topTitleView = UIView()
        topTitleView.translatesAutoresizingMaskIntoConstraints = false
        topTitleView.isHidden = false
        self.topTitleView = topTitleView
        self.topView.addSubview(topTitleView)
        
        let topTitlelabel = UILabel()
        topTitlelabel.text = "Zstore"
        topTitlelabel.textColor = UIColor.black
        topTitlelabel.font = UIFont.systemFont(ofSize: 30, weight: .init(700))
        topTitlelabel.sizeToFit()
        topTitlelabel.translatesAutoresizingMaskIntoConstraints = false
        topTitlelabel.isHidden = false
        self.topTitlelabel = topTitlelabel
        self.topTitleView.addSubview(topTitlelabel)
        
        let searchButton = UIButton()
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        let searchImage = UIImage(named: "shape")
        searchButton.setImage(searchImage, for: .normal)
        searchButton.imageView?.contentMode = .scaleAspectFit
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.isHidden = false
        self.searchButton = searchButton
        self.topTitleView.addSubview(searchButton)
        
        let topSearchViewView = UIView()
        topSearchViewView.translatesAutoresizingMaskIntoConstraints = false
        topSearchViewView.isHidden = true
        self.topSearchViewView = topSearchViewView
        self.topView.addSubview(topSearchViewView)
        
        
        let searchCancelButton = UIButton(type: .custom)
        searchCancelButton.translatesAutoresizingMaskIntoConstraints = false
        searchCancelButton.setTitle("Cancel", for: .normal)
        searchCancelButton.setTitleColor(UIColor(red: 230/255, green: 86/255, blue: 15/255, alpha: 1), for: .normal)
        searchCancelButton.titleLabel?.font = UIFont(name: "SF Pro Text", size: 17)
        searchCancelButton.isHidden = true
        self.searchCancelButton = searchCancelButton
        self.topSearchViewView.addSubview(searchCancelButton)
        
        let searchField = UITextField()
        searchField.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        searchField.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1).cgColor
        searchField.layer.borderWidth = 1
        searchField.font = UIFont(name: "SF Pro Text", size: 15)
        searchField.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        searchField.layer.cornerRadius = 18
        searchField.clearButtonMode = .whileEditing
        searchField.isHidden = true
        searchField.translatesAutoresizingMaskIntoConstraints = false
        
        let searchIconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24))
        searchIconContainerView.contentMode = .scaleAspectFit
        let searchImageView = UIImageView(image: UIImage(named: "shape"))
        searchImageView.contentMode = .scaleAspectFit
        searchImageView.frame = CGRect(x: 11, y: 3, width: 18, height: 18)
        searchIconContainerView.addSubview(searchImageView)
        searchField.leftView = searchIconContainerView
        searchField.leftViewMode = .always
        
        self.searchField = searchField
        self.topSearchViewView.addSubview(searchField)
        
        let topCategoriesView = UIView()
        topCategoriesView.translatesAutoresizingMaskIntoConstraints = false
        self.topCategoriesView = topCategoriesView
        self.backView.addSubview(topCategoriesView)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)

        let topCategoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        topCategoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        topCategoriesCollectionView.showsHorizontalScrollIndicator = false
        self.topCategoriesCollectionView = topCategoriesCollectionView
        self.topCategoriesView.addSubview(topCategoriesCollectionView)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView = contentView
        self.backView.addSubview(contentView)
        
        let waterFallLayout = UICollectionViewFlowLayout()
        waterFallLayout.minimumInteritemSpacing = 2
        waterFallLayout.minimumLineSpacing = 4
        waterFallLayout.scrollDirection = .vertical
        waterFallLayout.sectionInset = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        
        let waterfalllayout = UICollectionView(frame: .zero, collectionViewLayout: waterFallLayout)
        waterfalllayout.showsVerticalScrollIndicator = false
        waterfalllayout.translatesAutoresizingMaskIntoConstraints = false
        waterfalllayout.isHidden = false
        self.waterfalllayout = waterfalllayout
        self.contentView.addSubview(waterfalllayout)
        
        let linearLayout = UITableView()
        linearLayout.showsVerticalScrollIndicator = false
        linearLayout.translatesAutoresizingMaskIntoConstraints = false
        linearLayout.separatorStyle = .none
        linearLayout.separatorColor = .clear
        linearLayout.isHidden = true
        self.linearLayout = linearLayout
        self.contentView.addSubview(linearLayout)
        
        let sortFloatingButton = UIButton()
        sortFloatingButton.translatesAutoresizingMaskIntoConstraints = false
        let sortImage = UIImage(named: "shape-4")
        sortFloatingButton.setImage(sortImage, for: .normal)
        sortFloatingButton.backgroundColor = UIColor(red: 230/255, green: 86/255, blue: 15/255, alpha: 1)
        sortFloatingButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        sortFloatingButton.layer.cornerRadius = 25
        sortFloatingButton.imageView?.contentMode = .scaleAspectFit
        sortFloatingButton.translatesAutoresizingMaskIntoConstraints = false
        sortFloatingButton.isHidden = false
        self.sortFloatingButton = sortFloatingButton
        self.backView.addSubview(sortFloatingButton)
        self.backView.bringSubviewToFront(sortFloatingButton)
        
        self.searchField.delegate = self
        self.searchField.text = ""
        
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = UIColor.darkGray
        self.indicatorView = indicator
        self.backView.addSubview(indicator)
        self.backView.bringSubviewToFront(indicator)
        
    }
    
    func setupConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            backView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            backView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            topView.topAnchor.constraint(equalTo: self.backView.topAnchor),
            topView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 44),
            
            topTitleView.topAnchor.constraint(equalTo: self.topView.topAnchor),
            topTitleView.leadingAnchor.constraint(equalTo: self.topView.leadingAnchor),
            topTitleView.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor),
            topTitleView.heightAnchor.constraint(equalTo: self.topView.heightAnchor),
            
            topTitlelabel.centerYAnchor.constraint(equalTo: self.topView.centerYAnchor),
            topTitlelabel.leadingAnchor.constraint(equalTo: self.topView.leadingAnchor, constant: 8),
            topTitlelabel.heightAnchor.constraint(equalToConstant: 36),
            
            searchButton.centerYAnchor.constraint(equalTo: self.topView.centerYAnchor),
            searchButton.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor, constant: -8),
            searchButton.heightAnchor.constraint(equalToConstant: 21),
            searchButton.widthAnchor.constraint(equalToConstant: 21),
            
            topSearchViewView.topAnchor.constraint(equalTo: self.topView.topAnchor),
            topSearchViewView.leadingAnchor.constraint(equalTo: self.topView.leadingAnchor),
            topSearchViewView.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor),
            topSearchViewView.heightAnchor.constraint(equalTo: self.topView.heightAnchor),
            
            searchCancelButton.centerYAnchor.constraint(equalTo: self.topView.centerYAnchor),
            searchCancelButton.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor, constant: -8),
            searchCancelButton.heightAnchor.constraint(equalToConstant: 20),
            searchCancelButton.widthAnchor.constraint(equalToConstant: 56),
            
            searchField.centerYAnchor.constraint(equalTo: self.topView.centerYAnchor),
            searchField.leadingAnchor.constraint(equalTo: self.topView.leadingAnchor, constant: 8),
            searchField.trailingAnchor.constraint(equalTo: self.searchCancelButton.leadingAnchor, constant: -5),
            searchField.heightAnchor.constraint(equalToConstant: 36),
    
            topCategoriesView.topAnchor.constraint(equalTo: self.topView.bottomAnchor,constant: 10),
            topCategoriesView.leadingAnchor.constraint(equalTo: self.topView.leadingAnchor, constant: 12),
            topCategoriesView.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor, constant: -12),
            topCategoriesView.heightAnchor.constraint(equalToConstant: 86),
            
            topCategoriesCollectionView.topAnchor.constraint(equalTo: self.topCategoriesView.topAnchor),
            topCategoriesCollectionView.leadingAnchor.constraint(equalTo: self.topCategoriesView.leadingAnchor),
            topCategoriesCollectionView.trailingAnchor.constraint(equalTo: self.topCategoriesView.trailingAnchor),
            topCategoriesCollectionView.heightAnchor.constraint(equalTo: self.topCategoriesView.heightAnchor),            
            
            contentView.topAnchor.constraint(equalTo: self.topCategoriesCollectionView.bottomAnchor, constant: 10),
            contentView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor),
            
            waterfalllayout.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            waterfalllayout.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            waterfalllayout.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            waterfalllayout.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            linearLayout.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            linearLayout.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            linearLayout.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            linearLayout.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            sortFloatingButton.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -30),
            sortFloatingButton.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -10),
            sortFloatingButton.widthAnchor.constraint(equalToConstant: 50),
            sortFloatingButton.heightAnchor.constraint(equalToConstant: 50),
            
            indicatorView.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            indicatorView.heightAnchor.constraint(equalToConstant: 100),
            indicatorView.widthAnchor.constraint(equalToConstant: 100),
           
        ])
    }
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.indicatorView.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        indicatorView.stopAnimating()
    }
    
}
extension ViewController: updateTable {
    func updatedData(response: ApiResponse) {
        var selectedCategpryvalues = CoredataBase.shared.fetchCoreDataValues(elementId: selectedCategoryID)
        uiMappingValue?.products = selectedCategpryvalues?.products
        DispatchQueue.main.async {
            if self.isLinearLayout {
                self.linearLayout.reloadData()
            } else {
                self.waterfalllayout.reloadData()
            }
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Get the updated text
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // Perform the search
        if updatedText.isEmpty || updatedText == ""{
            self.uiMappingValue = self.sortBase
        } else {
            let selectedcategoryFilter = self.copySearchBase?.products?.filter{$0.categoryId == selectedCategoryID}

            let productData = selectedcategoryFilter?.filter { $0.name.lowercased().contains(updatedText.lowercased()) }
            let offerData = self.copySearchBase?.cardOffers?.filter { $0.cardName.lowercased().contains(updatedText.lowercased()) }
            
            if (productData?.count == 0 || productData == nil) && (offerData?.count == 0 || offerData == nil){
                self.uiMappingValue = ApiResponse()
            } else {
                self.uiMappingValue?.products = productData
                self.uiMappingValue?.cardOffers = offerData
            }
            
        }
        
        if isLinearLayout == true {
            self.reloadOffersCell = true
            self.linearLayout.reloadData()
        } else {
            self.reloadOffersCell = true
            self.waterfalllayout.reloadData()
        }
        
        return true
    }

}
extension ViewController: SortViewDelegate {
    func didSelectSortOption(_ option: String) {
        if let tempView = self.view.viewWithTag(30) {
            tempView.removeFromSuperview()
        }
        currentSort = option
        if option == "ratings" {
            let selectedcategoryFilter = self.copySearchBase?.products?.filter{$0.categoryId == selectedCategoryID}
            let sortedProducts = selectedcategoryFilter?.sorted { $0.rating > $1.rating }
            self.uiMappingValue?.products = sortedProducts
            
            if isLinearLayout == true {
                self.reloadOffersCell = true
                self.linearLayout.reloadData()
            } else {
                self.reloadOffersCell = true
                self.waterfalllayout.reloadData()
            }
        } else {
            let selectedcategoryFilter = self.copySearchBase?.products?.filter{$0.categoryId == selectedCategoryID}
            let sortedProducts = selectedcategoryFilter?.sorted { $0.price > $1.price }
            self.uiMappingValue?.products = sortedProducts
            
            if isLinearLayout == true {
                self.reloadOffersCell = true
                self.linearLayout.reloadData()
            } else {
                self.reloadOffersCell = true
                self.waterfalllayout.reloadData()
            }
        }
    }
    
}
extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchedView = touch.view, touchedView.isDescendant(of: self.view.viewWithTag(30)!) {
            return touchedView.tag == 30
        }
        return true
    }
}
