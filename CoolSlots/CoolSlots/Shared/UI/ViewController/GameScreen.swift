//
//  GameScreen.swift
//  CoolSlots
//
//  Created by Eric Shema on 30/11/2023.
//

import UIKit

class GameScreen: UIViewController {
    
    var slotMachineView: SlotMachineView!
    var customNavBar: CustomNavigationBar!
    var customBottomBar: CustomBottomBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        // Background image
        let backgroundImage = UIImageView(image: UIImage(named: "appBg"))
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.frame = view.bounds
        backgroundImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(backgroundImage)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        setupUI()
    }
    
    func runWinAnimation() {
        let winCoinsView = WinCoinsView(frame: view.bounds)
        winCoinsView.setupAnimationView()
        
        view.addSubview(winCoinsView)
        
        // Create a timer that fires after 3 seconds
        let timer = Timer.scheduledTimer(withTimeInterval: 6.0, repeats: false) { _ in
            // This block is executed after 3 seconds
            winCoinsView.removeFromSuperview() // Remove the view
        }
    }
    
    // Function to set up the rest of your UI components
    func setupUI() {
        
        // Calculate the width of the navigation bar as 80% of the screen width
        let navBarWidth = view.frame.width * 0.9
        
        // Create a custom navigation bar
        customNavBar = CustomNavigationBar(width: navBarWidth, presentingViewController: self)
        // Center the custom navigation bar horizontally on the screen
        customNavBar.center.x = view.center.x
        
        // Add the custom navigation bar to the view
        view.addSubview(customNavBar)
        
        // Create a parent view for the slotMachineView
        let parentView = UIView()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            parentView.frame = CGRect(x: 0, y: 0, width: view.frame.width / 1.1, height: view.frame.height / 2)
        } else {
            parentView.frame = CGRect(x: 0, y: 0, width: view.frame.width / 2, height: view.frame.height / 1.5)
        }
        
        parentView.center = view.center
        parentView.backgroundColor = UIColor.slotBackground()
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
        parentView2.backgroundColor = UIColor.slotBackground()
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
        slotMachineView.backgroundColor = UIColor.slotBackground()
        slotMachineView.winAnimationFunc = self.runWinAnimation
        slotMachineView.updateCoins = customNavBar.updateCoinsValue(newCoinsValue:)
        slotMachineView.updateLevel = customNavBar.updateLevelValue(newLevel:)
        slotMachineView.updateDiamonds = customNavBar.updateDiamondsValue(newDiamondsCount:)
        parentView2.addSubview(slotMachineView)
        
        // Create a custom bottom bar
        customBottomBar = CustomBottomBar(width: navBarWidth, parentHeight: view.frame.height, presentingViewController: self)
        customBottomBar.spinFunc = slotMachineView.spin
        
        // Center the custom bottom bar horizontally on the screen
        customBottomBar.center.x = view.center.x
        
        // Add the custom bottom bar to the view
        view.addSubview(customBottomBar)
        
        slotMachineView.updateTotalWins = customBottomBar.updateTotalWinsValue(newTotalWinsCount:)
    }
    
}
