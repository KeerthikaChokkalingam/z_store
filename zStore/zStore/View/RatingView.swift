//
//  RatingView.swift
//  zStore
//
//  Created by Keerthika on 26/05/24.
//

import UIKit

class RatingView: UIView {
    
    private var stackView: UIStackView!
    private var ratingButtons: [UIButton] = []
    private let filledStarImage = UIImage(systemName: "star.fill")
    private let numberOfStars = 5
    
    // Define the colors for filled and unfilled stars
    private let filledStarColor = UIColor(red: 230/255, green: 86/255, blue: 15/255, alpha: 1)
    private let emptyStarColor = UIColor(red: 152/255, green: 152/255, blue: 152/255, alpha: 1)
    
    var rating: Int = 0 {
        didSet {
            updateStarImages()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 0
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 16),
            stackView.widthAnchor.constraint(equalToConstant: 84)
        ])
        
        for _ in 0..<numberOfStars {
            let button = UIButton()
            button.setImage(filledStarImage?.withTintColor(emptyStarColor, renderingMode: .alwaysOriginal), for: .normal)
            ratingButtons.append(button)
            stackView.addArrangedSubview(button)
        }
    }

    private func updateStarImages() {
        for (index, button) in ratingButtons.enumerated() {
            let image = index < rating ? filledStarImage?.withTintColor(filledStarColor, renderingMode: .alwaysOriginal) : filledStarImage?.withTintColor(emptyStarColor, renderingMode: .alwaysOriginal)
            button.setImage(image, for: .normal)
        }
    }
}
