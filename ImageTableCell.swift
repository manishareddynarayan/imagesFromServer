//
//  ImageTableCell.swift
//  imagesFromServer
//
//  Created by N Manisha Reddy on 2/12/18.
//  Copyright © 2018 N Manisha Reddy. All rights reserved.
//

import UIKit

class ImageTableCell: UITableViewCell {

    
    @IBOutlet weak var imgView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
