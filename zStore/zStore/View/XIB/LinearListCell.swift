//
//  LinearListCell.swift
//  zStore
//
//  Created by Keerthika on 26/05/24.
//

import UIKit

class LinearListCell: UITableViewCell,UITextViewDelegate {

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
    weak var deliveryLabel: UITextView!
    weak var availableColorView: UIView!
    weak var circleView: CircleView!
    
    var listValue = [String:Any]()

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setUpConstraints()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setupUI() {
            let backView = UIView()
            backView.translatesAutoresizingMaskIntoConstraints = false
            backView.layer.cornerRadius = 15
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
            namelabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            namelabel.translatesAutoresizingMaskIntoConstraints = false
            namelabel.isHidden = false
            namelabel.numberOfLines = 3
            self.namelabel = namelabel
            self.backView.addSubview(namelabel)
            
            let ratingsBgView = UIView()
            ratingsBgView.translatesAutoresizingMaskIntoConstraints = false
            self.ratingsBgView = ratingsBgView
            self.backView.addSubview(ratingsBgView)
            
            let ratingLabel = UILabel()
            ratingLabel.text = ""
            ratingLabel.textColor = UIColor(red: 230/255, green: 86/255, blue: 15/255, alpha: 1)
            ratingLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
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
            ratingCount.font = UIFont.systemFont(ofSize: 13, weight: .thin)
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
            offerPrice.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            offerPrice.translatesAutoresizingMaskIntoConstraints = false
            offerPrice.isHidden = false
            offerPrice.sizeToFit()
            self.offerPrice = offerPrice
            self.priceView.addSubview(offerPrice)
            
            let actualPrice = UILabel()
            actualPrice.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            actualPrice.translatesAutoresizingMaskIntoConstraints = false
            actualPrice.isHidden = true
            actualPrice.sizeToFit()
            self.actualPrice = actualPrice
            self.priceView.addSubview(actualPrice)
            
            let savingPrice = UIButton(type: .custom)
        savingPrice.translatesAutoresizingMaskIntoConstraints = false
            savingPrice.backgroundColor = UIColor(red: 21/255, green: 140/255, blue: 91/255, alpha: 1)
            savingPrice.setTitleColor(UIColor.white, for: .normal)
        savingPrice.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        savingPrice.layer.cornerRadius = 12
        savingPrice.sizeToFit()
        savingPrice.titleLabel?.textAlignment = .center
        savingPrice.isHidden = true
            self.savingPrice = savingPrice
            self.priceView.addSubview(savingPrice)
        
        let deliveryLabel = UITextView()
        deliveryLabel.translatesAutoresizingMaskIntoConstraints = false
        deliveryLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        deliveryLabel.textColor = UIColor(red: 116/255, green: 116/255, blue: 116/255, alpha: 1)
        deliveryLabel.delegate = self
        deliveryLabel.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        deliveryLabel.isScrollEnabled = false
        deliveryLabel.isEditable = false
        self.deliveryLabel = deliveryLabel
        self.backView.addSubview(deliveryLabel)
        
        let availableColorView = UIView()
        availableColorView.translatesAutoresizingMaskIntoConstraints = false
        self.availableColorView = availableColorView
        self.backView.addSubview(availableColorView)
        
        let colorDisplayView = CircleView()
        colorDisplayView.translatesAutoresizingMaskIntoConstraints = false
        colorDisplayView.backgroundColor = UIColor.yellow
        self.circleView = colorDisplayView
        self.availableColorView.addSubview(colorDisplayView)
        }
        
        func setUpConstraints() {
            NSLayoutConstraint.activate([
                backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
                backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
                backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
                
                cardImage.topAnchor.constraint(equalTo: backView.topAnchor, constant: 15),
                cardImage.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 8),
                cardImage.heightAnchor.constraint(equalToConstant: 90),
                cardImage.widthAnchor.constraint(equalToConstant: 90),
                
                namelabel.topAnchor.constraint(equalTo: cardImage.topAnchor, constant: -5),
                namelabel.leadingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: 15),
                namelabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
                
                ratingsBgView.topAnchor.constraint(equalTo: namelabel.bottomAnchor,constant: 5),
                ratingsBgView.leadingAnchor.constraint(equalTo: namelabel.leadingAnchor),
                ratingsBgView.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
                ratingsBgView.heightAnchor.constraint(equalToConstant: 18),
                
                ratingLabel.topAnchor.constraint(equalTo: ratingsBgView.topAnchor),
                ratingLabel.leadingAnchor.constraint(equalTo: ratingsBgView.leadingAnchor),
                ratingLabel.heightAnchor.constraint(equalToConstant: 18),
//                ratingLabel.widthAnchor.constraint(equalToConstant: 25),
                
                ratingView.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 2),
                
                ratingCount.topAnchor.constraint(equalTo: ratingsBgView.topAnchor),
                ratingCount.leadingAnchor.constraint(equalTo: ratingView.trailingAnchor, constant: 85),
                ratingCount.heightAnchor.constraint(equalToConstant: 18),
                
                priceView.topAnchor.constraint(equalTo: ratingCount.bottomAnchor),
                priceView.leadingAnchor.constraint(equalTo: namelabel.leadingAnchor),
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
                
                deliveryLabel.topAnchor.constraint(equalTo: priceView.bottomAnchor, constant: -5),
                deliveryLabel.leadingAnchor.constraint(equalTo: namelabel.leadingAnchor),
                deliveryLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
                
