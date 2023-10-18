//
//  ViewController.swift
//  CoolSlots
//
//  Created by Eric Shema on 02/10/2023.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        // Calculate the width of the navigation bar as 80% of the screen width
        let navBarWidth = view.frame.width * 0.9
        
        // Create a custom navigation bar
        let customNavBar = CustomNavigationBar(width: navBarWidth, presentingViewController: self)
        
        // Center the custom navigation bar horizontally on the screen
        customNavBar.center.x = view.center.x
        
        // Add the custom navigation bar to the view
        view.addSubview(customNavBar)
    }
}

