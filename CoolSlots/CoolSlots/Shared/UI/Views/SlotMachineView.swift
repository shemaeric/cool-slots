//
//  SlotMachineView.swift
//  CoolSlots
//
//  Created by Eric Shema on 19/10/2023.
//

import UIKit
import Lottie

class SlotMachineView: UIView {
    var numRows: Int = 5
    var numColumns: Int = 5
    var reelWidth: CGFloat = 0
    var reelHeight: CGFloat = 0
    var spacing: CGFloat = 20 // Adjust this to set the space between icons
    var reels: [[UIImageView]] = []
    
    let symbols = ["avocado", "banana", "berries", "crown", "seven", "tomato", "watermelon"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSlotMachine()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSlotMachine()
    }
    
    func setupSlotMachine() {
        backgroundColor = UIColor.black
        
        reelWidth = (frame.size.height - CGFloat(numColumns - 1) * spacing) / CGFloat(numColumns)
        reelHeight = (frame.size.height - CGFloat(numRows - 1) * spacing) / CGFloat(numRows)
        
        // Calculate row and column spacings
        let rowSpacing = (frame.size.height - CGFloat(numRows) * reelHeight) / CGFloat(numRows - 1)
        let columnSpacing = (frame.size.width - CGFloat(numColumns) * reelWidth) / CGFloat(numColumns - 1)
        
        for row in 0..<numRows {
            var reel: [UIImageView] = []
            for column in 0..<numColumns {
                let symbolIndex = Int(arc4random_uniform(UInt32(symbols.count)))
                let symbolName = symbols[symbolIndex]
                let x = CGFloat(column) * (reelWidth + columnSpacing)
                let y = CGFloat(row) * (reelHeight + rowSpacing)
                let symbolImageView = UIImageView(frame: CGRect(x: x, y: y, width: reelWidth, height: reelHeight))
                symbolImageView.image = UIImage(named: symbolName)
                reel.append(symbolImageView)
                addSubview(symbolImageView)
            }
            reels.append(reel)
        }
    }
    
    
    func spin() {
        // Disable interaction while spinning
        isUserInteractionEnabled = false
        
        // Create a UIVisualEffectView with a UIBlurEffect
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = bounds
        addSubview(visualEffectView)
        
        // Create and set up the SlotSpinningView
        let spinningView = SlotSpinningView(frame: bounds)
        spinningView.setupAnimationView()
        
        // Add the SlotSpinningView on top of the SlotMachineView
        addSubview(spinningView)
        
        // Define a delay of 3 seconds
        let delayInSeconds: TimeInterval = 4.5
        
        // Create a dispatch queue to stop the animation after the delay
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
            // Re-enable interaction after spinning
            self.isUserInteractionEnabled = true
            
            // Stop the animation in the SlotSpinningView
            spinningView.stopAnimation()
            
            // Remove the SlotSpinningView from the SlotMachineView
            spinningView.removeFromSuperview()
            visualEffectView.removeFromSuperview()
            
            // Shuffle the symbols
            self.shuffleSymbols()
        }
    }
    
    func shuffleSymbols() {
        for row in 0..<numRows {
            for column in 0..<numColumns {
                let symbolIndex = Int(arc4random_uniform(UInt32(symbols.count)))
                let symbolName = symbols[symbolIndex]
                let symbolImageView = reels[row][column]
                symbolImageView.image = UIImage(named: symbolName)
            }
        }
    }
}
