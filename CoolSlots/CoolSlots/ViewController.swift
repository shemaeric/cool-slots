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
        
        // Create a loading view controller
        let loadingViewController = LoaderView()
        view.addSubview(loadingViewController.view)
        
        // Simulate a 2-second loading time
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.presentGameScreen()
        }
    }
    
    func presentGameScreen() {
        let gameScreen = GameScreen()
        let landscapeNavigationController = LandscapeNavigationController(rootViewController: gameScreen)
        landscapeNavigationController.modalPresentationStyle = .fullScreen
        present(landscapeNavigationController, animated: true, completion: nil)
    }
}
