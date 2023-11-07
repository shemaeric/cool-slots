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
    var currentSymbols: [[SlotSymbol]] = []
    var winAnimationFunc: (() -> Void)?
    var updateCoins: ((_ coins: Int) -> Void)?
    var updateLevel: ((_ levl: Int) -> Void)?
    var updateDiamonds: ((_ diamonds: Int) -> Void)?
    var updateTotalWins: ((_ wins: Int) -> Void)?
    
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
                let symbolIndex = Int(arc4random_uniform(UInt32(symbolsArray.count)))
                let symbolName = symbolsArray[symbolIndex].name
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
            
            // Check the win
            self.checkWin()
        }
    }
    
    func shuffleSymbols() {
        var shuffledSymbols: [[SlotSymbol]] = []
        for row in 0..<numRows {
            var rowSymbols: [SlotSymbol] = []
            for column in 0..<numColumns {
                let symbolIndex = Int(arc4random_uniform(UInt32(symbolsArray.count)))
                let symbolName = symbolsArray[symbolIndex].name
                let symbolImageView = reels[row][column]
                symbolImageView.image = UIImage(named: symbolName)
                rowSymbols.append(symbolsArray[symbolIndex])
            }
            shuffledSymbols.append(rowSymbols)
        }
        currentSymbols = shuffledSymbols
    }
    
    func checkWin() {
        
        var totalWin = 0
        var winAnimationSymbol: String? = nil
        
        // Check rows for winning combinations
        for row in 0..<numRows {
            var consecutiveCount = 1
            var previousSymbol = currentSymbols[row][0].name
            for column in 1..<numColumns {
                let currentSymbol = currentSymbols[row][column].name
                if currentSymbol == previousSymbol {
                    consecutiveCount += 1
                } else {
                    consecutiveCount = 1
                }
                
                if consecutiveCount >= 3 {
                    if currentSymbol == "crown" || currentSymbol == "seven" {
                        winAnimationSymbol = currentSymbol
                    }
                    // Found more than three consecutive matching symbols
                    let symbolValue = symbolsArray.first { $0.name == previousSymbol }?.value ?? 0
                    totalWin += symbolValue * consecutiveCount
                    consecutiveCount = 0
                }
                
                previousSymbol = currentSymbol
            }
        }
        
        // Check columns for winning combinations
        for column in 0..<numColumns {
            var consecutiveCount = 1
            var previousSymbol = currentSymbols[0][column].name
            for row in 1..<numRows {
                let currentSymbol = currentSymbols[row][column].name
                if currentSymbol == previousSymbol {
                    consecutiveCount += 1
                } else {
                    consecutiveCount = 1
                }
                
                if consecutiveCount >= 3 {
                    // Found more than three consecutive matching symbols
                    if currentSymbol == "crown" || currentSymbol == "seven" {
                        winAnimationSymbol = currentSymbol
                    }
                    
                    let symbolValue = symbolsArray.first { $0.name == previousSymbol }?.value ?? 0
                    totalWin += symbolValue * consecutiveCount
                    consecutiveCount = 0
                }
                
                previousSymbol = currentSymbol
            }
        }
        
        // Display the result to the user
        print("Total Win: \(totalWin)")
        
        if winAnimationSymbol != nil {
            winAnimationFunc?()
        }
        
        updateCoins?(AppConstants.defaultCoins + totalWin)
        updateLevel?(2)
        updateDiamonds?(1000)
        updateTotalWins?(totalWin)
        // Finally, re-enable user interaction.
        isUserInteractionEnabled = true
    }
    
}
