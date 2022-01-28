//
//  TVC_Urun.swift
//  liste_ornek
//
//  Created by mkurfeyiz on 18.01.2022.
//

import UIKit

class TVC_Urun: UITableViewCell {
    
    var urun: Urun!

    @IBOutlet var lblEskiFiyat: UILabel!
    @IBOutlet var lblYeniFiyat: UILabel!
    @IBOutlet var lblAltBaslik: UILabel!
    @IBOutlet var lblBaslik: UILabel!
    @IBOutlet var ivUrun: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
