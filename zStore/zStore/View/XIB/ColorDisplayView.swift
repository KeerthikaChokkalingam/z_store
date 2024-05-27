//
//  ColorDisplayView.swift
//  zStore
//
//  Created by Keerthika on 26/05/24.
//

import UIKit

class ColorDisplayView: UIView {
    // Properties
    private var colorViews: [UIView] = []

    // Configure method
    func configure(with colors: [String]) {
        // Clear existing color views
        for colorView in colorViews {
            colorView.removeFromSuperview()
        }
        colorViews.removeAll()

        // Create color views based on available colors
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center

        for color in colors {
            let colorView = UIView()
            colorView.backgroundColor = UIColor(named: color)
            colorView.widthAnchor.constraint(equalToConstant: 20).isActive = true
            colorView.heightAnchor.constraint(equalToConstant: 20).isActive = true
            colorView.layer.cornerRadius = 10
            stackView.addArrangedSubview(colorView)
            colorViews.append(colorView)
        }

        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

