//
//  UIStackView + Extension.swift
//  BeerList-MVP
//
//  Created by MacBook on 18.01.2024.
//

import UIKit

extension UIStackView {
    func addArrangeSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}

