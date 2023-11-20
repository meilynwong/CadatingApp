//
//  CardView.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Meilyn Jade Wong on 11/19/23.

// Modified on 11/19/23 by Daniel No Middle Name Jeong
//

import UIKit

class CardView: UIView {
    
    fileprivate let imageView =  UIImageView(image: UIImage(named: "profilePic"))
    
    //Configuration funcs
    fileprivate let threshold: CGFloat = 100

    
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
            handleEnded(gesture: gesture)
        default:
            ()
        }
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        //adding the rotation gesture for swiping
        // converting the radians to degreees
        
        let translation = gesture.translation(in: nil)

        
        //follow the gesture translation x
        // divide by 20 to minimize the rotation effect, to make transformation slower
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
        //to make it rotatae and then translate
        
    }
    //underscore you reduce amount of text in your code
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard {
                self.frame = CGRect(x: 1000 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
            } else {
                self.transform = .identity
            }
            
        }) { (_) in
            self.transform = .identity
            //Bring the card back
            //I dont know why the animation is really wack on the simulator, we may need to test with an iphon
            self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
