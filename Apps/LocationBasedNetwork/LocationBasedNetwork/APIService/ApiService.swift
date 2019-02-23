//
//  ApiService.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 31/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import MapKit

enum ResponseCode: Int {
    case userCreated = 900
    case userExists = 901
    case userNotFound = 902
    case userLoggedIn = 903
    case userLoggedOut = 904
    case userNotCreated = 905
}

struct LoginResponse: Decodable {
    var responseCode: Int
    var token: String
    var username: String
    var email: String
    var error: String
}

struct SignUpResponse: Decodable {
    var responseCode: Int
    var token: String
    var username: String
    var email: String
    var error: String
}

class ApiService {
    
    private let TAG = "ApiService"
    
    static let shared = ApiService()
    
    let baseUrl = "http://localhost:8000"
    
    private struct DoesUsernameExistResponse: Codable {
        let isLoggedIn: Bool?
        let uid: String?
        let displayName: String?
        let profilePhotoUrl: String?
        let amFollowing: Bool?
    }
    
    private struct GetUserInfoResponse: Codable {
        let isLoggedIn: Bool?
        let uid: String?
        let username: String?
        let displayName: String?
        let profilePhotoUrl: String?
        let amFollowing: Bool?
    }
    
    private struct FollowResponse: Codable {
        let isLoggedIn: Bool?
        let isSuccessful: Bool?
        let followedUID: String?
        let yourNumberOfFollowers: Int?
    }
    
    private struct RemoveFollowResponse: Codable {
        let isLoggedIn: Bool?
        let isSuccessful: Bool?
        let uidFollowRemoved: String?
        let yourNumberOfFollowers: Int?
    }
    
