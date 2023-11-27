//
//  RegistrationController.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Daniel Jeong on 11/26/23.
//

import UIKit

class RegistrationController: UIViewController{
    
    //UI Components
    
    let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 275).isActive = true
        button.layer.cornerRadius = 16
        
        return button
    }()
    
    let fullNameTextField: CustomTextField = {
        let tf = CustomTextField(padding: 24)
        tf.placeholder = "Enter full name "
        tf.backgroundColor = .white
        return tf
    }()
    let emailTextField: CustomTextField = {
        let tf = CustomTextField(padding: 24)
        tf.placeholder = "Enter email "
        tf.backgroundColor = .white

        return tf
    }()
    let passwordTextField: CustomTextField = {
        let tf = CustomTextField(padding: 24)
        tf.placeholder = "Enter password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = .white
        return tf
    }()
    
    //I just copied and pasted this code
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.layer.cornerRadius = 22
        return button
    }()
    

    
   
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        setupGradientLayer()
        
        setupLayout()
        setupNotificationObservers()
        
        setupTapGesture()
    }
    
    // Private Functions
    
    // Function to set up a tap gesture recognizer to dismiss the keyboard when tapping outside of text fields
    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }

    // Handler for tap gesture, dismisses the keyboard
    @objc fileprivate func handleTapDismiss() {
        self.view.endEditing(true) // Dismisses the keyboard
    }

    // Function to set up notification observers for keyboard show and hide events
    fileprivate func setupNotificationObservers() {
        // Observer for keyboard show event
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // Observer for keyboard hide event
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // Cleanup when the view is about to disappear to avoid memory leaks
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self) // Removes observers to prevent retain cycle
    }

    // Handler for keyboard hide event, animates the view to its original position
    @objc fileprivate func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity // Resetting the view's transformation
        })
    }

    // Handler for keyboard show event, adjusts the view to accommodate the keyboard
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        // Extracting the keyboard frame from the notification
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        print(keyboardFrame)
        
        // Calculating the space between the bottom of the stack view and the bottom of the screen
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height
        print(bottomSpace)
        
        // Calculating the difference between the keyboard height and the available bottom space, and applying a transformation to the view
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
    }

    
    //stack view is created after the components whenever you want to access stackview
    lazy var stackView = UIStackView(arrangedSubviews: [
        selectPhotoButton,
        fullNameTextField,
        emailTextField,
        passwordTextField,
        registerButton])
    
    
    fileprivate func setupLayout() {
        
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil,
                         trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    fileprivate func setupGradientLayer(){
        let gradientLayer = CAGradientLayer()
        let topColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        // make sure to user cgColor or gradient colors dont show up correctly
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
}
