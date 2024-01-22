//
//  extensionUILabel.swift
//  SaveRepo
//
//  Created by A1398 on 09/03/2023.
//

import Foundation
import UIKit

extension UILabel {
    func setCornerRadius() {
        layer.cornerRadius = layer.frame.height / 2
        layer.masksToBounds = true
        layer.backgroundColor = UIColor.white.cgColor
    }
}
