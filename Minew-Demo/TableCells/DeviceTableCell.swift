//
//  DeviceTableCell.swift
//  Minew-Demo
//
//  Created by Harsh Vardhan Kushwaha on 08/02/24.
//

import UIKit

class DeviceTableCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var macLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(name: String, mac: String) {
        self.nameLabel.text = name
        self.macLabel.text = mac
    }
}
