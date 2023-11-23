//
//  HomeBottomControlsStackView.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Daniel Jeong and Meilyn Wong
//

import UIKit

class HomeBottomControlsStackView: UIStackView {
    
    // Custom initializer for the HomeBottomControlsStackView
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set the distribution of the stack view to fill equally
        distribution = .fillEqually
        
        // Set the height of the stack view to 100
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // Create an array of image literals representing buttons
        let subviews = [#imageLiteral(resourceName: "refresh_circle"),
                        #imageLiteral(resourceName: "dismiss_circle"),
                        #imageLiteral(resourceName: "super_like_circle"),
                        #imageLiteral(resourceName: "like_circle"),
                        #imageLiteral(resourceName: "boost_circle")].map { (img) -> UIView in
            
            // Create a button for each image
            let button = UIButton(type: .system)
            button.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
            
            // Return the button as a UIView
            return button
        }
        
        // Add each button to the arranged subviews of the stack view
        subviews.forEach { (v) in
            addArrangedSubview(v)
        }
    }
    
    // Initializer required for NSCoder, with a fatal error indicating it's not implemented
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
