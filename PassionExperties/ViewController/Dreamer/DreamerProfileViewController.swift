//
//  DreamerProfileViewController.swift
//  PassionExperties
//
//  Created by shalu tyagi on 12/01/19.
//  Copyright © 2019 shalu tyagi. All rights reserved.
//

import UIKit

class DreamerProfileViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet weak var cameraIcon: UIButton!
  @IBOutlet weak var editIcon: UIButton!
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var email: UILabel!
  @IBOutlet weak var phoneNumber: UILabel!
  @IBOutlet weak var dob: UILabel!
  @IBOutlet weak var location: UILabel!
 

  override func viewDidLoad() {
    self.editIcon.adjustsImageWhenHighlighted = false
    self.cameraIcon.adjustsImageWhenHighlighted = false
  }
  
  func getProfileUser() {
    if  !InternetManager.sharedInstance.isReachable {
      self.addInternetNotAvailable()
    } else {
      
    }
  }
  
  override func retryBtnClicked(_ sender: AnyObject) {
    if  !InternetManager.sharedInstance.isReachable {
      Utilities.showAlertForMessage(message: "Please check your internet connection", vc: self)
    } else {
      self.removeInternetNotAvailable()
      self.getProfileUser()
    }
  }
  
  @IBAction func pressEditButton(_ sender: Any) {
  }
  
  @IBAction func pressCamraIcon(_ sender: Any) {
    let imagePickerViewController = UIImagePickerController()
    imagePickerViewController.delegate = self
    imagePickerViewController.allowsEditing = true
    
    let action1 = UIAlertAction(title: "Take Photo", style: UIAlertAction.Style.default) { (action) in
      if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
      {
        imagePickerViewController.sourceType = UIImagePickerController.SourceType.camera
          self.present(imagePickerViewController, animated: true, completion: nil)
      }
    }
    
    let action2 = UIAlertAction(title: "Choose from Gallery", style: UIAlertAction.Style.default) { (action) in
      imagePickerViewController.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imagePickerViewController, animated: true, completion: nil)
    }
    
    Utilities.showActionSheet("Upload Image", message: "Select File to upload", firstAction: action1 , secondAction: action2)
  }
  
  /// set profile image
  func setProfileImage(imageUrl: String?) {
    //  set ProfileImage
    if let profileImageUrl =  imageUrl {
      let mainUrl = "" + profileImageUrl
      let imageCache = ImageCache(imageUrl: mainUrl)
      imageCache.downloadImage({ [weak self] (image) -> (Void) in
        //success
        self?.profileImage.image = image
        }, failure: { [weak self] (error) -> (Void) in
          //failure
          self?.profileImage.image = UIImage(named:"profileUserIcon")
      })
    }
  }
  
  /// Delegate : UIImagePickerControllerDelegate
  private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let selectedImage = info[.originalImage] as? UIImage else {
      fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
    }
//    _ = UIImageJPEGRepresentation(selectedImage, 0.8)
    //checking internet connection
    //if 'false' show message
    if  InternetManager.sharedInstance.isReachable == false {
      Utilities.showAlertForMessage(message: "Internet_Not_Available", vc: self)
    } else {
      self.dismiss(animated: true, completion: nil)
    }
  }
}
