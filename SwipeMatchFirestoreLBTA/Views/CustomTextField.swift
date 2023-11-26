//
//  CustomTextField.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Daniel Jeong on 11/26/23.
//  Copyright © 2023 Brian Voong. All rights reserved.
//

import UIKit

class CustomTextField: UITextField{
    
    let padding: CGFloat
    
    init(padding: CGFloat){
        self.padding = padding
        super.init(frame: .zero)
        layer.cornerRadius = 25
    }
    
    //adding pading for text field
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        //Give it some padding for the textField
        return bounds.insetBy(dx: 16, dy: 0)
    }
    
    //No idea what this intrinsic size is doing
    override var intrinsicContentSize: CGSize{
        return .init(width: 0, height: 50)
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder: ) has not been implemented")
    }
}
