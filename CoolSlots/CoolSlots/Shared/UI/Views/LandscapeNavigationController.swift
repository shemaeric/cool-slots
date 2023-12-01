//
//  LandscapeNavigationController.swift
//  CoolSlots
//
//  Created by Eric Shema on 30/11/2023.
//

import Foundation

import UIKit

class LandscapeNavigationController: UINavigationController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var shouldAutorotate: Bool {
        return true
    }
}
