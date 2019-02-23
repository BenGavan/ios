//
//  ViewController.swift
//  Read Write from Text File
//
//  Created by Ben Gavan on 23/02/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "File Contents"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var readFileButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Read File", for: .normal)
        button.addTarget(self, action: #selector(handleRead), for: .touchUpInside)
        return button
    }()
    
    lazy var writeFileButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Write to File", for: .normal)
        button.addTarget(self, action: #selector(handleWrite), for: .touchUpInside)
        return button
    }()
    
    var counter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        self.view.addSubview(label)
        self.view.addSubview(readFileButton)
        self.view.addSubview(writeFileButton)

        label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        readFileButton.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        readFileButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        readFileButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        writeFileButton.topAnchor.constraint(equalTo: readFileButton.bottomAnchor).isActive = true
        writeFileButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        writeFileButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    private func writeToFile() {
        let fileName = "Test"
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        
        print("file Path: \(fileURL.path)")
        
        let writeString = "Write this text to file"
        do {
            try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error {
            print("Failed to write to file")
            print(error)
        }
    }
    
    @objc private func handleRead() {
        print("reading")
        let fileName = "Test"
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        var readString = ""
        do {
            readString = try String(contentsOf: fileURL)
            label.text = "File Contents: " + readString
        } catch let error {
            print("Failed to read file")
            print(error)
        }
    }
    
    @objc private func handleWrite() {
        print("write")
        let fileName = "Test"
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        
        print("file Path: \(fileURL.path)")
        
        let writeString = "Write this text to file \(counter)"
        counter += 1
        do {
            try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error {
            print("Failed to write to file")
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

