//
//  RootViewCell.swift
//  iOS Example
//
//  Created by Nory Cao on 2017/3/8.
//  Copyright © 2017年 masterY. All rights reserved.
//

import UIKit

typealias Click = ()->Void

class RootViewCell: UITableViewCell {

    var downloadDidClick:Click?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func downloadAction(_ sender: Any) {
        if let click = self.downloadDidClick {
            click()
        }
    }
    
    @IBOutlet weak var downloadURL: UITextField!
}
