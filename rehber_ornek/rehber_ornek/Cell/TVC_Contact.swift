//
//  TVC_Contact.swift
//  rehber_ornek
//
//  Created by mkurfeyiz on 24.01.2022.
//

import UIKit

class TVC_Contact: UITableViewCell {

    @IBOutlet var ivPhoto: UIImageView!
    @IBOutlet var lblFirstName: UILabel!
    @IBOutlet var lblLastName: UILabel!
    
    var contact: ContactTable!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        //Bu islemler burada yapilmiyor. initializedan once bunlari set edebilmek
        //icin onceki controllerda farkli bir fonk kullanabiliriz
        ivPhoto.image = UIImage(data: contact.photo!)
        lblFirstName.text = contact.firstName
        lblLastName.text = contact.lastName
    }
    
}
