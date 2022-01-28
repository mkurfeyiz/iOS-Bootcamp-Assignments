//
//  TVC_Phones.swift
//  rehber_ornek
//
//  Created by mkurfeyiz on 24.01.2022.
//

import UIKit

class TVC_Phones: UITableViewCell {
    @IBOutlet var lblPhone: UILabel!
    
    //var phone: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        //lblPhone.text = phone
    }
    
}
