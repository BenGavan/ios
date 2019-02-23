//
//  LoginViewController+handler.swift
//  ChatAppFirebase
//
//  Created by Ben Gavan on 04/02/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit
import Firebase

extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    @objc func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func handleRegister() {
        guard let email = emailTextField.text else { print("Form is not Valid"); return }
        guard let password = passwordTextField.text else { print("Form is not Valid"); return }
        guard let name = nameTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                print(error as Any)
                return
            }
            
            guard let uid = user?.uid else { return }
            guard let profileImage = self.profileImageView.image else { return }
            
            let imageName = NSUUID().uuidString
            let storageReference = Storage.storage().reference().child("profile_images").child("\(imageName).jpg")
            
            if let uploadData = UIImageJPEGRepresentation(profileImage, 0.1) {  // Compression to 10% of original quality
            
//            if let uploadData = UIImagePNGRepresentation(profileImage) {
                storageReference.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        print(error as Any)
                        return
                    }
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                        let values = ["name": name, "email": email, "profileImageUrl": profileImageUrl]
                        self.registerUserInfoDatabase(with: uid, values: values as [String : AnyObject])
                    }

                    print(metadata as Any)
                })
            }
        }
    }
    
    private func registerUserInfoDatabase(with uid: String, values: [String: AnyObject]) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users").child(uid)
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err as Any)
                return
            }
            
//            self.messagesController?.fetchUserAndSetupNavBarTitle()
//            self.messagesController?.navigationItem.title = values["name"] as? String
            let user = UserData()
            user.name = values["name"] as? String
            user.email = values["email"] as? String
            user.profileImageUrl = values["profileImageUrl"] as? String
            
            self.messagesController?.setupNavBar(with: user)
            
            self.dismiss(animated: true, completion: nil)
            print("Saved user successfully")
        })
    }
    
    @objc func handleLoginRegisterChange() {
        let selectedIndex = loginRegisterSegmentedControl.selectedSegmentIndex
        let title = loginRegisterSegmentedControl.titleForSegment(at: selectedIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
        inputsContainerViewHeightAnchor?.constant = selectedIndex == 0 ? 100 : 150
        
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: selectedIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: selectedIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: selectedIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
    }
}