                availableColorView.topAnchor.constraint(equalTo: deliveryLabel.bottomAnchor,constant: -5),
                availableColorView.leadingAnchor.constraint(equalTo: namelabel.leadingAnchor),
                availableColorView.trailingAnchor.constraint(equalTo: priceView.trailingAnchor),
                availableColorView.heightAnchor.constraint(equalToConstant: 28),
                
                circleView.leadingAnchor.constraint(equalTo: namelabel.leadingAnchor),
                
            ])
        }
    func offerAppliedCalculation(percentage: CGFloat, offerId: String, dataResponse: ProductResponse?) {
        // Calculate the savings amount
        if let dataResponse = dataResponse {
            let cardOfferIds = dataResponse.cardOfferIds
            if cardOfferIds.contains(offerId) {
                actualPrice.isHidden = false
                savingPrice.isHidden = false
                
               
                let price = dataResponse.price
                let savingsAmount = price * (percentage / 100.0)
                
                // Calculate the offer amount
                let offerAmount = price - savingsAmount
                
                let attributes: [NSAttributedString.Key: Any] = [
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    .foregroundColor: UIColor(red: 152/255, green: 152/255, blue: 152/255, alpha: 1),
                    .font: actualPrice.font!
                ]
                let attributedString = NSAttributedString(string: "₹" + String(format: "%.1f", (dataResponse.price )) , attributes: attributes)
                actualPrice.attributedText = attributedString
                offerPrice.text = String(format: "%.1f", (dataResponse.price - savingsAmount))
                
                savingPrice.setTitle("Save ₹" + String(format: "%.1f", (dataResponse.price - offerAmount)), for: .normal)
            } else {
                actualPrice.isHidden = true
                savingPrice.isHidden = true
               
                offerPrice.text =  "₹" + String(((dataResponse.price)))
            }
        }
       
    }
    func updateCell(listVlaue: ProductResponse?) {
        namelabel.text = listVlaue?.name as? String

        // Usage
        let markdownText = listVlaue?.description ?? ""
        let formattedDescription = formatProductDescription(markdownText: markdownText)

        if let data = formattedDescription.data(using: .utf8) {
            do {
                let attributedString = try NSAttributedString(
                    data: data,
                    options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                    documentAttributes: nil
                )
                deliveryLabel.attributedText = attributedString
            } catch {
                print("Error creating attributed string: \(error)")
                deliveryLabel.text = markdownText // Fallback to plain text if conversion fails
            }
        } else {
            deliveryLabel.text = markdownText // Fallback to plain text if conversion fails
        }
        if let rating = listVlaue?.rating {
            let ratingString = String(rating)
            let split = ratingString.split(separator: ".", omittingEmptySubsequences: false)
            print(split)
            if split.count == 2 {
                if split[1] == "0" {
                    ratingLabel.text = String(split[0])
                } else {
                    ratingLabel.text = String(split[0]) + "." + String(split[1])
                }
            }
        } else {
            print("Rating is nil")
        }
        
        ratingView.rating = convertToInt(from: listVlaue?.rating) ?? 0
        if (listVlaue?.colors?.count ?? 0 ) > 0 {
            availableColorView.isHidden = false
            circleView.colorsList = (listVlaue?.colors)!
        } else {
            availableColorView.isHidden = true
        }
        ratingCount.text = "(" + String(((listVlaue?.reviewCount as? Int) ?? 0)) + ")"
        offerPrice.text =  "₹" + String(((listVlaue?.price as? Double) ?? 0))
        cardImage.contentMode = .scaleAspectFill
        cardImage.layer.cornerRadius = 15
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
   
    func formatProductDescription(markdownText: String) -> String {
        let linkPattern =  #"\[([^\]]+)]\(([^)]+)\)"#
        let boldPattern = #"\*\*(.+?)\*\*"#

        let linkRegex = try! NSRegularExpression(pattern: linkPattern, options: .caseInsensitive)
        let boldRegex = try! NSRegularExpression(pattern: boldPattern, options: .caseInsensitive)

        var formattedText = markdownText
        
        // Process links
        let linkMatches = linkRegex.matches(in: markdownText, options: [], range: NSRange(location: 0, length: markdownText.utf16.count))
        var linkReplacements: [(range: NSRange, replacement: String)] = []
        
        for match in linkMatches {
            let urlRange = match.range(at: 2)
            let linkTextRange = match.range(at: 1)
            
            if let urlRange = Range(urlRange, in: markdownText),
               let linkTextRange = Range(linkTextRange, in: markdownText) {
                let _ = String(markdownText[urlRange])
                let linkText = String(markdownText[linkTextRange])
                let replacement = "<a href=\"\("https://www.zoho.com")\">\(linkText)</a>"
                linkReplacements.append((range: match.range, replacement: replacement))
            }
        }
        
        for replacement in linkReplacements.reversed() {
            if let range = Range(replacement.range, in: formattedText) {
                formattedText.replaceSubrange(range, with: replacement.replacement)
            }
        }
        
        // Process bold text
        let boldMatches = boldRegex.matches(in: formattedText, options: [], range: NSRange(location: 0, length: formattedText.utf16.count))
        var boldReplacements: [(range: NSRange, replacement: String)] = []
        
        for match in boldMatches {
            let boldRange = match.range(at: 1)
            
            if let boldRange = Range(boldRange, in: formattedText) {
                let boldText = String(formattedText[boldRange])
                let replacement = "<b>\(boldText)</b>"
                boldReplacements.append((range: match.range, replacement: replacement))
            }
        }
        
        for replacement in boldReplacements.reversed() {
            if let range = Range(replacement.range, in: formattedText) {
                formattedText.replaceSubrange(range, with: replacement.replacement)
            }
        }
        
        return formattedText
    }
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }

}
