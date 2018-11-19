//
// Created by Hongfei on 2018/9/6.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit

class NewTimeZoneViewController : UITableViewController, UISearchResultsUpdating {
    var cities: [String] = []
    var filteredCities: [String] = []
    var searchController = UISearchController(searchResultsController: nil)

    override var navigationItem: UINavigationItem {
        let navItem = UINavigationItem()
        navItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(cancelNewTimeZone))
        navItem.hidesSearchBarWhenScrolling = false
        return navItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(NewTimeCityListCell.self, forCellReuseIdentifier: "NewTimeCityListCell")
        self.definesPresentationContext = true
        self.definesPresentationContext = false
        self.filteredCities = self.cities
        setSearchBar()
    }
    
    func setSearchBar() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.barTintColor = .white
        if let textfield = self.searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        }
        
        self.tableView.tableHeaderView = self.searchController.searchBar
    }

    @IBAction func cancelNewTimeZone() {
        self.navigationController?.dismiss(animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewTimeCityListCell") as? NewTimeCityListCell {
            cell.loadViewData(cityName: filteredCities[indexPath.row])
            return cell
        }

        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nickNameController = NewTimeZoneNickNameViewController()
        nickNameController.city = self.filteredCities[indexPath.row]
        self.searchController.isActive = false
        self.navigationController?.pushViewController(nickNameController, animated: true)
    }

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            self.filteredCities = self.cities.filter({ city in city.lowercased().contains(searchText.lowercased()) })
        } else {
            self.filteredCities = self.cities
        }
        self.tableView.reloadData()
    }
}

