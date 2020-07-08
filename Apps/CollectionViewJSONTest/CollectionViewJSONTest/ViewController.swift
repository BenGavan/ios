//
//  ViewController.swift
//  CollectionViewJSONTest
//
//  Created by Ben Gavan on 01/05/2020.
//  Copyright © 2020 Ben Gavan. All rights reserved.
//

import UIKit

struct Property: Decodable {
    var price: Float32?
    var address: String?
    
    func priceString() -> String {
        guard let price = self.price else { return "" }
        return String(price)
    }
}

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellID = "cellId"
    
    private var properties: [Property]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.register(PropertyCell.self, forCellWithReuseIdentifier: cellID)
        
        getData { (newProperties) in
            self.properties = newProperties
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let size = properties?.count else { return 0 }
        return size
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? PropertyCell else { return UICollectionViewCell() }
        cell.property = properties?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    
    // MARK:- Networking
    private let baseURL = "http://localhost:8080/"
    
    private func getData(completion: @escaping ([Property]?) -> ()) {
        struct Response: Decodable {
            let properties: [Property]?
        }
        
        let urlString = baseURL + ""
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                print("ERROR: ", err)
                completion(nil)
                return
            }
            
            if let resp = resp {
                print("Response: ", resp)
            }
            
            guard let data = data else { completion(nil); return }
            print("Data: ", data)
            
            
            do {
                let dataResponse = try JSONDecoder().decode(Response.self, from: data)
                print(dataResponse)
                let properties = dataResponse.properties
                completion(properties)
            } catch {
                print("JSON Decoding failed")
            }
        }.resume()
    }
}

// MARK:- Property  Cell
class PropertyCell: UICollectionViewCell {
    
    var property: Property? {
        didSet {
            priceLabel.text = property?.priceString()
            addressLabel.text = property?.address
        }
    }
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.property?.priceString()
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.property?.address ?? ""
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    private func setupViews() {
        [priceLabel, addressLabel].forEach { (view) in
            self.addSubview(view)
        }
        
        priceLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        addressLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor).isActive = true

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
