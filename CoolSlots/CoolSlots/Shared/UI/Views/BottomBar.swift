//
//  BottomBar.swift
//  CoolSlots
//
//  Created by Eric Shema on 19/10/2023.
//

import UIKit

class CustomBottomBar: UIView {
    
    // MARK: - Properties
    
    private weak var presentingViewController: UIViewController?
    var spinFunc: (() -> Void)?
    var currentTotalWins: Int = 0
    var totalWinsLabel: UILabel!
    var currentBetValue: Int = 500
    var betLabel: UILabel!
    
    // MARK: - Initialization
    
    init(width: CGFloat, parentHeight: CGFloat, presentingViewController: UIViewController?) {
        let height: CGFloat = 44
        // Adjust the frame to stick to the bottom
        let frame = CGRect(x: 0, y: parentHeight - height, width: width, height: height)
        super.init(frame: frame)
        self.presentingViewController = presentingViewController
        
        backgroundColor = UIColor.slotBackground()
        applyNavigationBarStyles()
        
        let stackView = createBottomBarStackView()
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func applyNavigationBarStyles() {
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 3
        clipsToBounds = false
        layer.borderWidth = 2
        layer.borderColor = UIColor.goldColor.cgColor
        
    }
    
    private func createBottomBarStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 20
        
        // Create and configure the components
        let totalBetView = createTotalBetView()
        let totalWinView = createTotalWinView()
        let spinButton = createSpinButton()
        
        // Add components to the stack view
        stackView.addArrangedSubview(totalBetView)
        stackView.addArrangedSubview(totalWinView)
        stackView.addArrangedSubview(spinButton)
        
        return stackView
    }
    
    private func createTotalBetView() -> UIView {
        // Create a view that holds the Total Bet components
        let totalBetView = UIView()
//        totalBetView.backgroundColor = .red
        // Create the minus button
        let minusButton = UIButton()
        minusButton.setTitle("-", for: .normal)
        minusButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        minusButton.setTitleColor(UIColor.black, for: .normal)
        minusButton.backgroundColor = UIColor.goldColor
        minusButton.layer.borderColor = UIColor.white.cgColor
        minusButton.layer.borderWidth = 2.0
        minusButton.layer.cornerRadius = 8
        // Configure the button's appearance and add any necessary actions
        minusButton.addTarget(self, action: #selector(decreaseBet), for: .touchUpInside)
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            minusButton.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        // Create a label for displaying the bet amount
        betLabel = UILabel()
        betLabel.text = "\(currentBetValue)"
        betLabel.textColor = UIColor.white
        betLabel.font = UIFont.bebasNeueFont(ofSize: 20)
        
        // Create the plus button
        let plusButton = UIButton()
        plusButton.setTitle("+", for: .normal)
        plusButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        plusButton.setTitleColor(UIColor.black, for: .normal)
        plusButton.backgroundColor = UIColor.goldColor
        plusButton.layer.borderColor = UIColor.white.cgColor
        plusButton.layer.borderWidth = 2.0
        plusButton.layer.cornerRadius = 8
        // Configure the button's appearance and add any necessary actions
        plusButton.addTarget(self, action: #selector(increaseBet), for: .touchUpInside)
        
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            plusButton.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        // Layout the components within totalBetView using a horizontal stack view
        let stackView = UIStackView(arrangedSubviews: [minusButton, betLabel, plusButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 10
        
        totalBetView.addSubview(stackView)
        totalBetView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: totalBetView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: totalBetView.trailingAnchor, constant: -10),
            stackView.centerYAnchor.constraint(equalTo: totalBetView.centerYAnchor),
        ])
        // Ensure that totalBetView takes up one-third of the width
        totalBetView.widthAnchor.constraint(equalToConstant: self.frame.width / 5 ).isActive = true
        totalBetView.heightAnchor.constraint(equalToConstant: self.frame.height / 1.4).isActive = true
        return totalBetView
    }
    
    private func createTotalWinView() -> UIView {
        // Create a view that holds the Total Win components
        let totalWinView = UIView()

        // Set the background color for the totalWinView
        totalWinView.backgroundColor = UIColor.goldColor // Background color

        // Set the corner radius for the totalWinView (optional)
        totalWinView.layer.cornerRadius = 10
        totalWinView.layer.borderColor = UIColor.white.cgColor
        totalWinView.layer.borderWidth = 2.0

        // Create a stack view to hold the winLabel and subLabel
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5

        // Create a label for displaying the total win amount
        totalWinsLabel = UILabel()
        totalWinsLabel.text = "\(currentTotalWins)"
        totalWinsLabel.font = UIFont.bebasNeueFont(ofSize: 24)

        // Create a label for the sublabel (e.g., "wins")
        let subLabel = UILabel()
        subLabel.text = "wins"
        subLabel.textColor = .gray

        // Add the winLabel and subLabel to the stack view
        stackView.addArrangedSubview(totalWinsLabel)
//        stackView.addArrangedSubview(subLabel)

        // Add the stackView to the totalWinView
        totalWinView.addSubview(stackView)

        // Layout the stack view within totalWinView using constraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: totalWinView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: totalWinView.centerYAnchor),
        ])

        
        // Center totalWinView within its parent view (CustomBottomBar)
        self.addSubview(totalWinView)
        
