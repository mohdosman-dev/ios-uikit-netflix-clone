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
    static let baseImageURL = "https://image.tmdb.org/t/p/w500"
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
    func getTrendingTvs( complition: @escaping (Result<[Movie], Error>) -> Void) {
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
    
    // MARK: getPopular
    func getPopular( complition: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular") else {
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
    
    // MARK: getUpcoming
    func getUpcoming( complition: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming") else {
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
    
    // MARK: getTopRated
    func getTopRated( complition: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated") else {
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
    
    // MARK: getTopRated
    func getDiscoverMovies( complition: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {
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
    
    // MARK: search
    func search( with query: String, complition: @escaping (Result<[Movie], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.baseURL)/3/search/multi?query=\(query)") else {
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
    
    // MARK: getTrailer
    func getTrailer( with query: String, complition: @escaping (Result<VideoElement, Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else {
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
                    let result = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                    complition(.success(result.items[0].id))
                    
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
