//
//  WaterfallListCell.swift
//  zStore
//
//  Created by Keerthika on 26/05/24.
//

import UIKit
protocol updateTable {
    func updatedData(response: ApiResponse)
}

class WaterfallListCell: UICollectionViewCell {
    
    weak var backView: UIView!
    weak var cardImage: CustomImageView!
    weak var namelabel: UILabel!
    weak var ratingsBgView: UIView!
    weak var ratingView: RatingView!
    weak var ratingLabel: UILabel!
    weak var ratingCount: UILabel!
    weak var priceView: UIView!
    weak var offerPrice: UILabel!
    weak var deliveryLabel: UILabel!
    weak var addToFavView: UIView!
    weak var favIcon: UIImageView!
    weak var topLeftIcon: UIImageView!
    weak var topLeftInnerIcon: UIImageView!
    weak var favILabel: UILabel!
    
    var localInstance: updateTable?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        setUpConstraints()
        setUpGesture()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpUI() {
        let backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.layer.cornerRadius = 15
        backView.backgroundColor = UIColor.red
        self.backView = backView
        contentView.addSubview(backView)
        
        let cardImage = CustomImageView()
        cardImage.translatesAutoresizingMaskIntoConstraints = false
        cardImage.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        cardImage.clipsToBounds = true
        cardImage.isUserInteractionEnabled = true
        self.cardImage = cardImage
        self.backView.addSubview(cardImage)
        
        let namelabel = UILabel()
        namelabel.text = ""
        namelabel.textColor = UIColor.black
        namelabel.font = UIFont(name: "SF Pro Text", size: 18)
        namelabel.translatesAutoresizingMaskIntoConstraints = false
        namelabel.isHidden = false
        namelabel.numberOfLines = 4
        self.namelabel = namelabel
        self.backView.addSubview(namelabel)
        
        let ratingsBgView = UIView()
        ratingsBgView.translatesAutoresizingMaskIntoConstraints = false
        self.ratingsBgView = ratingsBgView
        self.backView.addSubview(ratingsBgView)
        
        let ratingLabel = UILabel()
        ratingLabel.text = ""
        ratingLabel.textColor = UIColor(red: 230/255, green: 86/255, blue: 15/255, alpha: 1)
        ratingLabel.font = UIFont(name: "SF Pro Text", size: 11)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.isHidden = false
        self.ratingLabel = ratingLabel
        self.ratingsBgView.addSubview(ratingLabel)
        
        let ratingView = RatingView()
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        self.ratingView = ratingView
        self.ratingsBgView.addSubview(ratingView)
        
        let ratingCount = UILabel()
        ratingCount.text = ""
        ratingCount.textColor = UIColor(red: 152/255, green: 152/255, blue: 152/255, alpha: 1)
        ratingCount.font = UIFont(name: "SF Pro Text", size: 11)
        ratingCount.translatesAutoresizingMaskIntoConstraints = false
        ratingCount.isHidden = false
        self.ratingCount = ratingCount
        self.ratingsBgView.addSubview(ratingCount)
        
        let priceView = UIView()
        priceView.translatesAutoresizingMaskIntoConstraints = false
        priceView.backgroundColor = UIColor.clear
        self.priceView = priceView
        self.backView.addSubview(priceView)
        
        let offerPrice = UILabel()
        offerPrice.text = ""
        offerPrice.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        offerPrice.font = UIFont(name: "SF Pro Text", size: 20)
        offerPrice.translatesAutoresizingMaskIntoConstraints = false
        offerPrice.isHidden = false
        offerPrice.sizeToFit()
        self.offerPrice = offerPrice
        self.priceView.addSubview(offerPrice)
        
        let deliveryLabel = UILabel()
        deliveryLabel.translatesAutoresizingMaskIntoConstraints = false
        deliveryLabel.font = UIFont(name: "SF Pro Text", size: 8)
        deliveryLabel.textColor = UIColor(red: 116/255, green: 116/255, blue: 116/255, alpha: 1)
        deliveryLabel.numberOfLines = 3
        self.deliveryLabel = deliveryLabel
        self.backView.addSubview(deliveryLabel)
        
        let addToFavView = UIView()
        addToFavView.translatesAutoresizingMaskIntoConstraints = false
        addToFavView.backgroundColor = UIColor.clear
        addToFavView.layer.borderWidth = 1
        addToFavView.layer.cornerRadius = 10
        addToFavView.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1).cgColor
        addToFavView.isHidden = false
        self.addToFavView = addToFavView
        self.backView.addSubview(addToFavView)
        
        let favIcon = UIImageView()
        favIcon.image = UIImage(named: "shape-3")
        favIcon.translatesAutoresizingMaskIntoConstraints = false
        favIcon.contentMode = .scaleAspectFit
        self.favIcon = favIcon
        self.addToFavView.addSubview(favIcon)
        
