//
//  LinearListCell.swift
//  zStore
//
//  Created by Keerthika on 26/05/24.
//

import UIKit

class LinearListCell: UITableViewCell {

    weak var backView: UIView!
    weak var cardImage: CustomImageView!
    weak var namelabel: UILabel!
    weak var ratingsBgView: UIView!
    weak var ratingView: RatingView!
    weak var ratingLabel: UILabel!
    weak var ratingCount: UILabel!
    weak var priceView: UIView!
    weak var offerPrice: UILabel!
    weak var actualPrice: UILabel!
    weak var savingPrice: UIButton!
    weak var deliveryLabel: UILabel!
    weak var availableColorView: UIView!
    
    var listValue = [String:Any]()

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//    func configureCell(with colors: [String]) {
//        colorDisplayView.configure(with: colors)
//    }
    func setupUI() {
            let backView = UIView()
            backView.translatesAutoresizingMaskIntoConstraints = false
            backView.layer.cornerRadius = 15
            backView.backgroundColor = UIColor.brown
            self.backView = backView
            contentView.addSubview(backView)
            
            let cardImage = CustomImageView()
            cardImage.translatesAutoresizingMaskIntoConstraints = false
            cardImage.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
            cardImage.clipsToBounds = true
            self.cardImage = cardImage
            self.backView.addSubview(cardImage)
            
            let namelabel = UILabel()
            namelabel.text = ""
            namelabel.textColor = UIColor.black
            namelabel.font = UIFont(name: "SF Pro Text", size: 18)
            namelabel.translatesAutoresizingMaskIntoConstraints = false
            namelabel.isHidden = false
            namelabel.numberOfLines = 0
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
            
            let actualPrice = UILabel()
            actualPrice.font = UIFont(name: "SF Pro Text", size: 13)
            actualPrice.translatesAutoresizingMaskIntoConstraints = false
            actualPrice.isHidden = false
            actualPrice.sizeToFit()
            
            let attributes: [NSAttributedString.Key: Any] = [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor(red: 152/255, green: 152/255, blue: 152/255, alpha: 1),
                .font: actualPrice.font!
            ]
            let attributedString = NSAttributedString(string: "₹" + "64,999", attributes: attributes)
            actualPrice.attributedText = attributedString
            self.actualPrice = actualPrice
            self.priceView.addSubview(actualPrice)
            
            let savingPrice = UIButton(type: .custom)
        savingPrice.translatesAutoresizingMaskIntoConstraints = false
            savingPrice.setTitle("Save ₹2000", for: .normal)
            savingPrice.backgroundColor = UIColor(red: 21/255, green: 140/255, blue: 91/255, alpha: 1)
            savingPrice.setTitleColor(UIColor.white, for: .normal)
            savingPrice.titleLabel?.font = UIFont(name: "SF Pro Text", size: 9)
            savingPrice.layer.cornerRadius = 13
        savingPrice.sizeToFit()
        savingPrice.titleLabel?.textAlignment = .center
            self.savingPrice = savingPrice
            self.priceView.addSubview(savingPrice)
        
        let deliveryLabel = UILabel()
        deliveryLabel.translatesAutoresizingMaskIntoConstraints = false
        deliveryLabel.font = UIFont(name: "SF Pro Text", size: 8)
        deliveryLabel.textColor = UIColor(red: 116/255, green: 116/255, blue: 116/255, alpha: 1)
        deliveryLabel.numberOfLines = 0
        self.deliveryLabel = deliveryLabel
        self.backView.addSubview(deliveryLabel)
        
        let availableColorView = UIView()
        availableColorView.translatesAutoresizingMaskIntoConstraints = false
        availableColorView.backgroundColor = UIColor.yellow
        self.availableColorView = availableColorView
        self.backView.addSubview(availableColorView)
        
//        let colorDisplayView = ColorDisplayView()
//        colorDisplayView.translatesAutoresizingMaskIntoConstraints = false
//        colorDisplayView.backgroundColor = UIColor.yellow
//        self.colorDisplayView = colorDisplayView
//        self.availableColorView.addSubview(colorDisplayView)
        
        }
        
