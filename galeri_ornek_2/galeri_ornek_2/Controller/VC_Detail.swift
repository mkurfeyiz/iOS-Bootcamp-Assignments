//
//  VC_Detail.swift
//  galeri_ornek_2
//
//  Created by mkurfeyiz on 26.01.2022.
//

import UIKit

class VC_Detail: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var tfTitle: UITextField!
    @IBOutlet var tfLocation: UITextField!
    @IBOutlet var txtvDesc: UITextView!
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet var ivImage: UIImageView!
    
    var image: ImageTable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if image != nil {
            ivImage.image = UIImage(data: image.image ?? Data())
            tfTitle.text = image.title
            tfLocation.text = image.location
            txtvDesc.text = image.desc
            
        } else {
            btnDelete.isHidden = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.setImage))
            ivImage.isUserInteractionEnabled = true
            ivImage.addGestureRecognizer(tapGesture)
        }
    }
    
    //Tap Gesture Func
    @objc func setImage() {
        self.pickImage()
    }
    
    
    @IBAction func btnSave_TUI(_ sender: UIButton) {
        
        if self.image != nil {
            //Update
            self.image.title = tfTitle.text
            self.image.location = tfLocation.text
            self.image.desc = txtvDesc.text
            
            GalleryDal.update()
            
        } else {
            //New Image
            GalleryDal.saveImage(title: tfTitle.text ?? "", location: tfLocation.text ?? "", desc: txtvDesc.text ?? "", image: ivImage.image ?? UIImage())
        }
        
        performSegue(withIdentifier: "sgDetailToGallery", sender: nil)
    }
    
    @IBAction func btnDelete_TUI(_ sender: UIButton) {
        GalleryDal.delete(image: self.image)
        performSegue(withIdentifier: "sgDetailToGallery", sender: nil)
    }
    
    func pickImage() {
        let ac = UIAlertController(title: nil, message: "Choose an image", preferredStyle: .actionSheet)
        
        let camAction = UIAlertAction(title: "Take a photo", style: .default) {
            _ in
            //camera func
            self.chooseImage(sourceType: UIImagePickerController.SourceType.camera)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Pick from library", style: .default) {
            _ in
            //library func
            self.chooseImage(sourceType: UIImagePickerController.SourceType.photoLibrary)
        }
        
        ac.addAction(camAction)
        ac.addAction(photoLibraryAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(ac, animated: true, completion: nil)
    }
    
    func chooseImage(sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = sourceType
            present(imagePicker, animated: true, completion: nil)
            
        } else {
            if sourceType == UIImagePickerController.SourceType.camera {
                print("No camera available")
            } else {
                print("Photo library is not available.")
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let choosenImage = info[.originalImage] as! UIImage
        ivImage.image = choosenImage
        dismiss(animated: true, completion: nil)
    }
    
}
