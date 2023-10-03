//
//  LoaderView.swift
//  CoolSlots
//
//  Created by Eric Shema on 02/10/2023.
//

import UIKit

class LoaderView: UIViewController {
    
    private var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setBackgroundImage()
        addSpinner()
    }
    
    func setBackgroundImage() {
        // Create a UIImageView to set the background image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "LoaderBG")
        
        // Make sure the image scales appropriately if needed
        backgroundImage.contentMode = .scaleAspectFill
        
        // Add the image view to the view hierarchy as the bottom-most subview
        view.insertSubview(backgroundImage, at: 0)
    }
    
    func addSpinner() {
        // Create a white container view for the spinner
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        containerView.center = view.center
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10.0
        
        // Create a spinner
        spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .black
        spinner.center = CGPoint(x: containerView.bounds.midX, y: containerView.bounds.midY)
        
        // Add the spinner to the container view
        containerView.addSubview(spinner)
        
        // Add the container view to the main view
        view.addSubview(containerView)
        
        // Start animating the spinner
        spinner.startAnimating()
        
        // Add a label for "Loading the game"
        let loadingLabel = UILabel(frame: CGRect(x: 0, y: containerView.frame.maxY + 10, width: view.bounds.width, height: 30))
        loadingLabel.text = "Loading the game..."
        loadingLabel.textAlignment = .center
        loadingLabel.textColor = .white
        loadingLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        loadingLabel.clipsToBounds = true
        
        // Add the label to the main view
        view.addSubview(loadingLabel)
    }
}