        func setUpConstraints() {
            NSLayoutConstraint.activate([
                backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
                backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
                backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
                
                cardImage.topAnchor.constraint(equalTo: backView.topAnchor, constant: 15),
                cardImage.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15),
                cardImage.heightAnchor.constraint(equalToConstant: 90),
                cardImage.widthAnchor.constraint(equalToConstant: 90),
                
                namelabel.topAnchor.constraint(equalTo: cardImage.topAnchor, constant: -5),
                namelabel.leadingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: 10),
                namelabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
                namelabel.heightAnchor.constraint(equalToConstant: 70),
                
                ratingsBgView.topAnchor.constraint(equalTo: namelabel.bottomAnchor),
                ratingsBgView.leadingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: 10),
                ratingsBgView.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
                ratingsBgView.heightAnchor.constraint(equalToConstant: 18),
                
                ratingLabel.topAnchor.constraint(equalTo: ratingsBgView.topAnchor),
                ratingLabel.leadingAnchor.constraint(equalTo: ratingsBgView.leadingAnchor),
                ratingLabel.heightAnchor.constraint(equalToConstant: 18),
                ratingLabel.widthAnchor.constraint(equalToConstant: 25),
                
                ratingView.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 5),
                
                ratingCount.topAnchor.constraint(equalTo: ratingsBgView.topAnchor),
                ratingCount.leadingAnchor.constraint(equalTo: ratingView.trailingAnchor, constant: 94),
                ratingCount.heightAnchor.constraint(equalToConstant: 18),
                
                priceView.topAnchor.constraint(equalTo: ratingCount.bottomAnchor),
                priceView.leadingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: 10),
                priceView.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
                priceView.heightAnchor.constraint(equalToConstant: 25),
                
                offerPrice.centerYAnchor.constraint(equalTo: priceView.centerYAnchor),
                offerPrice.leadingAnchor.constraint(equalTo: priceView.leadingAnchor),
                
                actualPrice.centerYAnchor.constraint(equalTo: priceView.centerYAnchor),
                actualPrice.leadingAnchor.constraint(equalTo: offerPrice.trailingAnchor, constant: 5),
                
                savingPrice.centerYAnchor.constraint(equalTo: priceView.centerYAnchor),
                savingPrice.leadingAnchor.constraint(equalTo: actualPrice.trailingAnchor, constant: 5),
                savingPrice.widthAnchor.constraint(equalToConstant: 100),
                savingPrice.heightAnchor.constraint(equalToConstant: 22),
                
                deliveryLabel.topAnchor.constraint(equalTo: priceView.bottomAnchor),
                deliveryLabel.leadingAnchor.constraint(equalTo: priceView.leadingAnchor),
                deliveryLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
                deliveryLabel.heightAnchor.constraint(equalToConstant: 18),
                
                availableColorView.topAnchor.constraint(equalTo: deliveryLabel.bottomAnchor),
                availableColorView.leadingAnchor.constraint(equalTo: priceView.leadingAnchor),
                availableColorView.trailingAnchor.constraint(equalTo: priceView.leadingAnchor),
                availableColorView.heightAnchor.constraint(equalToConstant: 28),
                
//                colorDisplayView.topAnchor.constraint(equalTo: availableColorView.topAnchor),
//                colorDisplayView.leadingAnchor.constraint(equalTo: availableColorView.leadingAnchor),
//                colorDisplayView.trailingAnchor.constraint(equalTo: availableColorView.leadingAnchor),
//                colorDisplayView.heightAnchor.constraint(equalToConstant: 28),
                
            ])
        }

    func updateCell(listVlaue: ProductResponse?) {
        namelabel.text = listVlaue?.name as? String
        let formattedText =  formatProductDescription(listVlaue?.description as? String ?? "")
        deliveryLabel.text = formattedText 
        deliveryLabel.font = deliveryLabel.font.withSize(deliveryLabel.font.pointSize)
        
//        configureCell(with: listVlaue?.colors as? [String] ?? [])

        deliveryLabel.font = UIFont.boldSystemFont(ofSize: deliveryLabel.font.pointSize)
        ratingLabel.text = convertToString(from: listVlaue?.rating) ?? ""
        ratingView.rating = convertToInt(from: listVlaue?.rating) ?? 0
        ratingCount.text = "(" + String(((listVlaue?.reviewCount as? Int) ?? 0)) + ")"
        offerPrice.text =  "₹" + String(((listVlaue?.price as? Int) ?? 0))
        cardImage.contentMode = .scaleAspectFill
        cardImage.layer.cornerRadius = 13
        if listVlaue?.imageUrl != nil && listVlaue?.imageUrl != "" {
            cardImage.loadImage(urlString: (listVlaue?.imageUrl as? String) ?? "" )
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
    
}
