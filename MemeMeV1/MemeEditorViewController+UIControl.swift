//
//  MemeEditorViewController+UIControl.swift
//  MemeMeV1
//
//  Created by Fabien Lebon on 06/04/2020.
//  Copyright © 2020 Fabien Lebon. All rights reserved.
//

import Foundation
import UIKit

extension MemeEditorViewController {
    // MARK : UI func
    func initializeTextFields(){
        setupTextFieldStyle(toTextField: topTextField, defaultText: "")
        setupTextFieldStyle(toTextField: bottomTextField, defaultText: "")
    }
    
    func reinitializeUI(){
        updateTextFieldText(textField: topTextField, text: "")
        updateTextFieldText(textField: bottomTextField, text: "")
        enableOrDisableTopBarButton(enable: false)
        imagePicked.image = .none
    }
    
    func setupTextFieldStyle(toTextField textField: UITextField, defaultText: String) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.delegate = self
        textField.textAlignment = .center
        textField.autocapitalizationType = .allCharacters
        textField.text = defaultText
    }
    
    
    func updateTextFieldText(textField: UITextField, text: String){
        textField.text = text
    }
    
    func disableButton() {
        buttonTakePicture.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        enableOrDisableTopBarButton(enable: false)
    }
    
    func enableOrDisableTopBarButton(enable: Bool){
        shareButton.isEnabled = enable
        //cancelButton.isEnabled = enable
    }
    
    func presentAlert(message: String) {
        let alert = UIAlertController(title: "Informations", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in print("OK tapped")}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideOrShowToolbars(hide: Bool) {
        topBar.isHidden = hide
        bottomBar.isHidden = hide
    }
    
    func updateFont(font: String) {
        topTextField.font = UIFont(name: font, size: 40)
        bottomTextField.font = UIFont(name: font, size: 40)
    }
}
