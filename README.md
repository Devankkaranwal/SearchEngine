## Overview
This is a simple search app that allows users to search for keywords and display the search results in a table view. The app uses the Google Custom Search API to fetch search results.

## Features
Search bar to input search queries
Search button to trigger search requests
Table view to display search results
Each search result displays the title and link of the result
Tapping on a search result opens the corresponding webpage in the default browser


## Technical Details
Written in Swift 5
Uses UIKit for the user interface
Utilizes the Google Custom Search API for search results
API key and custom search engine ID are stored in the ViewController class
Search results are parsed and stored in an array of SearchResult objects
Table view is used to display search results, with each cell displaying the title and link of the result

## Setup
Clone the repository and open the project in Xcode
Replace the apiKey and cx constants in the ViewController class with your own Google Custom Search API key and custom search engine ID
Run the app on a simulator or physical device
