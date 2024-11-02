//
//  UILabel + Extension.swift
//  WhiteAndFluffyTestProject
//
//  Created by Матвей Анкудимов on 01.11.2024.
//

import UIKit

extension UILabel {
    
    convenience init(text: String? = nil, lines: Int = 1, font: UIFont? = nil, textColor: UIColor = .black, alignment: NSTextAlignment = .left, tamic: Bool = false) {
        self.init(frame: .zero)
        self.text = text
        numberOfLines = lines
        self.font = font
        self.textColor = textColor
        self.textAlignment = alignment
        self.translatesAutoresizingMaskIntoConstraints = tamic
    }
}
