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
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Enter Your Password" // title of the password
        titleLabel.textColor = labelTextColor // set up the text colore of the enter password title
        titleLabel.font = labelFont // set the lable font from above
        
        // need constrains
        NSLayoutConstraint.activate([titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin), // leading
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: standardMargin), // trailing
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: standardMargin)]) // top

        
        addSubview(textField) // adding text field
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.layer.borderWidth = 1 // textfield boarder
        textField.layer.borderColor = textFieldBorderColor.cgColor // text field boarder color
        textField.backgroundColor = bgColor // background color
        textField.isSecureTextEntry = true // password secure, to hide the text
        
        NSLayoutConstraint.activate([textField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin), // leading
            textField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: standardMargin), // trailing
            textField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: textFieldMargin), // top to make sure its under title field
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)])
        
        // need constrains
        
        addSubview(showHideButton) // show/hide text button
        showHideButton.frame = CGRect(x: 340, y: 40, width: 35, height: 35) // image location
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal) // use the image eyeclosed
        showHideButton.addTarget(self, action: #selector(eyebuttonTapped), for: .touchUpInside)
        
        addSubview(weakView) // weak password animation
        
        weakView.backgroundColor = .lightGray // weak color at strat
        weakView.frame = CGRect(x: standardMargin, y: 90, width: colorViewSize.width, height: colorViewSize.height)
        
//        let weakViewCons = textField.leadingAnchor.constraint(equalTo: self.textField.safeAreaLayoutGuide.leadingAnchor, constant: 30)

        
        addSubview(mediumView) // medium view animation
        mediumView.backgroundColor = .lightGray
        mediumView.frame = CGRect(x: standardMargin * 2 + colorViewSize.width, y: 90, width: colorViewSize.width, height: colorViewSize.height)
        
        addSubview(strongView) // strong view animation
        strongView.backgroundColor = .lightGray
        strongView.frame = CGRect(x: standardMargin * 10.5 + colorViewSize.width, y: 90, width: colorViewSize.width, height: colorViewSize.height)
        
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.text = "Too Weak" // default text
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        
//        strengthDescriptionLabel.frame = CGRect(x: standardMargin * 20 + colorViewSize.width, y: 90, width: colorViewSize.width, height: colorViewSize.height)
        
        NSLayoutConstraint.activate([strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin), strengthDescriptionLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin), strengthDescriptionLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin)])
        
//        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        self.textField.addSubview(stackView)
//
//        stackView.axis = .horizontal
//        stackView.distribution = .equalSpacing
//
//        stackView.addArrangedSubview(weakView)
//        stackView.addArrangedSubview(mediumView)
//        stackView.addArrangedSubview(strongView)
//
//        NSLayoutConstraint.activate(
//            [
//
//                stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
//                stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
//                stackView.bottomAnchor.constraint(equalTo: textField.safeAreaLayoutGuide.bottomAnchor, constant: -20)
//
//            ]
//        )
        
        
        
    }
    
    @objc func eyebuttonTapped() {
        if showHideButton.currentImage!.isEqual(UIImage(named: "eyes-open")) {
            textField.isSecureTextEntry = true
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        } else {
            textField.isSecureTextEntry = false
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        return true
    }
}
