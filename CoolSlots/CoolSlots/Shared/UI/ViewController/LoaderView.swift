//
//  LoaderView.swift
//  CoolSlots
//
//  Created by Eric Shema on 02/10/2023.
//

import UIKit

class LoaderView: UIViewController {
    
    private var spinner: UIActivityIndicatorView!
    private var containerView: UIView! // Declare containerView at the class level
    let loadingLabelHeight: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setBackgroundImage()
        addSpinner()
        
        // Listen for orientation changes
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (_) in
            self.updateLayoutForOrientation()
        }, completion: nil)
    }
    
    @objc func orientationDidChange() {
        updateLayoutForOrientation()
    }
    
    func updateLayoutForOrientation() {
        setBackgroundImage()
        addSpinner()
    }
    
    func setBackgroundImage() {
        // Remove existing background image view
        view.subviews.filter { $0 is UIImageView }.forEach { $0.removeFromSuperview() }
        
        // Create a UIImageView to set the background image
        let backgroundImage = UIImageView(image: UIImage(named: "LoaderBG"))
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.frame = view.bounds
        backgroundImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Add the image view to the view hierarchy as the bottom-most subview
        view.insertSubview(backgroundImage, at: 0)
    }
    
    func addSpinner() {
        // Remove existing spinner, containerView, and label

        for subview in view.subviews {
            if subview is UIActivityIndicatorView || subview is UILabel {
                subview.removeFromSuperview()
            }
        }
        
        let containerViewWidth: CGFloat = 100
        let containerViewHeight: CGFloat = 100
        
        // Create a white container view for the spinner
        containerView = UIView(frame: CGRect(x: 0, y: 0, width: containerViewWidth, height: containerViewHeight))
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10.0
        containerView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        containerView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        
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
        let loadingLabel = UILabel(frame: CGRect(x: 0, y: containerView.frame.maxY + 10, width: view.bounds.width, height: loadingLabelHeight))
        loadingLabel.text = "Loading the game..."
        loadingLabel.textAlignment = .center
        loadingLabel.textColor = .white
        loadingLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        loadingLabel.clipsToBounds = true
        loadingLabel.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY + containerViewHeight + 100)
        loadingLabel.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        
        // Add the label to the main view
        view.addSubview(loadingLabel)
        
        adjustLayout()
    }
    
    func adjustLayout() {
        // Adjust layout for the current orientation
        let containerViewHeight: CGFloat = 100
        
        // Update positions and sizes based on the current orientation
        let newCenterX = view.bounds.midX
        let newCenterY = view.bounds.midY
        let labelYOffset: CGFloat = 10
        
        if UIDevice.current.orientation.isPortrait {
            // Portrait orientation layout adjustments
            containerView.center = CGPoint(x: newCenterX, y: newCenterY)
        } else {
            // Landscape orientation layout adjustments
            containerView.center = CGPoint(x: newCenterX, y: newCenterY)
        }
        
        spinner.center = CGPoint(x: containerView.bounds.midX, y: containerView.bounds.midY)
        
        let loadingLabel = view.subviews.first { $0 is UILabel } as? UILabel
        loadingLabel?.frame = CGRect(x: 0, y: containerView.frame.maxY + labelYOffset, width: view.bounds.width, height: loadingLabelHeight)
        loadingLabel?.center = CGPoint(x: newCenterX, y: newCenterY + containerViewHeight)
    }
}

