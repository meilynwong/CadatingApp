//
//  Advertiser.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Daniel Jeong on 11/23/23.
//

import UIKit

struct Advertiser: ProducesCardViewModel {
    //Properties
    let title: String
    let brandName: String
    let posterPhotoName: String
    
    
    //generates a cardviewmodel from a advertiser object
    func toCardViewModel() -> CardViewModel{
        
        let attributedString = NSMutableAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 34, weight: .heavy)])
        
        attributedString.append(NSAttributedString(string: "\n" + brandName, attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]))
        
        return CardViewModel(imageName: posterPhotoName, attributedString: attributedString, textAlignment: .center)
    }
}
