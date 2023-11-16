//
//  TopNavigationStackView.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Daniel Jeong and Meilyn Wong
//  Copyright © 2023
// Meilyn sucks
//

import UIKit

class TopNavigationStackView: UIStackView {
    // Settings button for user profile
    let settingsButton = UIButton(type: .system)
    
    // Message button for user messages
    let messageButton = UIButton(type: .system)
    
    // Fire image view displaying the app icon
    let fireImageView = UIImageView(image: #imageLiteral(resourceName: "app_icon"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        // Set the height of the stack view to 80
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        // Configure the fire image view
        fireImageView.contentMode = .scaleAspectFit
        
        // Set the images for the settings and message buttons with original rendering mode
        settingsButton.setImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysOriginal), for: .normal)
        
        // Add subviews to the stack view with arrangement and spacing
        [settingsButton, UIView(), fireImageView, UIView(), messageButton].forEach { (v) in
            addArrangedSubview(v)
        }
        
        // Set the distribution of the stack view to equal centering
        distribution = .equalCentering
        
        // Enable layout margins relative arrangement
        isLayoutMarginsRelativeArrangement = true
        
        // Set layout margins to provide padding
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
