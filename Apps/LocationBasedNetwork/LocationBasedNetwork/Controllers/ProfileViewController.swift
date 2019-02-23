//
//  ProfileViewController.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 13/08/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ProfileTopBarDelegate, ProfileTopViewDelegate {
    
    weak var mainNavigationController: MainNavigationController?
    
    var user: User? {
        didSet {
            topBar.username = user?.username
            topView.user = user
        }
    }
    
    private let topBar = ProfileTopBar()
    private let topView = ProfileTopView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        
        topBar.delegate = self
        topView.delegate = self
        
        self.view.addSubview(topBar)
        self.view.addSubview(topView)
        
        topBar.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                      leading: self.view.leadingAnchor,
                      bottom: nil,
                      trailing: self.view.trailingAnchor,
                      height: 50)
        
        topView.anchor(top: topBar.bottomAnchor,
                       leading: self.view.leadingAnchor,
                       bottom: nil,
                       trailing: self.view.trailingAnchor,
                       height: 200)
    }
    
    // MARK: ProfileTopBarDelegate
    func back() {
        self.mainNavigationController?.popViewController(animated: true)
    }
    
    // MARK: ProfileTopViewDelegate
    func moveToPosts() {
        print("Moving to posts")
    }
    
    func moveToFollowing() {
        print("Moving to following")
    }
    
    func moveToFollowers() {
        print("Moving to followers")
        let followersViewController = FollowersListViewController()
        followersViewController.mainNavigationController = self.mainNavigationController
        self.mainNavigationController?.pushViewController(followersViewController, animated: true)
    }
    
    func moveToSettings() {
        let settingsViewController = SettingViewController()
        settingsViewController.mainNavigationController = self.mainNavigationController
        self.mainNavigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    func profileImageTouched() {
        print("Profile Image Touched")
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            topView.profileImageView.image = selectedImage
            ApiService.shared.upload(profileImage: selectedImage, completion: { (isSuccessful) in
                print("Uploading new profile photo successfull")
            })
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled image picker")
        dismiss(animated: true, completion: nil)
    }
}




// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

