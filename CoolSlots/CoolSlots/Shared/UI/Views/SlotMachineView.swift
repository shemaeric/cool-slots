//
//  SlotMachineView.swift
//  CoolSlots
//
//  Created by Eric Shema on 19/10/2023.
//

import UIKit

class SlotMachineView: UIView {
    var numRows: Int = 5
    var numColumns: Int = 5
    var reelWidth: CGFloat = 0
    var reelHeight: CGFloat = 0
    var spacing: CGFloat = 10 // Adjust this to set the space between icons
    var reels: [[UIImageView]] = []
    
    let symbols = ["cherry", "lemon", "orange", "plum", "bell"]
    
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
                symbolImageView.image = UIImage(systemName: "apple.logo")
                reel.append(symbolImageView)
                addSubview(symbolImageView)
            }
            reels.append(reel)
        }
    }
    
    func spin() {
        // Implement the spinning animation logic here
    }
}
