//
//  APICaller.swift
//  NetflixClone
//
//  Created by Mohammed Osman on 10/04/2023.
//

import Foundation


struct Constants {
    static let API_KEY = "697d439ac993538da4e3e60b54e762cd"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyDqX8axTGeNpXRiISTGL7Tya7fjKJDYi4g"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    case failedToFetchData
}

class APICaller {
    static let shared = APICaller()
    
    // MARK: - Public
    
    // MARK: getTrendingMovies
    func getTrendingMovies( complition: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day") else {
            return
        }
        
        self.createBaseRequest(with: url) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    debugPrint("Error while fetch trending: \(String(describing: error))")
                    complition(.failure(APIError.failedToFetchData))
                    return
                }
                
                
                do {
                    let result = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                    complition(.success(result.results))
                    
                } catch  {
                    debugPrint("Error while decoding trending data: \(String(describing: error))")
                    complition(.failure(error))
                }
            }
            
            task.resume()
        }
        
        
    }
    
    // MARK: getTrendingTvs
    func getTrendingTvs( complition: @escaping (Result<[Tv], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day") else {
            return
        }
        
        self.createBaseRequest(with: url) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    debugPrint("Error while fetch trending: \(String(describing: error))")
                    complition(.failure(APIError.failedToFetchData))
                    return
                }
                
                
                do {
                    let result = try JSONDecoder().decode(TrendingTVResponse.self, from: data)
                    complition(.success(result.results))
                    
                } catch  {
                    debugPrint("Error while decoding trending data: \(String(describing: error))")
                    complition(.failure(error))
                }
            }
            
            task.resume()
        }
        
        
    }
    
    // MARK: - Private
    private func createBaseRequest(
        with url:URL?,
        completion: @escaping ((URLRequest) -> Void)) {
            guard var apiUrl = url else {
                return
            }
            
            
            apiUrl.append(queryItems: [
                URLQueryItem(name: "api_key", value: "\(Constants.API_KEY)"),
            ])
            var request = URLRequest(url: apiUrl)
            request.timeoutInterval = 30
            
            completion(request)
        }
}
