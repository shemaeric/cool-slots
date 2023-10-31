//
//  NavigationBar.swift
//  CoolSlots
//
//  Created by Eric Shema on 17/10/2023.
//

import UIKit

class CustomNavigationBar: UIView {
    
    // MARK: - Properties
    
    private weak var presentingViewController: UIViewController?
    
    private let height: CGFloat
    
    // MARK: - Initialization
    
    init(width: CGFloat, presentingViewController: UIViewController?) {
        self.height = 44
        let frame = CGRect(x: 0, y: 5, width: width, height: height)
        super.init(frame: frame)
        self.presentingViewController = presentingViewController
        
        backgroundColor = UIColor.slotBackground()
        applyNavigationBarStyles()
        
        let stackView = createNavBarStackView()
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
    
    private func createNavBarStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 20
        
        stackView.addArrangedSubview(createHomeButton())
        stackView.addArrangedSubview(createProfileIconStackView())
        stackView.addArrangedSubview(createCoinsStackView())
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(createTitleCenterView())
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(createDiamondsLevelSettingsStackView())
        
        return stackView
    }
    
    // MARK: - Component Creation Methods
    
    private func createHomeButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "house.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor.goldColor
        return button
    }
    
    private func createProfileIconStackView() -> UIStackView {
        let profileIconStackView = UIStackView()
        profileIconStackView.axis = .horizontal
        
        profileIconStackView.translatesAutoresizingMaskIntoConstraints = false
        profileIconStackView.heightAnchor.constraint(equalToConstant: height * 0.7 ).isActive = true
        profileIconStackView.widthAnchor.constraint(equalToConstant: height * 0.7 ).isActive = true
        
        let profileIconImageView = UIImageView(image: UIImage(systemName: "person.circle.fill")?.withRenderingMode(.alwaysTemplate))
        profileIconImageView.contentMode = .scaleAspectFit
        profileIconImageView.tintColor = UIColor.goldColor
        
        profileIconImageView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0) // Increase the scale
        
        profileIconStackView.addArrangedSubview(profileIconImageView)
        
        // Add tap gesture recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showPopup))
        profileIconStackView.addGestureRecognizer(tapGestureRecognizer)
        
        return profileIconStackView
    }
    
    private func createCoinsStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        
        let coinsIconImageView = UIImageView(image: UIImage(systemName: "dollarsign.circle.fill"))
        coinsIconImageView.contentMode = .scaleAspectFit
        coinsIconImageView.tintColor = .goldColor
        coinsIconImageView.translatesAutoresizingMaskIntoConstraints = false
        coinsIconImageView.heightAnchor.constraint(equalToConstant: height * 0.7).isActive = true
        coinsIconImageView.widthAnchor.constraint(equalTo: coinsIconImageView.heightAnchor).isActive = true
        
        stackView.addArrangedSubview(coinsIconImageView)
        
        let coinsAmountLabel = createLabel(text: "1000", fontSize: 16, bold: true, textColor: .white)
        stackView.addArrangedSubview(coinsAmountLabel)
        
        return stackView
    }
    
    private func createTitleCenterView() -> UIView {
        let titleCenterView = UIView()
        titleCenterView.backgroundColor = UIColor.white
        titleCenterView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set the border properties for the gold border
        titleCenterView.layer.borderWidth = 2.0
        titleCenterView.layer.borderColor = UIColor.goldColor.cgColor
        titleCenterView.layer.cornerRadius = 8
        
        let logoImageView = UIImageView(image: UIImage(named: "sevens"))
        logoImageView.contentMode = .scaleAspectFit // Adjust content mode as needed
        titleCenterView.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleCenterView.heightAnchor.constraint(equalToConstant: height),
            titleCenterView.widthAnchor.constraint(equalToConstant: 100.0)
        ])
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: titleCenterView.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: titleCenterView.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 40),
            logoImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        return titleCenterView
    }
    
    private func createDiamondsLevelSettingsStackView() -> UIStackView {
        let diamondsIconImageView = UIImageView(image: UIImage(named: "diamond"))
        diamondsIconImageView.contentMode = .scaleAspectFit
        diamondsIconImageView.tintColor = .goldColor
        diamondsIconImageView.translatesAutoresizingMaskIntoConstraints = false
        diamondsIconImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        diamondsIconImageView.widthAnchor.constraint(equalTo: diamondsIconImageView.heightAnchor).isActive = true
        
        let diamondsAmountLabel = createLabel(text: "500", fontSize: 16, bold: true, textColor: .white)
        
        let levelIconImageView = UIImageView(image: UIImage(systemName: "star.fill"))
        levelIconImageView.contentMode = .scaleAspectFit
        levelIconImageView.tintColor = .goldColor
        levelIconImageView.translatesAutoresizingMaskIntoConstraints = false
        levelIconImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        levelIconImageView.widthAnchor.constraint(equalTo: levelIconImageView.heightAnchor).isActive = true
        
        let levelText = createLabel(text: "Level:", fontSize: 16, bold: true, textColor: .goldColor)
        let levelTextLabel = createLabel(text: "10", fontSize: 16, bold: true, textColor: .white)
        
        let diamondsStackView = UIStackView(arrangedSubviews: [diamondsIconImageView, diamondsAmountLabel])
        diamondsStackView.axis = .horizontal
        diamondsStackView.spacing = 5
        
        let levelStackView = UIStackView(arrangedSubviews: [levelIconImageView,levelText , levelTextLabel])
        levelStackView.axis = .horizontal
        levelStackView.spacing = 5
        
        let diamondsLevelStackView = UIStackView(arrangedSubviews: [diamondsStackView, levelStackView])
        diamondsLevelStackView.axis = .horizontal
        diamondsLevelStackView.spacing = 30
        
        let settingsButton = createSettingsButton()
        
        let diamondsLevelSettingsStackView = UIStackView(arrangedSubviews: [diamondsLevelStackView, settingsButton])
        diamondsLevelSettingsStackView.axis = .horizontal
        diamondsLevelSettingsStackView.spacing = 30
        
        return diamondsLevelSettingsStackView
    }
    
    private func createSettingsButton() -> UIButton {
        let settingsButton = UIButton(type: .custom)
        settingsButton.setImage(UIImage(systemName: "gear")?.withRenderingMode(.alwaysTemplate), for: .normal)
        settingsButton.tintColor = .goldColor
        return settingsButton
    }
    
    private func createLabel(text: String, fontSize: CGFloat, bold: Bool = false, textColor: UIColor = .black) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.bebasNeueFont(ofSize: fontSize)
        label.textColor = textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    @objc private func showPopup() {
        let popupVC = ProfilePopup()
        popupVC.modalPresentationStyle = .overCurrentContext
        
        // Check if the presenting view controller is available
        if let presentingVC = presentingViewController {
            presentingVC.present(popupVC, animated: true, completion: nil)
        }
    }
}
