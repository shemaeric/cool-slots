//
//  ProfilePopup.swift
//  CoolSlots
//
//  Created by Eric Shema on 18/10/2023.
//

import UIKit

class ProfilePopup: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calculate the dimensions for the rectangular view (half of the screen)
        let viewHeight = view.frame.height / 1.4
        let viewWidth = view.frame.width / 2
        
        // Create a rectangular view with a gold border
        let profileView = UIView()
        profileView.backgroundColor = UIColor.slotBackground()
        profileView.layer.borderColor = UIColor.goldColor.cgColor
        profileView.layer.borderWidth = 6.0
        profileView.layer.cornerRadius = 10.0
        profileView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileView)
        
        // Constrain the profileView
        NSLayoutConstraint.activate([
            profileView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            profileView.widthAnchor.constraint(equalToConstant: viewWidth),
            profileView.heightAnchor.constraint(equalToConstant: viewHeight)
        ])
        
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.tintColor = .goldColor
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        profileView.addSubview(closeButton)
        
        // Constrain the closeButton
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -10),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Add a label for "My Profile"
        let titleLabel = UILabel()
        titleLabel.text = "My Profile"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont.bebasNeueFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        profileView.addSubview(titleLabel)
        
        // Constrain the titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: profileView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: profileView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Add a profile picture (replace with your image)
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(systemName: "person") // Replace with your profile image
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.backgroundColor = .white
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.goldColor.cgColor
        profileImageView.layer.cornerRadius = 10
        profileView.addSubview(profileImageView)
        
        // Constrain the profileImageView
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            profileImageView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 60),
            profileImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // Add the name label
        let nameLabel = UILabel()
        nameLabel.text = "John Doe" // Replace with the actual name
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.bebasNeueFont(ofSize: 18)
        nameLabel.textColor = UIColor.white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        profileView.addSubview(nameLabel)
        
        // Constrain the nameLabel
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 40),
            nameLabel.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Add the level label and progress bar
        let levelLabel = UILabel()
        levelLabel.text = "Level:"
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.font = UIFont.bebasNeueFont(ofSize: 16)
        levelLabel.textColor = UIColor.goldColor
        profileView.addSubview(levelLabel)
        
        // Constrain the levelLabel
        NSLayoutConstraint.activate([
            levelLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 15),
            levelLabel.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 20),
            levelLabel.widthAnchor.constraint(equalToConstant: 100),
            levelLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Add the progress bar
        let progressBar = UIProgressView()
        progressBar.progress = 0.6
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        profileView.addSubview(progressBar)
        
        // Constrain the progressBar
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 25),
            progressBar.leadingAnchor.constraint(equalTo: levelLabel.trailingAnchor, constant: 10),
            progressBar.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -20),
            progressBar.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        // Add the level value label
        let levelValueLabel = UILabel()
        levelValueLabel.text = "10" // Replace with the actual level value
        levelValueLabel.textAlignment = .right
        levelValueLabel.font = UIFont.bebasNeueFont(ofSize: 12)
        levelValueLabel.textColor = UIColor.goldColor
        levelValueLabel.translatesAutoresizingMaskIntoConstraints = false
        profileView.addSubview(levelValueLabel)
        
        // Constrain the levelValueLabel
        NSLayoutConstraint.activate([
            levelValueLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 15),
            levelValueLabel.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -20),
            levelValueLabel.widthAnchor.constraint(equalToConstant: 40),
            levelValueLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Add coins label and value
        let coinsLabel = UILabel()
        coinsLabel.text = "Coins:"
        coinsLabel.font = UIFont.bebasNeueFont(ofSize: 16)
        coinsLabel.textColor = UIColor.goldColor
        coinsLabel.translatesAutoresizingMaskIntoConstraints = false
        profileView.addSubview(coinsLabel)
        
        // Constrain the coinsLabel
        NSLayoutConstraint.activate([
            coinsLabel.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: 15),
            coinsLabel.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 20),
            coinsLabel.widthAnchor.constraint(equalToConstant: 100),
            coinsLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Add coins value label
        let coinsValueLabel = UILabel()
        coinsValueLabel.text = "1000" // Replace with the actual coins value
        coinsValueLabel.textAlignment = .right
        coinsValueLabel.font = UIFont.bebasNeueFont(ofSize: 16)
        coinsValueLabel.textColor = UIColor.white
        coinsValueLabel.translatesAutoresizingMaskIntoConstraints = false
        profileView.addSubview(coinsValueLabel)
        
        // Constrain the coinsValueLabel
        NSLayoutConstraint.activate([
            coinsValueLabel.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: 15),
            coinsValueLabel.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -20),
            coinsValueLabel.widthAnchor.constraint(equalToConstant: 80),
            coinsValueLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Add gems label and value
        let gemsLabel = UILabel()
        gemsLabel.text = "Gems:"
        gemsLabel.font = UIFont.bebasNeueFont(ofSize: 16)
        gemsLabel.textColor = UIColor.goldColor
        gemsLabel.translatesAutoresizingMaskIntoConstraints = false
        profileView.addSubview(gemsLabel)
        
        // Constrain the gemsLabel
        NSLayoutConstraint.activate([
            gemsLabel.topAnchor.constraint(equalTo: coinsLabel.bottomAnchor, constant: 15),
            gemsLabel.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 20),
            gemsLabel.widthAnchor.constraint(equalToConstant: 100),
            gemsLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Add gems value label
        let gemsValueLabel = UILabel()
        gemsValueLabel.text = "500" // Replace with the actual gems value
        gemsValueLabel.textAlignment = .right
        gemsValueLabel.font = UIFont.bebasNeueFont(ofSize: 16)
        gemsValueLabel.textColor = UIColor.white
        gemsValueLabel.translatesAutoresizingMaskIntoConstraints = false
        profileView.addSubview(gemsValueLabel)
        
        // Constrain the gemsValueLabel
        NSLayoutConstraint.activate([
            gemsValueLabel.topAnchor.constraint(equalTo: coinsLabel.bottomAnchor, constant: 15),
            gemsValueLabel.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -20),
            gemsValueLabel.widthAnchor.constraint(equalToConstant: 80),
            gemsValueLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func closeButtonTapped() {
        // Dismiss the popup
        self.dismiss(animated: true, completion: nil)
    }
}
