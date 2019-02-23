//
//  SettingsLauncher.swift
//  youtubeTesting
//
//  Created by Ben Gavan on 29/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class Setting: NSObject {
    
    let name: SettingName
    let imageName: String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
}

enum SettingName: String {
    case Setting = "Settings"
    case TermsAndPrivacy = "Terms & Privacy Policy"
    case SendFeedback = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
    case Cancel = "Camcel & Dismiss"
}

class SettingsLauncher: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let blackView = UIView()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        cv.register(SettingsMenuCell.self, forCellWithReuseIdentifier: cellId)
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight = 50
    
    let settings: [Setting] = {
        let setting = Setting(name: .Setting, imageName: "settings")
        let termsAndPrivacy = Setting(name: .TermsAndPrivacy, imageName: "privacy")
        let feeedBack = Setting(name: .SendFeedback, imageName: "feedback")
        let help = Setting(name: .Help, imageName: "help")
        let switchAccount = Setting(name: .SwitchAccount, imageName: "switch_account")
        let cancel = Setting(name: .Cancel, imageName: "cancel")
        return [setting, termsAndPrivacy, feeedBack, help, switchAccount, cancel]
    }()
    
    weak var homeViewController: HomeViewController?
    
    @objc func showSettings() {
        //show menu
        if let window = UIApplication.shared.keyWindow {
            self.blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            self.blackView.alpha = 0
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            blackView.frame = window.frame
            let height = CGFloat(settings.count * cellHeight)
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                
            }
        }) { (isCompleted: Bool) in
            print("done")
        }
    }
    
    func handleDismissFor(setting: Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                
            }
        }) { (isCompleted: Bool) in
            if setting.name != .Cancel {
                print(setting.name)
                self.homeViewController?.showControllerFor(setting: setting)
            }
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsMenuCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: CGFloat(cellHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = self.settings[indexPath.item]
        handleDismissFor(setting: setting)
    }
   
   
    
}
