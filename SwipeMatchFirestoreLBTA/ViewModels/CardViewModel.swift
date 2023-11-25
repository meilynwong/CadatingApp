//
//  CardViewModel.swift
//  SwipeMatchFirestoreLBTA
//
// Modified on 24 NOV 2024 by DJ 
//

import UIKit

//create a contract between multiple different classes
//basically implementing objected oriented programming 
protocol ProducesCardViewModel{
    func toCardViewModel() -> CardViewModel
    
}

//View model gottta represent state of our view
class CardViewModel {
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment){
        self.imageNames = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    
    fileprivate var imageIndex = 0 {
        didSet{
            //when we are advancing to next photo,
            //go inside your cardviewmodel 
            let imageName = imageNames[imageIndex]
            let image = UIImage(named:imageName)
            //unwrap the guy as not optional
            imageIndexObserver?(imageIndex,image)
        }
    }
    
    
    //Introducing Reactive Programming
    //Expose a property on view model object so that you can notify other external classes
    var imageIndexObserver: ((Int, UIImage?) ->())?
    

    func advanceToNextPhoto(){
        imageIndex = min(imageIndex + 1, imageNames.count - 1)
    }
    
    func goToPrevPhoto(){
        imageIndex = max(0,imageIndex - 1)
    }
}


//How to apply Reactive Programming
//Identify abstraction area
