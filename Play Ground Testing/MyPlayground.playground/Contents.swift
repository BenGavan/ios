//: Playground - noun: a place where people can play

import UIKit

func test() {
    let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
    guard let url = URL(string: jsonUrlString) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, err) in
        
        guard let data = data else { return }
        
        print(data)
        
        do {
            
            
            
        } catch let jsonErr {
            print("Error serializing json", jsonErr)
        }
        
        
        
        }.resume()
}



