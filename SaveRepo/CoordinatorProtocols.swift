//
//  CoordinatorProtocol.swift
//  SaveRepo
//
//  Created by A1398 on 28/11/2022.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    var navigationContoller: UINavigationController { get set }
    func configureRootViewController()
}
