//
//  HistoryEntryTableViewCell.swift
//  MOswift
//
//  Created by Chong Guo on 4/1/16.
//  Copyright © 2016 Chong Guo. All rights reserved.
//

import UIKit

class HistoryEntryTableViewCell: UITableViewCell {

    @IBOutlet weak var HistoryEntryDesLabel: UILabel!
    @IBOutlet weak var HistoryEntryTimeLabel: UILabel!
    @IBOutlet weak var HistoryEntryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
