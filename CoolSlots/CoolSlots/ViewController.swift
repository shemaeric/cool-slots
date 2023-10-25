//
//  ViewController.swift
//  CoolSlots
//
//  Created by Eric Shema on 02/10/2023.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    var slotMachineView: SlotMachineView!

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

        // Create a parent view for the slotMachineView
        let parentView = UIView()
        parentView.frame = CGRect(x: 0, y: 0, width: view.frame.width / 2, height: view.frame.height / 1.5)
        parentView.center = view.center
        parentView.backgroundColor = .blue
        parentView.layer.borderColor = UIColor.goldColor.cgColor
        parentView.layer.borderWidth = 4
        parentView.layer.cornerRadius = 6

        // Add the parent view to the main view
        view.addSubview(parentView)
        
        // Create a parent view for the slotMachineView
        let parentView2 = UIView()
        
        let parentView2Width = parentView.frame.width * 0.96
        let parentView2Height = parentView.frame.height * 0.94
        let parentView2X = (parentView.frame.width - parentView2Width) / 2
        let parentView2Y = (parentView.frame.height - parentView2Height) / 2
        
        parentView2.frame = CGRect(x: parentView2X, y: parentView2Y, width: parentView2Width, height: parentView2Height)
        parentView2.backgroundColor = .blue // Set the background color as needed
        parentView2.layer.borderColor = UIColor.goldColor.cgColor
        parentView2.layer.borderWidth = 1
        parentView2.layer.cornerRadius = 4

        // Add the parent view to the main view
        parentView.addSubview(parentView2)

        // Calculate the position for the slotMachineView to center it within the parent view
        let slotMachineWidth = parentView2.frame.width * 0.96
        let slotMachineHeight = parentView2.frame.height * 0.94
        let slotMachineX = (parentView2.frame.width - slotMachineWidth) / 2
        let slotMachineY = (parentView2.frame.height - slotMachineHeight) / 2

        // Add the slotMachineView inside the parent view
        slotMachineView = SlotMachineView(frame: CGRect(x: slotMachineX, y: slotMachineY, width: slotMachineWidth, height: slotMachineHeight))
        slotMachineView.backgroundColor = .blue
        parentView2.addSubview(slotMachineView)

        // Add a button for spinning the slot machine
        let spinButton = UIButton(frame: CGRect(x: 50, y: 700, width: 300, height: 50))
        spinButton.setTitle("Spin", for: .normal)
        spinButton.backgroundColor = UIColor.red
        spinButton.addTarget(self, action: #selector(spinButtonTapped), for: .touchUpInside)
        view.addSubview(spinButton)
        
        // Create a custom bottom bar
        let customBottomBar = CustomBottomBar(width: navBarWidth, parentHeight: view.frame.height, presentingViewController: self)
        
        // Center the custom bottom bar horizontally on the screen
        customBottomBar.center.x = view.center.x
        
        // Add the custom bottom bar to the view
        view.addSubview(customBottomBar)
    }

    @objc func spinButtonTapped() {
        // Call the spin() method of the SlotMachineView
        slotMachineView.spin()
    }
}

