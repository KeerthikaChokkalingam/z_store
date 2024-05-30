//
//  OfferListCollectionCell.swift
//  zStore
//
//  Created by Keerthika on 26/05/24.
//

import UIKit

class OfferListCollectionCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    weak var topOffersCollectionView: UICollectionView!
    weak var topOffersView: UIView!
    weak var offerIcon: UIImageView!
    weak var offerLabel: UILabel!
    weak var offerSelectedView: UIView!
    weak var offerSelectedLabel: UILabel!
    weak var offerSelectedCard: UILabel!
    weak var offerCloseButton: UIButton!
    var cardOffersArray: [CardOfferResponse]?
    var isSearchApply: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        setUpConstraints()
        setUpDelegate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI()
        setUpConstraints()
        setUpDelegate()
    }
    
    func setUpUI() {
        let topOffersView = UIView()
        topOffersView.translatesAutoresizingMaskIntoConstraints = false
        self.topOffersView = topOffersView
        self.contentView.addSubview(topOffersView)
        
        let offerIcon = UIImageView()
        offerIcon.translatesAutoresizingMaskIntoConstraints = false
        offerIcon.image = UIImage(named: "shape-2")
        self.offerIcon = offerIcon
        self.topOffersView.addSubview(offerIcon)
        
        let offerLabel = UILabel()
        offerLabel.translatesAutoresizingMaskIntoConstraints = false
        offerLabel.text = "Offers"
        offerLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        offerLabel.textColor = UIColor(red: 230/255, green: 86/255, blue: 15/255, alpha: 1)
        self.offerLabel = offerLabel
        self.topOffersView.addSubview(offerLabel)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
        let topOffersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        topOffersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        topOffersCollectionView.showsHorizontalScrollIndicator = false
        self.topOffersCollectionView = topOffersCollectionView
        self.contentView.addSubview(topOffersCollectionView)
        
        let offerSelectedView = UIView()
        offerSelectedView.translatesAutoresizingMaskIntoConstraints = false
        offerSelectedView.isHidden = true
        offerSelectedView.layer.cornerRadius = 16
        offerSelectedView.layer.borderWidth = 1.5
        offerSelectedView.layer.borderColor = UIColor(red: 34/255, green: 106/255, blue: 180/255, alpha: 1).cgColor
        self.offerSelectedView = offerSelectedView
        self.contentView.addSubview(offerSelectedView)
        
        let offerSelectedLabel = UILabel()
        offerSelectedLabel.translatesAutoresizingMaskIntoConstraints = false
        offerSelectedLabel.isHidden = false
        offerSelectedLabel.sizeToFit()
        offerSelectedLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        offerSelectedLabel.textColor = UIColor(red: 84/255, green: 84/255, blue: 84/255, alpha: 1)
        offerSelectedLabel.text = " Applied: "
        self.offerSelectedLabel = offerSelectedLabel
        self.offerSelectedView.addSubview(offerSelectedLabel)
        
        let offerSelectedCard = UILabel()
        offerSelectedCard.translatesAutoresizingMaskIntoConstraints = false
        offerSelectedCard.isHidden = false
        offerSelectedCard.sizeToFit()
        offerSelectedCard.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        offerSelectedCard.textColor = UIColor(red: 34/255, green: 106/255, blue: 180/255, alpha: 1)
        offerSelectedCard.text = ""
        self.offerSelectedCard = offerSelectedCard
        self.offerSelectedView.addSubview(offerSelectedCard)
        
        let offerCloseButton = UIButton()
        offerCloseButton.translatesAutoresizingMaskIntoConstraints = false
        let offerCloseImage = UIImage(named: "Right Icon")
        offerCloseButton.setImage(offerCloseImage, for: .normal)
        offerCloseButton.imageView?.contentMode = .scaleAspectFit
        offerCloseButton.translatesAutoresizingMaskIntoConstraints = false
        offerCloseButton.isHidden = false
        self.offerCloseButton = offerCloseButton
        self.offerSelectedView.addSubview(offerCloseButton)
                
    }
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            topOffersView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topOffersView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            topOffersView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            topOffersView.heightAnchor.constraint(equalToConstant: 44),
            
            offerIcon.centerYAnchor.constraint(equalTo: topOffersView.centerYAnchor),
            offerIcon.leadingAnchor.constraint(equalTo: topOffersView.leadingAnchor),
            offerIcon.heightAnchor.constraint(equalToConstant: 20),
            offerIcon.widthAnchor.constraint(equalToConstant: 20),
            
            offerLabel.centerYAnchor.constraint(equalTo: topOffersView.centerYAnchor),
            offerLabel.leadingAnchor.constraint(equalTo: offerIcon.trailingAnchor, constant: 5),
            offerLabel.heightAnchor.constraint(equalToConstant: 20),
            offerLabel.widthAnchor.constraint(equalToConstant: 273),
            
            topOffersCollectionView.topAnchor.constraint(equalTo: topOffersView.bottomAnchor),
            topOffersCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            topOffersCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topOffersCollectionView.heightAnchor.constraint(equalToConstant: 120),
            
            offerSelectedView.topAnchor.constraint(equalTo: topOffersCollectionView.bottomAnchor,constant: 10),
            offerSelectedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            offerSelectedView.heightAnchor.constraint(equalToConstant: 0),
            offerSelectedView.widthAnchor.constraint(equalToConstant: 285),
            
            offerSelectedLabel.centerYAnchor.constraint(equalTo: offerSelectedView.centerYAnchor),
            offerSelectedLabel.leadingAnchor.constraint(equalTo: offerSelectedView.leadingAnchor, constant: 8),
            offerSelectedLabel.heightAnchor.constraint(equalToConstant: 20),
            
            offerSelectedCard.centerYAnchor.constraint(equalTo: offerSelectedView.centerYAnchor),
            offerSelectedCard.leadingAnchor.constraint(equalTo: offerSelectedLabel.trailingAnchor, constant: 1),
            offerSelectedCard.heightAnchor.constraint(equalToConstant: 20),
            
            offerCloseButton.centerYAnchor.constraint(equalTo: offerSelectedView.centerYAnchor),
            offerCloseButton.leadingAnchor.constraint(equalTo: offerSelectedCard.trailingAnchor, constant: 1),
            offerCloseButton.heightAnchor.constraint(equalToConstant: 18),
            offerCloseButton.widthAnchor.constraint(equalToConstant: 18),
            
            ])
        
    }
    func setUpDelegate() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(selectIndex(_:)), name: NSNotification.Name(rawValue: "selectList"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(selectIndex(_:)), name: NSNotification.Name(rawValue: "UnselectList"), object: nil)
        
        
        topOffersCollectionView.delegate = self
        topOffersCollectionView.dataSource = self
        topOffersCollectionView.register(OfferCardCell.self, forCellWithReuseIdentifier: "OfferCardCell")
        offerCloseButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        topOffersCollectionView.reloadData()
    }
    @objc func selectIndex(_ notification: Notification) {
        if notification.name.rawValue == "selectList" {
            if let userInfo = notification.userInfo,
               let myStruct = userInfo["appliedOffer"] as? CardOfferResponse  {
                if myStruct.cardName == "HDFC Bank Credit card" {
                    let indexPath = IndexPath(row: 0, section: 0)
                    topOffersCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
                    
                } else if  myStruct.cardName == "IFBC Bank Credit card" {
                    let indexPath = IndexPath(row: 1, section: 0)
                    topOffersCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
                    
                } else {
                    let indexPath = IndexPath(row: 2, section: 0)
                    topOffersCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
                }
                offerSelectedCard.text = myStruct.cardName as? String
                offerSelectedView.isHidden = false
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "increase"), object: nil,userInfo: ["appliedOffer": myStruct])
                
                if let heightConstraint = offerSelectedView.constraints.first(where: { $0.firstAttribute == .height }) {
                    let newHeight: CGFloat = 32
                    heightConstraint.constant = newHeight
                }
                if let heightConstraint = offerSelectedLabel.constraints.first(where: { $0.firstAttribute == .height }) {
                    let newHeight: CGFloat = 20
                    heightConstraint.constant = newHeight
                }
                if let heightConstraint = offerSelectedCard.constraints.first(where: { $0.firstAttribute == .height }) {
                    let newHeight: CGFloat = 20
                    heightConstraint.constant = newHeight
                }
                if let heightConstraint = offerCloseButton.constraints.first(where: { $0.firstAttribute == .height }) {
                    let newHeight: CGFloat = 18
                    heightConstraint.constant = newHeight
                }
                if let heightConstraint = offerCloseButton.constraints.first(where: { $0.firstAttribute == .width }) {
                    let newHeight: CGFloat = 18
                    heightConstraint.constant = newHeight
                }
            }
        } else {
            offerSelectedView.isHidden = true
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "decrease"), object: nil,userInfo: ["appliedOffer": CardOfferResponse.self])

            if let heightConstraint = offerSelectedView.constraints.first(where: { $0.firstAttribute == .height }) {
                let newHeight: CGFloat = 0
                heightConstraint.constant = newHeight
            }
            if let heightConstraint = offerSelectedLabel.constraints.first(where: { $0.firstAttribute == .height }) {
                let newHeight: CGFloat = 0
                heightConstraint.constant = newHeight
            }
            if let heightConstraint = offerSelectedCard.constraints.first(where: { $0.firstAttribute == .height }) {
                let newHeight: CGFloat = 0
                heightConstraint.constant = newHeight
            }
            if let heightConstraint = offerCloseButton.constraints.first(where: { $0.firstAttribute == .height }) {
                let newHeight: CGFloat = 0
                heightConstraint.constant = newHeight
            }
        }
    }
    func searchApply () {
        if isSearchApply {
            self.topOffersCollectionView.reloadData()
        }
    }
    @objc func closeButtonTapped() {
        offerSelectedView.isHidden = true
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "decrease"), object: nil,userInfo: ["appliedOffer": CardOfferResponse.self])
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UnselectList"), object: nil,userInfo: ["appliedOffer": CardOfferResponse.self])


        if let heightConstraint = offerSelectedView.constraints.first(where: { $0.firstAttribute == .height }) {
            let newHeight: CGFloat = 0
            heightConstraint.constant = newHeight
        }
        if let heightConstraint = offerSelectedLabel.constraints.first(where: { $0.firstAttribute == .height }) {
            let newHeight: CGFloat = 0
            heightConstraint.constant = newHeight
        }
        if let heightConstraint = offerSelectedCard.constraints.first(where: { $0.firstAttribute == .height }) {
            let newHeight: CGFloat = 0
            heightConstraint.constant = newHeight
        }
        if let heightConstraint = offerCloseButton.constraints.first(where: { $0.firstAttribute == .height }) {
            let newHeight: CGFloat = 0
            heightConstraint.constant = newHeight
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardOffersArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferCardCell", for: indexPath) as! OfferCardCell
        let currentData = self.cardOffersArray?[indexPath.item]
        cell.updateCell(offerResponse: currentData)
        cell.configureCell(data: currentData)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentdata = self.cardOffersArray?[indexPath.item]
        offerSelectedCard.text = currentdata?.cardName as? String
        offerSelectedView.isHidden = false
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "increase"), object: nil,userInfo: ["appliedOffer": currentdata])

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "selectList"), object: nil,userInfo: ["appliedOffer": currentdata])

        
        if let heightConstraint = offerSelectedView.constraints.first(where: { $0.firstAttribute == .height }) {
            let newHeight: CGFloat = 32
            heightConstraint.constant = newHeight
        }
        if let heightConstraint = offerSelectedLabel.constraints.first(where: { $0.firstAttribute == .height }) {
            let newHeight: CGFloat = 20
            heightConstraint.constant = newHeight
        }
        if let heightConstraint = offerSelectedCard.constraints.first(where: { $0.firstAttribute == .height }) {
            let newHeight: CGFloat = 20
            heightConstraint.constant = newHeight
        }
        if let heightConstraint = offerCloseButton.constraints.first(where: { $0.firstAttribute == .height }) {
            let newHeight: CGFloat = 18
            heightConstraint.constant = newHeight
        }
        if let heightConstraint = offerCloseButton.constraints.first(where: { $0.firstAttribute == .width }) {
            let newHeight: CGFloat = 18
            heightConstraint.constant = newHeight
        }
    }
}

