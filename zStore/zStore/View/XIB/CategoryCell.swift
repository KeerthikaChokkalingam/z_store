//
//  CategoryCell.swift
//  zStore
//
//  Created by Keerthika on 25/05/24.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    weak var categoryView: UIView!
    weak var categoryLabel: UILabel!
    
    var gettedWidth: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUI()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeUI()
        setUpConstraints()
    }
    
    func initializeUI() {
        
        let categoryView = UIView()
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        categoryView.layer.borderColor =  UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1).cgColor
        categoryView.layer.borderWidth = 1.5
        categoryView.layer.cornerRadius = 16
        categoryView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        self.categoryView = categoryView

        self.contentView.addSubview(categoryView)
        
        let categoryLabel = UILabel()
        categoryLabel.textColor = UIColor.black
        categoryLabel.font = UIFont(name: "SF Pro Text", size: 15)
        categoryLabel.sizeToFit()
        categoryLabel.textAlignment = .center
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.textColor = UIColor(red: 84/255, green: 84/255, blue: 84/255, alpha: 1)
        
        self.categoryLabel = categoryLabel
        self.categoryView.addSubview(categoryLabel)
    }
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            categoryView.topAnchor.constraint(equalTo: self.topAnchor),
            categoryView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            categoryView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            categoryView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            categoryLabel.centerYAnchor.constraint(equalTo: categoryView.centerYAnchor),
            categoryLabel.centerXAnchor.constraint(equalTo: categoryView.centerXAnchor),
            categoryLabel.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
}
