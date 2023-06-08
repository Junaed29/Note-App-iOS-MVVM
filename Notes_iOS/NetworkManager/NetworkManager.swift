//
//  NetworkManager.swift
//  IOS UiKit Skeleton
//
//  Created by Junaed Muhammad Chowdhury on 14/10/22.
//

import Foundation
import UIKit


struct NetworkManager {
    static let shared = NetworkManager()
    private init(){}
    
    let cache = NSCache<NSString, UIImage>()

    func httpRequest<T: Decodable>(urlString: String, httpMethodType: HttpMethodType, params: [String: Any]? = nil, respnseType: T.Type, completionHandler: @escaping(Result<T, NetworkErrors>) -> Void) {
        
        guard let removedSpaceURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)//This will fill the spaces with the %20
        else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        
        guard let url = URL(string: removedSpaceURL) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethodType.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        
        
        if let params{
            //request.httpBody = params.percentEscaped().data(using: .utf8)
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                completionHandler(.failure(.unableToComplete))
                return
            }
        }
        
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                completionHandler(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidDeta))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(respnseType, from: data)
                completionHandler(.success(decodedResponse))
            } catch {
                completionHandler(.failure(.invalidDeta))
            }
        }.resume()
        
    }
    
      
    func downloadImage(fromURLString urlString: String, completed: @escaping(UIImage?) -> Void ){
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey){
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            
            guard let data = data, let image = UIImage(data: data) else{
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            completed(image)
            
        }.resume()
    }
    
    
    enum HttpMethodType: String{
        case GET
        case POST
        case PUT
        case DELETE
    }
    
}


extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
