//
//  ViewController.swift
//  MemeMeV1
//
//  Created by Fabien Lebon on 06/04/2020.
//  Copyright © 2020 Fabien Lebon. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet weak var bottomBar: UIToolbar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var buttonTakePicture: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    var selectedTextField: UITextField?
    
    var meme: Meme?
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .strokeWidth: -3.0,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "Impact", size: 40)!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableButton()
        initializeTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    //MARK: - ACTIONS Share
    @IBAction func share(_ sender: Any) {
        let memeToShare = generateMemedImage()
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, imageSelected: imagePicked.image!, memedImage: memeToShare)
        
        let activity = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
        
        activity.completionWithItemsHandler = { (activity, success, items, error) in
            if success {
                self.saveMeme(meme: meme)
                self.dismiss(animated: true, completion: nil)
            }
        }
        present(activity, animated: true, completion:nil)
    }
    
    // MARK: - Change Police Action
    @IBAction func changePoliceAction(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Policy", message: "Choose a meme policy", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Helvetica", style: .default, handler: { _ in self.updateFont(font: "HelveticaNeue-CondensedBlack")}))
        
        alert.addAction(UIAlertAction(title: "Marker Felt", style: .default, handler: { _ in self.updateFont(font: "MarkerFelt-Wide")}))
        
        alert.addAction(UIAlertAction(title: "Futura", style: .default, handler: { _ in self.updateFont(font: "Futura-Medium")}))
        
        alert.addAction(UIAlertAction(title: "Impact", style: .default, handler: { _ in self.updateFont(font: "Impact")}))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in print("Cancel tapped")}))
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Pick Image action
    @IBAction func pickImage(_ sender: UIBarButtonItem) {
        if sender.tag == 0 {
           openImagePicker(.photoLibrary)
       }else if sender.tag == 1 {
           openImagePicker(.camera)
       }else {
           print("No actions for this tag")
       }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        reinitializeUI()
        dismiss(animated: true, completion: nil)
    }
    
    func openImagePicker(_ type: UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = type
        present(picker, animated: true, completion: nil)
    }
    
    // Delegate performed when the user cancel picking an image
    // From : UIImagePickerControllerDelegate protocol
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("User Cancel picking an image")
        dismiss(animated: true, completion: nil)
    }
    
    // Delegate perfomed when pickImageFromLibrary() Action is tapped
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage ] as? UIImage {
            imagePicked.image = image
            imagePicked.contentMode = .scaleAspectFit
            enableOrDisableTopBarButton(enable: true)
            updateTextFieldText(textField: topTextField, text: "TOP")
            updateTextFieldText(textField: bottomTextField, text: "BOTTOM")
        }else {
            enableOrDisableTopBarButton(enable: false)
        }
        dismiss(animated: true, completion: nil)
    }
    
    // Delegate performed when a textField is tap
    // From : UITextFieldDelegate protocol
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.selectedTextField = textField
        updateTextFieldText(textField: textField, text: "")
    }
    
    // Delegate performed when return keyboard button is tapped
    // From : UITextFieldDelegate protocol
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- MEME funcs
    func saveMeme(meme: Meme){
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.memes.append(meme)
        
    }
    
    func generateMemedImage() -> UIImage {
        hideOrShowToolbars(hide: true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        hideOrShowToolbars(hide: false)

        return memedImage
    }
}

