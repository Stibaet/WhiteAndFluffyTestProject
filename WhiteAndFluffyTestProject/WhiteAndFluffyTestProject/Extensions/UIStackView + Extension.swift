//
//  UIStackView + Extension.swift
//  WhiteAndFluffyTestProject
//
//  Created by Матвей Анкудимов on 01.11.2024.
//

import UIKit

extension UIStackView {
    
    convenience init(axis: NSLayoutConstraint.Axis, distribution: Distribution = .fill, spacing: CGFloat = 0, arrangedSubviews: [UIView] = [], tamic: Bool = false) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.distribution = distribution
        self.spacing = spacing
        translatesAutoresizingMaskIntoConstraints = tamic
    }
}
