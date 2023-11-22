//
//  ViewController.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Daniel Jeong and Meilyn Wong  11/16/23
//  Copyright © 2023 
//

import UIKit

class HomeController: UIViewController {
    
    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let buttonsStackView = HomeBottomControlsStackView()
    
//    let users = [
//
//        User(name: "Kai", age: 21, profession: "Ladies Man", imageName: "profilePic"),
//        User(name: "Kiana", age: 26, profession: "Stone Cold Killah", imageName: "profilePic2")
//
//    ]
    
    let cardViewModels = [
        User(name: "Kai", age: 21, profession: "Ladies Man", imageName: "profilePic").toCardViewModel(),
        User(name: "Kiana", age: 26, profession: "Stone Cold Killah", imageName: "profilePic2").toCardViewModel()

    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupDummyCards()
    }
    
    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            cardView.imageView.image = UIImage(named: cardVM.imageName)
            cardView.informationLabel.attributedText = cardVM.attributedString
            cardView.informationLabel.textAlignment = cardVM.textAlignment
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
        
//        users.forEach { (user) in
//            let cardView = CardView(frame: .zero)
//            cardView.imageView.image = UIImage(named: user.imageName)
//            cardView.informationLabel.text = "\(user.name) \(user.age)\n\(user.profession)"
//            
//            let attributedText = NSMutableAttributedString(string: user.name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
//            attributedText.append(NSAttributedString(string: "   \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
//            
//            attributedText.append(NSAttributedString(string: "\n\(user.profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
//            
//            cardView.informationLabel.attributedText = attributedText
//
//            cardsDeckView.addSubview(cardView)
//            cardView.fillSuperview()
//        }
    }
    
    // MARK:- Fileprivate
    
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonsStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        overallStackView.bringSubviewToFront(cardsDeckView)
        
    }

}

