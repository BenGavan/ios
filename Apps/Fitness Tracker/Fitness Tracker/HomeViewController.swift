//
//  ViewController.swift
//  Fitness Tracker
//
//  Created by Ben Gavan on 24/08/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import LBTAComponents

 class HomeViewController: DatasourceController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView?.backgroundColor = UIColor(r: 232, g: 239, b: 241)
        
//        collectionView?.reloadItems(at: [IndexPath.init(item: 0, section: 0)])
        
        self.datasource = HomeDatasource()
        
    }
    
    
    /**
     Handler for when custom Segmented Control changes and will change the
     background color of the view depending on the selection.
     */
    public func changeColor(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            print("Run")
        case 2:
            print("Swim")
        default:
            print("Bike")
        }
        collectionView?.reloadItems(at: [IndexPath.init(item: 0, section: 0)])
        
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        return CGSize(width: view.frame.width, height: 50)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize.init(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize.init(width: view.frame.width, height: 20)
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }


}






class HomeGoalsFooter: DatasourceCell {
    
    let moreGoalsButton: UIButton = {
        let button = UIButton()
        button.setTitle("More Goals...", for: .normal)
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = .red
        
        addSubview(moreGoalsButton)
        
        moreGoalsButton.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        moreGoalsButton.addTarget(self, action: #selector(HomeGoalsFooter.buttonPressed), for: .touchUpInside)
    }
    
    @objc private func buttonPressed() {
        print("Button pressed")
        
        
    }
    
}


