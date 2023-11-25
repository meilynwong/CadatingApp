//
//  CardView.swift
//  SwipeMatchFirestoreLBTA
//
// Modified on 11/24/23 by DJ
//
 
import UIKit
 
class CardView: UIView {
    
    // if card is set, then you already set those properties from the viewModel data
    var cardViewModel: CardViewModel! {
        didSet {
            // accessing index 0 will crash if imageNames.count == 0
            let imageName = cardViewModel.imageNames.first ?? ""
            imageView.image = UIImage(named: imageName)
            informationLabel.attributedText = cardViewModel.attributedString
            informationLabel.textAlignment = cardViewModel.textAlignment
            
            
            (0..<cardViewModel.imageNames.count).forEach { (_) in
                let barView = UIView()
                barView.backgroundColor = barDeselectedColor
                barsStackView.addArrangedSubview(barView)
            }
            barsStackView.arrangedSubviews.first?.backgroundColor = .white
            
            setupImageIndexObserver()
        }
    }
    
    fileprivate func setupImageIndexObserver(){
        cardViewModel.imageIndexObserver = {[unowned self] (idx, image) in
            print("Changing photo from view model")
            //change the image from what the image we are being notified with 
            self.imageView.image = image
            
            self.barsStackView.arrangedSubviews.forEach({(v) in
                v.backgroundColor = self.barDeselectedColor
            })
            
            self.barsStackView.arrangedSubviews[idx].backgroundColor = .white
        }
    }
    //Don't want to expose properties to outside this view
    //encapsulation, dont make variabels accesible from other classes 
    fileprivate let imageView =  UIImageView(image: UIImage(named: "profilePic"))
    fileprivate let informationLabel = UILabel()
    fileprivate let gradientLayer = CAGradientLayer()
    //Configuration funcs
    fileprivate let threshold: CGFloat = 80
    
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    //var imageIndex = 0
    fileprivate let barDeselectedColor = UIColor(white: 0, alpha: 0.1)
    
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer){
        print("Handling tap and cycling photos")
        let tapLocation = gesture.location(in: nil)
        let shouldAdvanceNextPhoto = tapLocation.x > frame.width / 2 ? true : false
        
        if shouldAdvanceNextPhoto{
            cardViewModel.advanceToNextPhoto()
        }
        else{
            cardViewModel.goToPrevPhoto()
        }
    }
    
    fileprivate func setupLayout() {
        // custom drawing code
        layer.cornerRadius = 10
        clipsToBounds = true
        
        
        
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
        
        //set up horizontal bar
        setupBarsStackView()
        
        //Adding a gradient layer
        setupGradientLayer()
        
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        
        informationLabel.textColor = .white
        informationLabel.numberOfLines = 0
    }
    fileprivate let barsStackView = UIStackView()
    fileprivate func setupBarsStackView(){
        addSubview(barsStackView)
        barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 4))
        barsStackView.spacing = 4
        barsStackView.distribution = .fillEqually
        
      
        
    }

    //adding a subtle nice gradient kidna useless lol
    fileprivate func setupGradientLayer(){
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5,1.1]
        //self.frame is actually a zero frame so need to override after
        
        layer.addSublayer(gradientLayer)
        
        
    }
    //Everytime a view is going to draw itself
    
    override func layoutSubviews() {
        //in here you will figure out what the frame will be for cardview
        gradientLayer.frame = self.frame
        
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            //removing all animations in sub views instead of superview
            //for drag and drop behvaior
            superview?.subviews.forEach({ (subview) in
                subview.layer.removeAllAnimations()
            })
        case .changed:
            handleChanged(gesture)
        case .ended:
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
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard {
                self.frame = CGRect(x: 600 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
            } else {
                self.transform = .identity
            }
            
        }) { (_) in
            self.transform = .identity
            if shouldDismissCard {
                self.removeFromSuperview()
            }
            //self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}