    func fetchMessages() {
        let jsonUrlString = baseUrl + "/messages"
        guard let url = URL(string: jsonUrlString) else { return }
        
        let urlSession = URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                let json = try JSONDecoder().decode([Friend].self, from: data)
                
                for item in json {
                    print(item)
                }
                
            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
        }
        urlSession.resume()
    }
    
    func fetchMoments(completion: @escaping ([Moment]) -> ()) {
        let jsonUrlString = baseUrl + "/recent"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                var moments = [Moment]()
                let testData = try JSONDecoder().decode([MomentIn].self, from: data)
                
                for item in testData {
                    
                    let moment = Moment(user: item.user, text: item.text!, id: item.id!, type: .text, time: Date(), location: CLLocationCoordinate2D(latitude: Double(item.latitude!)!, longitude: Double(item.longitude!)!))
                    moments.append(moment)
                    print("recieved: ", moment)
                }
                
                print(testData)
                
            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
            }.resume()
    }
    
    func postMoment(with text: String) {
        let parameters = ["username": "@kilo_loco", "tweet": text]
        
        guard let url = URL(string: "http://localhost:8080/newMoment") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    }
    
    func postMomentFor(user: User, moment: Moment) {
        let parameters = ["username": user.username, "momentTextBody": moment.text]
        
        let urlString = baseUrl + "/newmoment"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    }
    
    
    // needs to get reference to current view to display invalid credentails meesage and/or proceed into app
    func login(with email: String, password: String, delegate: LoginViewController) {
        let parameters = ["email": email, "password": password]
        
        let urlString = baseUrl + "/loginwithemail"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            }
            
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let responseJson = try JSONDecoder().decode(LoginResponse.self, from: data)
                    print(responseJson)
                    
                    if responseJson.responseCode == ResponseCode.userLoggedIn.rawValue {
                        let token = responseJson.token
                        let username = responseJson.username
                        UserDefaults.shared.setLoggedIn(value: true)
                        UserDefaults.shared.set(token: token)
                        UserDefaults.shared.set(username: username)
                        UserDefaults.shared.set(password: password)
                        
                        delegate.moveToHome()
                    } else if responseJson.responseCode == ResponseCode.userNotFound.rawValue {
                        delegate.displayLoginError()
                        print("user not found", responseJson.responseCode)
                    }
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    func signup(with user: NewUser, delegate: SignUpViewController) {
        
        guard let username = user.userName else { return }
        guard let password = user.password else { return }
        guard let name = user.name else { return }
        guard let email = user.email else { return }
        
        
        let parameters = ["username": username,
                          "password": password,
                          "name": name,
                          "email": email]
        
        let urlString = baseUrl + "/register"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("error: ", error)
            }
            
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let responseJson = try JSONDecoder().decode(LoginResponse.self, from: data)
                    print(responseJson)
                    
                    if responseJson.responseCode == ResponseCode.userCreated.rawValue {
                        let token = responseJson.token
                        let username = responseJson.username
                        UserDefaults.shared.setLoggedIn(value: true)
                        UserDefaults.shared.set(token: token)
                        UserDefaults.shared.set(username: username)
                        UserDefaults.shared.set(password: password)
                        UserDefaults.shared.set(email: email)
                        print("success")
                        
                        delegate.proceedToHome()
                        
                    } else if responseJson.responseCode == ResponseCode.userNotFound.rawValue {
                        print("user not found", responseJson.responseCode)
                    }
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    }
    
    func fetchAllUsers(completion: @escaping ([User]?) -> ()) {
        let jsonUrlString = baseUrl + "/allusers"
        guard let url = URL(string: jsonUrlString) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: ", error)
                completion(nil)
                return
            }
            
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let users = try JSONDecoder().decode([User].self, from: data)
                    print(users)
                    
                    completion(users)
                    return
                } catch {
                    print(error)
                }
            }
            completion(nil)
            return
        }
    }
    
    func doesUsernameExist(username: String, completion: @escaping (User?) -> ()) {
        print(TAG, "trying \(username)")
        let username = username.lowercased()
        let jsonUrlString = baseUrl + "/isusernamevalid?name=" + username
        guard let url = URL(string: jsonUrlString) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: ", error)
                completion(nil)
                
                return
            }
            
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let usernameRespose = try JSONDecoder().decode(DoesUsernameExistResponse.self, from: data)
                    print(usernameRespose)
                    
                    let user = User(uid: usernameRespose.uid,
                                    displayName: usernameRespose.displayName,
                                    userName: username,
                                    profileImageUrl:usernameRespose.profilePhotoUrl,
                                    amFollowing: usernameRespose.amFollowing)
                    print(user)
                    completion(user)
                    return
                } catch {
                    print("fsiled")
                }
            }
            completion(nil)
            return
            }.resume()
    }
    
    func getUserInfoFor(username: String, completion: @escaping (User?) -> ()) {
        print(TAG, "trying \(username)")
        let username = username.lowercased()
        let jsonUrlString = baseUrl + "/getuserinfo?name=" + username
        guard let url = URL(string: jsonUrlString) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: ", error)
                completion(nil)
                return
            }
            
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let userInfoRespose = try JSONDecoder().decode(GetUserInfoResponse.self, from: data)
                    print(userInfoRespose)
                    
                    if let responseUsername = userInfoRespose.username {
                        if responseUsername == username {
                            print("Usernames do not match: \(responseUsername) != \(username)")
                        }
                    }
   
                    let user = User(uid: userInfoRespose.uid,
                                    displayName: userInfoRespose.displayName,
                                    userName: username,
                                    profileImageUrl: userInfoRespose.profilePhotoUrl,
                                    amFollowing: userInfoRespose.amFollowing)
                    print(user)
                    completion(user)
                    return
                } catch {
                    print("fsiled")
                }
            }
            completion(nil)
            return
            }.resume()
    }
    
    func follow(uid: String, onSuccess: @escaping (String, Bool) -> ()) {
        
        let parameters = ["to_follow_uid": uid]
        
        let urlString = baseUrl + "/follow"
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let followResponse = try JSONDecoder().decode(FollowResponse.self, from: data)
                    print(followResponse)
                    
                    guard let isLoggedIn = followResponse.isLoggedIn else { return }
                    guard let isSuccessful = followResponse.isSuccessful else { return }
                    guard let followedUID = followResponse.followedUID else { print("UID nil"); return }
                    
                    print("isLoggedIn:", isLoggedIn)
                    print("isSuccessful:", isSuccessful)
                    print("followedUID:", followedUID)

                    if isSuccessful {
                        onSuccess(followedUID, isSuccessful)
                        return
                    }
                    return
                } catch {
                    print("errrrmmm")
                    print(error)
                }
            }
            }.resume()
    }
    
    func unFollow(uid: String, onSuccess: @escaping (String, Bool) -> ()) {
        
        let parameters = ["to_remove_follow_uid": uid]
        
        let urlString = baseUrl + "/removefollow"
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let removeFollowResponse = try JSONDecoder().decode(RemoveFollowResponse.self, from: data)
                    print(removeFollowResponse)
                    
                    guard let isLoggedIn = removeFollowResponse.isLoggedIn else { return }
                    guard let isSuccessful = removeFollowResponse.isSuccessful else { return }
                    guard let unFollowedUID = removeFollowResponse.uidFollowRemoved else { print("UID nil"); return }
                    
                    print("isLoggedIn:", isLoggedIn)
                    print("isSuccessful:", isSuccessful)
                    print("removeFollowedUID:", unFollowedUID)
                    
                    if isSuccessful {
                        onSuccess(unFollowedUID, isSuccessful)
                        return
                    }
                    return
                } catch {
                    print("errrrmmm")
                    print(error)
                }
            }
            }.resume()
    }
    
    func upload(profileImage: UIImage, completion: (Bool) -> ()) {
        // TODO: UpFimageload image
    }
    

    func fetchCurrentUserData(completion: @escaping (User) -> ()) {
        let urlString = baseUrl + "/getcurrentuserinfo"
        ApiService.shared.fetch(urlString: urlString) { (userInfo: User) in
            completion(userInfo)
        }
    }
    
    func fetchFollowersFor(uid: String, completion: @escaping ([User]) -> ()) {
        let urlString = baseUrl + "/getfollowersforuid?uid=" + uid
        ApiService.shared.fetch(urlString: urlString, completion: completion)
    }
    
    func fetchFollowersForCurrentUser(completion: @escaping ([Follow]) -> ()) {
        let urlString = baseUrl + "/getfollowersforcurrentuser"
        ApiService.shared.fetch(urlString: urlString, completion: completion)
    }
    
    func fetchFollowingForCurrentUser(completion: @escaping ([Follow]) -> ()) {
        let urlString = baseUrl + "/getfollowingforcurrentuser"
        ApiService.shared.fetch(urlString: urlString, completion: completion)
    }
    
    func fetch<T: Decodable>(urlString: String, completion: @escaping (T) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                completion(obj)
            } catch let jsonErr {
                print("Failed to decode JSON:", jsonErr)
            }
        }.resume()
    }
    
    private func uploadProfile(image: UIImage?) {
        
        guard let imageData = image?.jpegData(compressionQuality: 1) else { print("imageData nil"); return }
        
        let str = "http://localhost:8080/upload2"
        guard let url = URL(string: str) else { print("Something went wrong creating url from string"); return }
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        var composedData = Data()
        
        // Set content type header
        let BoundaryConstant = "-----------------------"
        let contentType = "multipart/form-data; boundary=\(BoundaryConstant)"
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        // Empty form boundary
        //        composedData.append("--\(BoundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
        
        // Build multipart form to send image
        composedData.append("--\(BoundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
        composedData.append("Content-Disposition: form-data; name=\"file\"; filename=\"imae.jpg\"\r\n".data(using: String.Encoding.utf8)!)
        composedData.append("Content-Type: image/jpeg\r\n\r\n".data(using: String.Encoding.utf8)!)
        composedData.append(imageData)
        composedData.append("\r\n".data(using: String.Encoding.utf8)!)
        composedData.append("--\(BoundaryConstant)--\r\n".data(using: String.Encoding.utf8)!)
        
        //        composedData.append("--\(BoundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
        composedData.append("Content-Disposition: form-data; name=\"x\"".data(using: String.Encoding.utf8)!)
        //        composedData.append("Content-Type: text/plain\r\n\r\n".data(using: String.Encoding.utf8)!)
        composedData.append("some image".data(using: String.Encoding.utf8)!)
        composedData.append("\r\n".data(using: String.Encoding.utf8)!)
        composedData.append("--\(BoundaryConstant)--\r\n".data(using: String.Encoding.utf8)!)
        
        request.httpBody = composedData
        
        // Get content length
        let length = "\(composedData.count)"
        request.setValue(length, forHTTPHeaderField: "Content-Length")
        
        do {
            let returnData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: nil)
            let returnString = NSString(data: returnData, encoding: String.Encoding.utf8.rawValue)
            print("returnString = \(returnString!)")
        }
        catch let  error as NSError {
            print(error.description)
        }
    }
}














