//
//  ViewController.swift
//  SerachEngine2
//
//  Created by Devank on 21/06/24.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate,UITableViewDataSource, UITableViewDelegate {
    
       // Search Button
       let searchButton = UIButton(type:.system)
       let searchResultsTableView = UITableView()
       let searchBar = UISearchBar()
        
        var searchResults: [SearchResult] = []
        
        let apiKey = "AIzaSyCnu1JxNbNxH0i08cQvPfj0egbm6syl_WA"
        let cx = "e728fce4139dc4cea"
        let searchAPI: SearchAPI
        
        init() {
            searchAPI = SearchAPI(apiKey: apiKey, cx: cx)
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            searchAPI = SearchAPI(apiKey: apiKey, cx: cx)
            super.init(coder: coder)
        }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        // Set up search bar
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 44)
        ])

        // Set up search button
        searchButton.setTitle("Search", for:.normal)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for:.touchUpInside)
        view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 100),
            searchButton.heightAnchor.constraint(equalToConstant: 44)
        ])

        // Set up search results table view
        searchResultsTableView.dataSource = self
        searchResultsTableView.delegate = self
        view.addSubview(searchResultsTableView)
        searchResultsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchResultsTableView.topAnchor.constraint(equalTo: searchButton.bottomAnchor),
            searchResultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchResultsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        searchResultsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchResultCell")
    }
    
    


    @objc func searchButtonTapped() {
     
        guard let searchQuery = searchBar.text else { return }
        
        searchAPI.search(query: searchQuery) { [weak self] results in
         
            self?.parseSearchResults(results)
            
            DispatchQueue.main.async {
                self?.searchResultsTableView.reloadData()
            }
        }
    }
    
    
    func parseSearchResults(_ results: [SearchResult]) {
        searchResults = results
       }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
               let searchResult = searchResults[indexPath.row]
               cell.textLabel?.text = searchResult.title
               return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchResult = searchResults[indexPath.row]
        if let url = URL(string: searchResult.link) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}

