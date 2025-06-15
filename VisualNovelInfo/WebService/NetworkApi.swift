//
//  NetworkApi.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 14/06/25.
//

import Foundation

enum ErrorNetwork: Error {
    case badURL
    case badJSON
    case badResponse
    
    func getMessage() -> String {
        switch self {
        case .badURL:
            return NSLocalizedString("There was a problem creating the url", comment: "There was a problem creating the url")
        case .badJSON:
            return NSLocalizedString("There was a problem parsing the json", comment: "There was a problem parsing the json")
        case .badResponse:
            return NSLocalizedString("The service didn't respond", comment: "The service didn't respond")
        }
    }
}

protocol NetworkApiProtocol: AnyObject {
    var urlConfiguration: URLConfiguration { get set }
    func search<T: Decodable>(withRequest requestSearch: Request, andCompletionHandler handler: @escaping (Result<T, ErrorNetwork>) -> Void)
}

class ServiceApi: NetworkApiProtocol {
    
    var urlConfiguration: URLConfiguration
    private var arrQueryItems: [URLQueryItem]?
    
    init(configuration: URLConfiguration, arrQueryItems: [URLQueryItem]? = nil) {
        self.urlConfiguration = configuration
        self.arrQueryItems = arrQueryItems
    }
    
    func search<T>(withRequest requestSearch: Request, andCompletionHandler handler: @escaping (Result<T, ErrorNetwork>) -> Void) where T : Decodable {
        guard let url = urlConfiguration.configureURL(withQueryItems: arrQueryItems), let jsonData = try? JSONEncoder().encode(requestSearch) else {
            handler(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                handler(.failure(.badResponse))
                return
            }
            let str = String(decoding: data, as: UTF8.self)
            if let json = try? JSONDecoder().decode(T.self, from: data) {
                handler(.success(json))
            } else {
                handler(.failure(.badJSON))
            }
        }.resume()
    }
}
