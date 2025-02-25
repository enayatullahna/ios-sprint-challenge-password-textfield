//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // States of the password strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    func setup() {
        // Lay out your subviews here
        self.backgroundColor = bgColor
        self.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        self.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40)
        self.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        self.layer.cornerRadius = 8
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Enter Your Password"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        
      
        NSLayoutConstraint.activate([titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin), // leading
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin), // top margin
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -standardMargin) // trailing
            ])

        
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.backgroundColor = bgColor
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 4
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textFieldMargin), // leading
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -textFieldMargin), // trailing
            textField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: textFieldMargin), // top to make sure its under title field
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight) // highth
            ])
        
        
        textField.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        
        textField.delegate = self
        textField.becomeFirstResponder()
    
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(PasswordField.eyeButtonTapped), for: .touchUpInside)
        
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        
        
        showHideButton.topAnchor.constraint(equalTo: textField.topAnchor).isActive = true // top
        showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -standardMargin).isActive = true // trailing
        showHideButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true // bottom
        showHideButton.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true // highth
        showHideButton.widthAnchor.constraint(equalToConstant: 40.0).isActive = true // width
        
    
        // Weak view
        addSubview(weakView)
        weakView.backgroundColor = .lightGray
        weakView.frame = CGRect(x: standardMargin, y: 94, width: colorViewSize.width, height: colorViewSize.height)
        

        // Medium View
        addSubview(mediumView)
        mediumView.backgroundColor = .lightGray
        mediumView.frame = CGRect(x: standardMargin * 2 + colorViewSize.width, y: 94, width: colorViewSize.width, height: colorViewSize.height)
        
        // strong view
        addSubview(strongView)
        strongView.backgroundColor = .lightGray
        strongView.frame = CGRect(x: standardMargin * 10.5 + colorViewSize.width, y: 94, width: colorViewSize.width, height: colorViewSize.height)
    
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.text = "Too Weak"
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 10)
        

        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.widthAnchor.constraint(equalToConstant: colorViewSize.width * 2).isActive = true
        strengthDescriptionLabel.heightAnchor.constraint(equalToConstant: colorViewSize.height * 2).isActive = true
        
    }
    
    @objc func eyeButtonTapped() {
        if showHideButton.currentImage!.isEqual(UIImage(named: "eyes-open")) {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            textField.isSecureTextEntry = true
            
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            textField.isSecureTextEntry = false
            
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    
        textField.delegate = self
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        password = newText
        
        if newText.count <= 9 {
            if newText.isEmpty{
            weakView.transform = CGAffineTransform(scaleX: 1.0, y: 1.6)
            UIView.animate(withDuration: 0.5) {
                self.weakView.transform = .identity
                
            }
            }
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = .lightGray
            strongView.backgroundColor = .lightGray
            strengthDescriptionLabel.text = passwordStrength.weak.rawValue
            
        } else if newText.count > 9 && newText.count <= 19 {
            if newText.count == 10 {
            mediumView.transform = CGAffineTransform(scaleX: 1.0, y: 1.6)
            UIView.animate(withDuration: 0.5) {
                self.mediumView.transform = .identity
            }
            }
            mediumView.backgroundColor = mediumColor
            weakView.backgroundColor = weakColor
            strongView.backgroundColor = .lightGray
            strengthDescriptionLabel.text = passwordStrength.medium.rawValue
            
        } else if newText.count > 19 && newText.count >= 20 {
            if newText.count == 20 {
            strongView.transform = CGAffineTransform(scaleX: 1.0, y: 1.6)
            UIView.animate(withDuration: 0.5) {
                self.strongView.transform = .identity
            }
            }
            mediumView.backgroundColor = mediumColor
            weakView.backgroundColor = weakColor
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = passwordStrength.strong.rawValue
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        sendActions(for: .valueChanged)
        textField.text = "" 
        return false
    }
}


enum passwordStrength: String {
    case weak = "Too Weak"
    case medium = "Could Be Stronger"
    case strong = "Strong"
}
