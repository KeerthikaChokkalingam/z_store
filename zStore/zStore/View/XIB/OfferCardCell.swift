//
//  OfferCardCell.swift
//  zStore
//
//  Created by Keerthika on 26/05/24.
//

import UIKit

class OfferCardCell: UICollectionViewCell {

    weak var backView: UIView!
    weak var cardname: UILabel!
    weak var offerDesc: UILabel!
    weak var maxDiscount: UILabel!
    weak var cardImage: CustomImageView!
    
    var cardOffersArray = [String: Any]()
    var gradientLayer: CAGradientLayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        setUpConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setUpUI() {
        let backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.layer.cornerRadius = 15
        backView.backgroundColor = .yellow
        self.backView = backView
        contentView.addSubview(backView)
        
        let cardname = UILabel()
        cardname.translatesAutoresizingMaskIntoConstraints = false
        cardname.font = UIFont(name: "SF Pro Text", size: 16)
        cardname.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        cardname.textColor = .red
        cardname.sizeToFit()
        self.cardname = cardname
        self.backView.addSubview(cardname)
        
        let offerDesc = UILabel()
        offerDesc.translatesAutoresizingMaskIntoConstraints = false
        offerDesc.font = UIFont(name: "SF Pro Text", size: 14)
        offerDesc.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        offerDesc.textColor = .red
        offerDesc.numberOfLines = 0
        self.offerDesc = offerDesc
        self.backView.addSubview(offerDesc)
        
        let cardImage = CustomImageView()
        cardImage.translatesAutoresizingMaskIntoConstraints = false
        cardImage.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        cardImage.clipsToBounds = true
        self.cardImage = cardImage
        self.backView.addSubview(cardImage)
        self.backView.bringSubviewToFront(self.cardImage)

        
        let maxDiscount = UILabel()
        maxDiscount.translatesAutoresizingMaskIntoConstraints = false
        maxDiscount.font = UIFont(name: "SF Pro Text", size: 20)
        maxDiscount.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        maxDiscount.textColor = .red
        self.maxDiscount = maxDiscount
        self.backView.addSubview(maxDiscount)
        
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            
            cardImage.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            cardImage.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 10),
            cardImage.heightAnchor.constraint(equalToConstant: 90),
            cardImage.widthAnchor.constraint(equalToConstant: 90),
            
            cardname.topAnchor.constraint(equalTo: backView.topAnchor, constant: 5),
            cardname.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            cardname.heightAnchor.constraint(equalToConstant: 21),
            cardname.trailingAnchor.constraint(equalTo: cardImage.leadingAnchor, constant: 5),
            
            offerDesc.topAnchor.constraint(equalTo: cardname.bottomAnchor),
            offerDesc.leadingAnchor.constraint(equalTo: cardname.leadingAnchor),
            offerDesc.heightAnchor.constraint(equalToConstant: 45),
            offerDesc.trailingAnchor.constraint(equalTo: cardImage.leadingAnchor, constant: 5),
            
            maxDiscount.topAnchor.constraint(equalTo: offerDesc.bottomAnchor),
            maxDiscount.leadingAnchor.constraint(equalTo: cardname.leadingAnchor),
            maxDiscount.heightAnchor.constraint(equalToConstant: 50),
            maxDiscount.trailingAnchor.constraint(equalTo: cardImage.leadingAnchor, constant: 5),
            
        ])
    }

    func addGradient() {
        gradientLayer = CAGradientLayer() // Initialize here
        gradientLayer.colors = [
            UIColor(red: 26/255, green: 126/255, blue: 218/255, alpha: 1), // Adjust alpha if desired
            UIColor(red: 43/255, green: 209/255, blue: 255/255, alpha: 1), // Adjust alpha if desired
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = backView.bounds // Set frame after adding sublayer
        backView.layer.insertSublayer(gradientLayer, at: 0) // Add before border (optional)
        
    }
    
    func updateCell(offerResponse: CardOfferResponse?) {
        cardname.text = offerResponse?.cardName as? String
        offerDesc.text = offerResponse?.offerDesc as? String
        maxDiscount.text = offerResponse?.maxDiscount as? String
        cardImage.contentMode = .scaleAspectFill
        cardImage.layer.cornerRadius = 13
        if offerResponse?.imageUrl != nil && offerResponse?.imageUrl != "" {
            cardImage.loadImage(urlString: (offerResponse?.imageUrl as? String) ?? "" )
        }
    }
}
