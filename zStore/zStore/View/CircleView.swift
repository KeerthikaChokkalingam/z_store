//
//  CircleView.swift
//  zStore
//
//  Created by Keerthika on 29/05/24.
//

import UIKit

class CircleView: UIView {
    
    private var stackView: UIStackView!
    private var colorsButtons: [UIButton] = []
    private let filledCircleImage = UIImage(systemName: "circle.fill")
    var numberOfStars: Int = 0
    
    // Define the colors for filled and unfilled stars
    
    var colorsList: [String] = [] {
        didSet {
            setupView()
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
            stackView.heightAnchor.constraint(equalToConstant: 25),
        ])
        
        for i in 0..<colorsList.count {
            let button = UIButton()
            button.setImage(filledCircleImage?.withTintColor(convertStringToUIColor(colorString: colorsList[i]), renderingMode: .alwaysOriginal), for: .normal)
            colorsButtons.append(button)
            stackView.addArrangedSubview(button)
        }
    }
    func convertStringToUIColor(colorString: String) -> UIColor {
        let colorDict: [String: UIColor] = [
            "red": UIColor.red,
            "blue": UIColor.blue,
            "green": UIColor.green,
            "yellow": UIColor.yellow,
            "black": UIColor.black,
            "white": UIColor.lightText,
            "gray": UIColor.gray,
            "cyan": UIColor.cyan,
            "magenta": UIColor.magenta,
            "orange": UIColor.orange,
            "purple": UIColor.purple,
            "brown": UIColor.brown,
            "teal": UIColor.systemTeal,
            "maroon": UIColor.brown
            // Add more colors as needed
        ]
        
        let normalizedColorString = colorString.lowercased()
        
        return colorDict[normalizedColorString] ?? UIColor.systemGray6
    }
}

