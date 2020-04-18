//
//  MemeDetailViewController.swift
//  MemeMeV1
//
//  Created by Fabien Lebon on 18/04/2020.
//  Copyright © 2020 Fabien Lebon. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme: Meme!
    
    @IBOutlet weak var memeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeImage.image = meme.memedImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
   

}
