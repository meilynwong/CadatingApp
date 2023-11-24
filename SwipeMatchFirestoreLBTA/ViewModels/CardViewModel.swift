//
//  CardViewModel.swift
//  SwipeMatchFirestoreLBTA
//
//

import UIKit

//create a contract between multiple different classes
//basically implementing objected oriented programming 
protocol ProducesCardViewModel{
    func toCardViewModel() -> CardViewModel
    
}

struct CardViewModel {
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
}

