//
//  SettingsPopup.swift
//  CoolSlots
//
//  Created by Eric Shema on 19/11/2023.
//

import UIKit

class SettingsPopup: UIViewController {
    
    var soundEnabled = true
    var musicEnabled = true
    var hapticEnabled = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calculate the dimensions for the rectangular view (half of the screen)
        let viewHeight = view.frame.height / 1.4
        let viewWidth = view.frame.width / 2
        
        // Create a rectangular view with a gold border
        let settingsView = UIView()
        settingsView.backgroundColor = UIColor.slotBackground()
        settingsView.layer.borderColor = UIColor.goldColor.cgColor
        settingsView.layer.borderWidth = 6.0
        settingsView.layer.cornerRadius = 10.0
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsView)
        
        // Constrain the profileView
        NSLayoutConstraint.activate([
            settingsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            settingsView.widthAnchor.constraint(equalToConstant: viewWidth),
            settingsView.heightAnchor.constraint(equalToConstant: viewHeight)
        ])
        
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.tintColor = .goldColor
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        settingsView.addSubview(closeButton)
        
        // Constrain the closeButton
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -10),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Add a label for "My Profile"
        let titleLabel = UILabel()
        titleLabel.text = "Settings"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont.bebasNeueFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsView.addSubview(titleLabel)
        
        // Constrain the titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Sound Button
        let soundButton = createSettingButton(title: "Sound", enabled: soundEnabled)
        soundButton.addTarget(self, action: #selector(soundButtonTapped), for: .touchUpInside)
        settingsView.addSubview(soundButton)
        
        // Constrain the soundButton
        NSLayoutConstraint.activate([
            soundButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            soundButton.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 20),
            soundButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -20),
            soundButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Music Button
        let musicButton = createSettingButton(title: "Music", enabled: musicEnabled)
        musicButton.addTarget(self, action: #selector(musicButtonTapped), for: .touchUpInside)
        settingsView.addSubview(musicButton)
        
        // Constrain the musicButton
        NSLayoutConstraint.activate([
            musicButton.topAnchor.constraint(equalTo: soundButton.bottomAnchor, constant: 20),
            musicButton.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 20),
            musicButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -20),
            musicButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Haptic Feedback Button
        let hapticButton = createSettingButton(title: "Haptic", enabled: hapticEnabled)
        hapticButton.addTarget(self, action: #selector(hapticButtonTapped), for: .touchUpInside)
        settingsView.addSubview(hapticButton)
        
        // Constrain the hapticButton
        NSLayoutConstraint.activate([
            hapticButton.topAnchor.constraint(equalTo: musicButton.bottomAnchor, constant: 20),
            hapticButton.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 20),
            hapticButton.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -20),
            hapticButton.heightAnchor.constraint(equalToConstant: 40),
            hapticButton.bottomAnchor.constraint(equalTo: settingsView.bottomAnchor, constant: -20)
        ])
    }
    
    // Function to create a button for each setting with a label and icon
    func createSettingButton(title: String, enabled: Bool) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.goldColor.cgColor
        button.setTitleColor(.black, for: .normal)
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 8.0
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let iconImageView = UIImageView(image: enabled ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square.fill"))
        iconImageView.tintColor = .black
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(iconImageView)
        
        let label = UILabel()
        label.text = enabled ? "Enabled" : "Disabled"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(label)
        
        // Constrain the iconImageView and label within the button
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 10),
            iconImageView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            label.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        return button
    }
    
    @objc func closeButtonTapped() {
        // Dismiss the popup
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func soundButtonTapped() {
        // Implement action for Sound Button
        print("Sound button tapped")
    }
    
    @objc func musicButtonTapped() {
        // Implement action for Music Button
        print("Music button tapped")
    }
    
    @objc func hapticButtonTapped() {
        // Implement action for Haptic Feedback Button
        print("Haptic button tapped")
    }
}
