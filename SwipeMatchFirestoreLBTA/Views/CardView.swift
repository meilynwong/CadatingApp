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
        
        backgroundColor = .red
        
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
