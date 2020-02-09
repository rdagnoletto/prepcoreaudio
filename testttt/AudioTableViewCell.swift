//
//  AudioTableViewCell.swift
//  testttt
//
//  Created by Rob Agnoletto on 2020-02-08.
//  Copyright © 2020 Rob Agnoletto. All rights reserved.
//

import UIKit

class AudioTableViewCell: UITableViewCell {
    @IBOutlet weak var audioName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
