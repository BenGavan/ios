//
//  ViewController.swift
//  CookieTesting
//
//  Created by Ben Gavan on 26/05/2020.
//  Copyright © 2020 Ben Gavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let nameField = UITextField()
    private let valueField = UITextField()
    
    private let testButton = UIButton(type: .system)
    private let createButton = UIButton(type: .system)
    private let getButton = UIButton(type: .system)
    private let deleteButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
        setupTestFields()
    }
    
    private func setupViews() {
        testButton.translatesAutoresizingMaskIntoConstraints = false
        testButton.addTarget(self, action: #selector(handleTest), for: .touchUpInside)
        testButton.setTitle("Test", for: .normal)
        
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.addTarget(self, action: #selector(handleCreate), for: .touchUpInside)
        createButton.setTitle("Create", for: .normal)
        
        getButton.translatesAutoresizingMaskIntoConstraints = false
        getButton.addTarget(self, action: #selector(handleGet), for: .touchUpInside)
        getButton.setTitle("Get", for: .normal)
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        deleteButton.setTitle("Delete", for: .normal)
        
        
        let sv = UIStackView(arrangedSubviews: [testButton, createButton, getButton, deleteButton])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        
        view.addSubview(sv)
                
        sv.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        sv.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupTestFields() {
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.placeholder = "cookie name"
        
        view.addSubview(nameField)
        
        nameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        
        valueField.translatesAutoresizingMaskIntoConstraints = false
        valueField.placeholder = "cookie value"
        
        view.addSubview(valueField)
        
        valueField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 40).isActive = true
        valueField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        valueField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true

    }
    
    // MARK:- Handlers
    @objc private func handleTest() {
        home()
    }
    
    @objc private func handleCreate() {
        createCookie(name: nameField.text ?? "", value: valueField.text ?? "")
    }
    
    @objc private func handleGet() {
        let name = nameField.text ?? ""
        getCookie(for: name)
    }
    
    @objc private func handleDelete() {
        let name = nameField.text ?? ""
        deleteCookie(for: name)
    }
    
    // MARK:- Networking
    let baseURL = "http://localhost:8080"
    
    func home() {
        let urlString = baseURL + "/"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, err) in
            print("Request Complete")
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                print("status code: \(statusCode)")
            }
            
            guard let data = data else { print("data is nil"); return }
            
            print("Data: ", String(bytes: data, encoding: .utf8) ?? "")
            
        }.resume()
    }
    
    func createCookie(name: String, value: String) {
        let urlString = baseURL + "/create?name=\(name)&value=\(value)"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, err) in
            print("Request Complete - Create Cookie")
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                print("status code: \(statusCode)")
            }
            
            guard let data = data else { print("data is nil"); return }
            
            print("Data: ", String(bytes: data, encoding: .utf8) ?? "")
            
        }.resume()
    }
    
    func getCookie(for name: String) {
        let urlString = baseURL + "/get?name=\(name)"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, err) in
            print("Request Complete - Get Cookie")
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                print("status code: \(statusCode)")
            }
            
            guard let data = data else { print("data is nil"); return }
            
            print("Data: ", String(bytes: data, encoding: .utf8) ?? "")
            
        }.resume()
    }
    
    func deleteCookie(for name: String) {
        let urlString = baseURL + "/delete?name=\(name)"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, err) in
            print("Request Complete - Create Cookie")
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                print("status code: \(statusCode)")
            }
            
            guard let data = data else { print("data is nil"); return }
            
            print("Data: ", String(bytes: data, encoding: .utf8) ?? "")
            
        }.resume()
    }
}

