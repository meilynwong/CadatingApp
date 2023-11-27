//
//  RegistrationViewModel.swift
//  SwipeMatchFirestoreLBTA
//
//  Copyright © 2023 Brian Voong. All rights reserved.
//

import UIKit

class RegistrationViewModel {
    var fullName: String? {
        didSet {checkFormValidity()}
    }
    var email: String? {
        didSet {checkFormValidity()}
    }
    var password: String? {
        didSet {checkFormValidity()}
    }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
    }
    
    var isFormValidObserver: ((Bool) -> ())?
}
