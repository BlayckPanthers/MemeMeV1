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
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.strokeWidth: -3.0,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "Impact", size: 40)!

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

    // MARK : ACTIONS
    @IBAction func share(_ sender: Any) {
        let memeToShare = generateMemedImage()
        let activity = UIActivityViewController(activityItems: [memeToShare], applicationActivities: nil)
        activity.completionWithItemsHandler = { (activity, success, items, error) in
            if success {
                self.saveMeme(meme: memeToShare)
            }
        }
        present(activity, animated: true, completion:nil)
    }
    
    @IBAction func changePoliceAction(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Policy", message: "Choose a meme policy", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Helvetica", style: .default, handler: { _ in self.updateFont(font: "HelveticaNeue-CondensedBlack")}))
        
        alert.addAction(UIAlertAction(title: "Marker Felt", style: .default, handler: { _ in self.updateFont(font: "MarkerFelt-Wide")}))
        
        alert.addAction(UIAlertAction(title: "Futura", style: .default, handler: { _ in self.updateFont(font: "Futura-Medium")}))
        
        alert.addAction(UIAlertAction(title: "Impact", style: .default, handler: { _ in self.updateFont(font: "Impact")}))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in print("Cancel tapped")}))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func pickImageFromLibrary(_ sender: Any) {
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.sourceType = .photoLibrary
        present(imageController, animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        reinitializeUI()
        presentAlert(message: "All changes has been discarded")
    }
    
    @IBAction func takePictureWithCamera(_ sender: Any) {
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.sourceType = .camera
        present(imageController, animated: true, completion: nil)
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
    
    
    // MARK : MEME func
    func saveMeme(meme: UIImage){
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, imageSelected: imagePicked.image!, meme: meme)
        self.meme = meme
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
        presentAlert(message: "Image saved into your library")
        
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