        let favILabel = UILabel()
        favILabel.translatesAutoresizingMaskIntoConstraints = false
        favILabel.font = UIFont(name: "SF Pro Text", size: 13)
        favILabel.textColor = UIColor(red: 84/255, green: 84/255, blue: 84/255, alpha: 1)
        favILabel.numberOfLines = 0
        favILabel.text = "Add to Fav"
        self.favILabel = favILabel
        self.addToFavView.addSubview(favILabel)
        
        let topLeftIcon = UIImageView()
        topLeftIcon.image = UIImage(named: "Rectangle 3")
        topLeftIcon.translatesAutoresizingMaskIntoConstraints = false
        topLeftIcon.contentMode = .scaleAspectFit
        topLeftIcon.isHidden = true
        topLeftIcon.isUserInteractionEnabled = true
        self.topLeftIcon = topLeftIcon
        self.cardImage.addSubview(topLeftIcon)
        
        let topLeftInnerIcon = UIImageView()
        topLeftInnerIcon.image = UIImage(named: "shape-3")
        topLeftInnerIcon.translatesAutoresizingMaskIntoConstraints = false
        topLeftInnerIcon.contentMode = .scaleAspectFit
        topLeftInnerIcon.isUserInteractionEnabled = true
        self.topLeftInnerIcon = topLeftInnerIcon
        self.topLeftIcon.addSubview(topLeftInnerIcon)
        
    }
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            cardImage.topAnchor.constraint(equalTo: backView.topAnchor),
            cardImage.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            cardImage.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            cardImage.heightAnchor.constraint(equalToConstant: 200),
            
            topLeftIcon.topAnchor.constraint(equalTo: backView.topAnchor),
            topLeftIcon.widthAnchor.constraint(equalToConstant: 75),
            topLeftIcon.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            topLeftIcon.heightAnchor.constraint(equalToConstant: 72),
            
            topLeftInnerIcon.topAnchor.constraint(equalTo: topLeftIcon.topAnchor, constant: 5),
            topLeftInnerIcon.widthAnchor.constraint(equalToConstant: 28),
            topLeftInnerIcon.trailingAnchor.constraint(equalTo: topLeftIcon.trailingAnchor, constant: -5),
            topLeftInnerIcon.heightAnchor.constraint(equalToConstant: 28),
            
            namelabel.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: 10),
            namelabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            namelabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            
            ratingsBgView.topAnchor.constraint(equalTo: namelabel.bottomAnchor),
            ratingsBgView.leadingAnchor.constraint(equalTo: cardImage.leadingAnchor, constant: 10),
            ratingsBgView.trailingAnchor.constraint(equalTo: cardImage.trailingAnchor),
            ratingsBgView.heightAnchor.constraint(equalToConstant: 18),
            
            ratingLabel.topAnchor.constraint(equalTo: ratingsBgView.topAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: ratingsBgView.leadingAnchor),
            ratingLabel.heightAnchor.constraint(equalToConstant: 18),
            ratingLabel.widthAnchor.constraint(equalToConstant: 25),
            
            ratingView.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 5),
            
            ratingCount.topAnchor.constraint(equalTo: ratingsBgView.topAnchor),
            ratingCount.leadingAnchor.constraint(equalTo: ratingView.trailingAnchor, constant: 94),
            ratingCount.heightAnchor.constraint(equalToConstant: 18),
            
            priceView.topAnchor.constraint(equalTo: ratingsBgView.bottomAnchor),
            priceView.leadingAnchor.constraint(equalTo: cardImage.leadingAnchor, constant: 10),
            priceView.trailingAnchor.constraint(equalTo: cardImage.trailingAnchor),
            priceView.heightAnchor.constraint(equalToConstant: 25),
            
            deliveryLabel.topAnchor.constraint(equalTo: priceView.bottomAnchor),
            deliveryLabel.leadingAnchor.constraint(equalTo: cardImage.leadingAnchor, constant: 10),
            deliveryLabel.trailingAnchor.constraint(equalTo: cardImage.trailingAnchor),
            
            addToFavView.topAnchor.constraint(equalTo: deliveryLabel.bottomAnchor, constant: 10),
            addToFavView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            addToFavView.widthAnchor.constraint(equalToConstant: 120),
            addToFavView.heightAnchor.constraint(equalToConstant: 36),
            
            favIcon.centerYAnchor.constraint(equalTo: addToFavView.centerYAnchor),
            favIcon.leadingAnchor.constraint(equalTo: addToFavView.leadingAnchor, constant: 5),
            favIcon.heightAnchor.constraint(equalToConstant: 18),
            favIcon.widthAnchor.constraint(equalToConstant: 20),
            
            favILabel.centerYAnchor.constraint(equalTo: addToFavView.centerYAnchor),
            favILabel.leadingAnchor.constraint(equalTo: favIcon.trailingAnchor, constant: 5),
            
        ])
    }
    func updateUI(singleData: ProductResponse?) {
        namelabel.text = singleData?.name as? String
        let formattedText =  formatProductDescription(singleData?.description as? String ?? "")
        deliveryLabel.text = formattedText // From step 1
        deliveryLabel.font = deliveryLabel.font.withSize(deliveryLabel.font.pointSize)
        
        topLeftIcon.accessibilityIdentifier = singleData?.id
        topLeftIcon.accessibilityHint = "false"
        addToFavView.accessibilityIdentifier = singleData?.id
        addToFavView.accessibilityHint = "true"
        
        deliveryLabel.font = UIFont.boldSystemFont(ofSize: deliveryLabel.font.pointSize)
        ratingLabel.text = convertToString(from: singleData?.rating) ?? ""
        ratingView.rating = convertToInt(from: singleData?.rating) ?? 0
        ratingCount.text = "(" + String(((singleData?.reviewCount as? Int) ?? 0)) + ")"
        offerPrice.text =  "₹" + String(((singleData?.price) ?? 0))
        cardImage.contentMode = .scaleAspectFill
        cardImage.layer.cornerRadius = 13
        if (singleData?.addToFav == true) {
            addToFavView.isHidden = true
            topLeftIcon.isHidden = false
        } else {
            topLeftIcon.isHidden = true
            addToFavView.isHidden = false
        }
        if singleData?.imageUrl != nil && singleData?.imageUrl != "" {
            cardImage.loadImage(urlString: (singleData?.imageUrl as? String) ?? "" )
        }
    }
    func convertToInt(from value: Any?) -> Int? {
        if let floatValue = value as? Float {
            return Int(floatValue)
        } else if let doubleValue = value as? Double {
            return Int(doubleValue)
        } else if let intValue = value as? Int {
            return intValue
        } else if let stringValue = value as? String, let doubleFromString = Double(stringValue) {
            return Int(doubleFromString)
        }
        return nil
    }
    func convertToString(from value: Any?) -> String? {
        if let floatValue = value as? Float {
            return String(floatValue)
        } else if let doubleValue = value as? Double {
            return String(doubleValue)
        } else if let intValue = value as? Int {
            return String(intValue)
        } else if let stringValue = value as? String {
            return stringValue
        }
        return nil
    }
    func formatProductDescription(_ description: String) -> String {
        var formattedDescription = ""
        let components = description.components(separatedBy: "\n")

        for component in components {
            if let boldRange = component.range(of: "**") {
                let boldText = String(component[..<boldRange.lowerBound])
                let remainingText = String(component[boldRange.upperBound...])
                formattedDescription.append("\(boldText)\(remainingText)")
            } else {
                formattedDescription.append("\(component)")
            }
        }

        return formattedDescription
    }
    // asign gesture
    func setUpGesture() {
        var removeFromfavoriteGesture = UITapGestureRecognizer(target: self, action: #selector(handleRemoveTap(_:)))
        topLeftIcon.isUserInteractionEnabled = true
        removeFromfavoriteGesture.numberOfTapsRequired = 1
        topLeftIcon.addGestureRecognizer(removeFromfavoriteGesture)
        var addfavoriteGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addToFavView.isUserInteractionEnabled = true
        addfavoriteGesture.numberOfTapsRequired = 1
        addToFavView.addGestureRecognizer(addfavoriteGesture)
    }
    // gesture function
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            guard let view = gesture.view else { return }
            
        if let trackingString = view.accessibilityIdentifier {
            if let uiApproach = view.accessibilityHint {
                CoredataBase.shared.getFavoriteAndUpdate(categoryId: trackingString, isFavorite: Bool(uiApproach) ?? false)
                let newValue = CoredataBase.shared.fetchCoreDataValues()
                if localInstance != nil {
                    localInstance?.updatedData(response: newValue ?? ApiResponse())
                }
                print("Tapped on view with tracking string: \(trackingString)")
            } } else {
                print("Tapped on view with no tracking string.")
            }
        }
    @objc func handleRemoveTap(_ gesture: UITapGestureRecognizer) {
            guard let view = gesture.view else { return }
            
            if let trackingString = view.accessibilityIdentifier {
                if let uiApproach = view.accessibilityHint {
                    CoredataBase.shared.getFavoriteAndUpdate(categoryId: trackingString, isFavorite: Bool(uiApproach) ?? false)
                    let newValue = CoredataBase.shared.fetchCoreDataValues()
                    if localInstance != nil {
                        localInstance?.updatedData(response: newValue ?? ApiResponse())
                    }
                    print("Tapped on view with tracking string: \(trackingString)")
                }
            } else {
                print("Tapped on view with no tracking string.")
            }
        }
}

