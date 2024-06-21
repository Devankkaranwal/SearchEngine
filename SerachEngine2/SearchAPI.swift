//
//  SearchAPI.swift
//  SerachEngine2
//
//  Created by Devank on 21/06/24.
//

import Foundation
import UIKit


class SearchAPI {
  
    let apiKey: String
    let cx: String
    lazy var url: URL = {
        return URL(string: "https://www.googleapis.com/customsearch/v1?key=\(self.apiKey)&cx=\(self.cx)")!
    }()

    init(apiKey: String, cx: String) {
        self.apiKey = apiKey
        self.cx = cx
    }
    
    
    
    func search(query: String, completion: @escaping ([SearchResult]) -> Void) {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "cx", value: cx),
            URLQueryItem(name: "key", value: apiKey)
        ]

        guard let searchURL = components.url else {
            print("Error creating search URL")
            return
        }

        var request = URLRequest(url: searchURL, cachePolicy:.useProtocolCachePolicy)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error searching: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data returned from search")
                return
            }

            do {
                let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                let searchResults = searchResponse.items
                completion(searchResults)
            } catch {
                print("Error parsing search response: \(error.localizedDescription)")
            }
        }.resume()
    }
}

struct SearchResult: Codable {
    let title: String
    let link: String
    let snippet: String
}

struct SearchResponse: Codable {
    let items: [SearchResult]
}
