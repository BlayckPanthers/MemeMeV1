//
//  MemeTableViewCell.swift
//  MemeMeV1
//
//  Created by Fabien Lebon on 12/04/2020.
//  Copyright © 2020 Fabien Lebon. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var memeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
