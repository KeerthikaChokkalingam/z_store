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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        setUpConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        addGradientLayer()
    }
    func configureCell(data: CardOfferResponse?) {
            addGradientLayer()
        }

        private func addGradientLayer() {
            // Remove any existing gradient layers
            if let sublayers = backView.layer.sublayers {
                for layer in sublayers where layer is CAGradientLayer {
                    layer.removeFromSuperlayer()
                }
            }
            
            let gradientLayer = createGradientLayer(bounds: backView.bounds)
            backView.layer.insertSublayer(gradientLayer, at: 0)
        }

        private func createGradientLayer(bounds: CGRect) -> CAGradientLayer {
            let gradientLayer = CAGradientLayer()
            backView.layoutIfNeeded()
            gradientLayer.frame = backView.bounds
            gradientLayer.cornerRadius = 20
            if backView.accessibilityIdentifier == "HDFC Bank Credit card" {
                gradientLayer.colors = [UIColor(red: 26/255, green: 126/255, blue: 218/255, alpha: 1).cgColor, UIColor(red: 43/255, green: 209/255, blue: 255/255, alpha: 1).cgColor]
            } else if backView.accessibilityIdentifier == "IFBC Bank Credit card" {
                gradientLayer.colors = [UIColor(red: 255/255, green: 166/255, blue: 30/255, alpha: 1).cgColor, UIColor(red: 253/255, green: 82/255, blue: 97/255, alpha: 1).cgColor]
            } else {
                gradientLayer.colors = [UIColor(red: 240/255, green: 35/255, blue: 116/255, alpha: 1).cgColor, UIColor(red: 245/255, green: 26/255, blue: 236/255, alpha: 1).cgColor]
            }
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            return gradientLayer
        }
    
    
    func setUpUI() {
        let backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.layer.cornerRadius = 15
        self.backView = backView
        contentView.addSubview(backView)
        
        let cardname = UILabel()
        cardname.translatesAutoresizingMaskIntoConstraints = false
        cardname.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        cardname.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        cardname.sizeToFit()
        self.cardname = cardname
        self.backView.addSubview(cardname)
        
        let offerDesc = UILabel()
        offerDesc.translatesAutoresizingMaskIntoConstraints = false
        offerDesc.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        offerDesc.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
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
        maxDiscount.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        maxDiscount.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
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
            cardImage.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 15),
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

    func updateCell(offerResponse: CardOfferResponse?) {
        backView.accessibilityIdentifier = offerResponse?.cardName
        cardname.text = offerResponse?.cardName as? String
        offerDesc.text = offerResponse?.offerDesc as? String
        maxDiscount.text = offerResponse?.maxDiscount as? String
        cardImage.contentMode = .scaleAspectFill
        cardImage.layer.cornerRadius = 13
        if let imageUrl = offerResponse?.imageUrl, !imageUrl.isEmpty {
            cardImage.loadImage(urlString: imageUrl)
        }
    }
}
