//
//  CharacterTableViewController.swift
//  Rick&Morty
//
//  Created by Andrey Novikov on 12/13/19.
//  Copyright © 2019 Andrey Novikov. All rights reserved.
//

import UIKit

class ChracterTableViewController: UITableViewController {
    
    // MARK: Public properties
    var chracter: Chracter?
    let networkFetcher = NetworkFetcher()
    
    //MARK: Private properties
    private let urlString = CHRACTER_URL
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredChracter = [Result]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    private var isConnecting: Bool!
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Rick&Morty"
        tableView.backgroundColor = .black
        getCharacter()
        setupSearchController()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredChracter.count : chracter?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomViewCell
        
        let result = isFiltering ? filteredChracter[indexPath.row] : chracter?.results[indexPath.row]
        
        if isConnecting {
            cell.configure(with: result)
        } else {
            cell.configureWithUserDefaults(witf: result, indexPath: indexPath)
        }
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let person = isFiltering ? filteredChracter[indexPath.row] : chracter?.results[indexPath.row]
        
        let detailVC = segue.destination as! DetailViewController
        detailVC.chracter = person
        
    }
    
    // MARK: - Private methods
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .white
        }
    }
    
    private func getCharacter() {
        
        networkFetcher.fetchChracrter(urlsString: urlString) { (result, response)  in
            
            self.chracter = result
            self.isConnecting = true
            self.tableView.reloadData()
        }
        
        // IF INTERNET CONNECTION NOT AVAILABLE
        Reachability.shared.isConnectedToNetwork { (connection) in
            DispatchQueue.main.async {
                if !connection {
                    self.chracter = StorageManager.shared.fetchChracter()
                    self.isConnecting = false
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - UISearchResultsUpdating

extension ChracterTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        filteredChracter = (chracter?.results.filter({ (chracter: Result) in
            return chracter.name.lowercased().contains(searchText.lowercased())
            
        }))!
        tableView.reloadData()
    }
}
