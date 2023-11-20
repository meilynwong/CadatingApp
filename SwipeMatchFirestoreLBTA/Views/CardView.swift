//
//  CardView.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Meilyn Jade Wong on 11/19/23.
//  Copyright © 2023 Brian Voong. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    fileprivate let imageView =  UIImageView(image: UIImage(named: "profilePic"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        let pangesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(pangesture)
    }
    
    
    
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .changed:
            handleChanged(gesture)
        case.ended:
            handleEnded()
        default:
            ()
        }
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
    }
    
    fileprivate func handleEnded() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            self.transform = .identity
        }) { (_) in
            
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
