//
//  NetworkinManager.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-03-31.
//

import Foundation
import Combine

class NetworkingManager {
    enum NetworkinError: LocalizedError{
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):return "Bad response form URL. \(url)"
            case .unknown: return  "UNknown error occured"
            }
        }
    }
    
    static func download(urlString: String) -> AnyPublisher<Data, Error> {
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({try handleURLResponse(output: $0,url:  url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL)throws -> Data{
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkinError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handlecompletion(completion: Subscribers.Completion<Error>){
        switch completion{
        case .finished:
            break;
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

