//
//  SportTableViewCell.swift
//  uitableview_load_data_from_json_swift_3
//
//  Created by Jian Heng Tang on 13/03/2018.
//  Copyright © 2018 kaleidosstudio. All rights reserved.
//

import UIKit

class SportTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