        totalWinView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalWinView.widthAnchor.constraint(equalToConstant: self.frame.width / 3),
            totalWinView.heightAnchor.constraint(equalToConstant: self.frame.height / 1.4),
            totalWinView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            totalWinView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        return totalWinView
    }
    
    private func createSpinButton() -> UIButton {
        let spinButton = UIButton()
        spinButton.setTitle("Spin", for: .normal)
        spinButton.backgroundColor = UIColor.goldColor // Background color
        spinButton.setTitleColor(.black, for: .normal)
        spinButton.titleLabel?.font = UIFont.bebasNeueFont(ofSize: 22)
        spinButton.layer.borderColor = UIColor.white.cgColor
        spinButton.layer.borderWidth = 2.0
        spinButton.addTarget(self, action: #selector(spinBtn), for: .touchUpInside)
        
        // Set a fixed width of 100
        spinButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        spinButton.heightAnchor.constraint(equalToConstant: self.frame.height / 1.4).isActive = true

        // Apply rounded corners to the button to resemble a spin button
        spinButton.layer.cornerRadius = 8
        spinButton.layer.masksToBounds = true

        // You can also add an action to the button if needed
        // spinButton.addTarget(self, action: #selector(spinAction), for: .touchUpInside)

        return spinButton
    }
    
    @objc private func decreaseBet() {
        // Handle the logic to decrease the bet amount here
        if currentBetValue > 0 {
            currentBetValue -= 100 // You can change the decrement amount as needed
            AppConstants.defaultCoins -= 100
            updateBetLabel()
        }
    }

    @objc private func increaseBet() {
        // Handle the logic to increase the bet amount here
        currentBetValue += 100 // You can change the increment amount as needed
        AppConstants.defaultCoins += 100
        updateBetLabel()
    }

    private func updateBetLabel() {
        // Update the betLabel text with the current bet value
        betLabel.text = "\(currentBetValue)"
    }
    
    func updateTotalWinsValue(newTotalWinsCount: Int) {
        
        let oldTotalWinsCount = currentTotalWins
        
        currentTotalWins = newTotalWinsCount
        
        let animationDuration: Double = 1.0
        let updateInterval: Double = 0.03
        
        let stepValue = Double(newTotalWinsCount - oldTotalWinsCount) * updateInterval / animationDuration
        
        var animationTimer: Timer?
        
        animationTimer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { timer in
            // Calculate the new value for the label
            let currentValue = Int(self.totalWinsLabel.text ?? "0") ?? 0
            let newValue = Int(Double(currentValue) + stepValue)

            // Update the label's text
            self.totalWinsLabel.text = "\(newValue)"

            // If the animation is complete, stop the Timer
            if (stepValue > 0 && newValue >= newTotalWinsCount) || (stepValue < 0 && newValue <= newTotalWinsCount) {
                self.totalWinsLabel.text = "\(newTotalWinsCount)"
                timer.invalidate()
            }
        }

    }
    
    @objc private func spinBtn() {
        spinFunc?()
//        updateTotalWinsValue(newTotalWinsCount: 40000)
    }
}
