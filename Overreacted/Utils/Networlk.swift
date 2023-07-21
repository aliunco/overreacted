//
//  Networlk.swift
//  Overreacted
//
//  Created by Ali Saeedifar on 7/20/23.
//

import Foundation
import Combine


@available(iOS 13.0, *)
class NetworkManager {
    
    // signleton 🙈
    static let shared = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    
    private init() {}
    
    func getData<T: Decodable>(urlString: String) -> Future<T, Error> {
        return Future<T, Error> { [weak self] promise in
            
            guard let baseUrl = ProcessInfo.processInfo.environment["BASE_URL"] else {
                return promise(.failure(NetworkError.noBaseUrlFound))
            }
            
            guard let self = self, let url = URL(string: "\(baseUrl)\(urlString)") else {
                return promise(.failure(NetworkError.invalidURL))
            }
            
            #if DEBUG
            print("URL is \(url.absoluteString)")
            #endif
            
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: { promise(.success($0)) })
                .store(in: &self.cancellables)
        }
    }
}


enum NetworkError: Error {
    case invalidURL
    case noBaseUrlFound
    case responseError
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noBaseUrlFound:
            return "Please provide a base url in the enviroment variable of your scheme"
        case .responseError:
            return "Unexpected status code"
        case .unknown:
            return "Unknown error"
        }
    }
}



