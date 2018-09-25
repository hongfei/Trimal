//
// Created by Hongfei on 2018/9/6.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit

class NewTimeZoneViewController : UITableViewController, UISearchResultsUpdating {
    var cities: [String] = []
    var filteredCitites: [String] = []
    var searchController = UISearchController(searchResultsController: nil)

    override var navigationItem: UINavigationItem {
        let navItem = UINavigationItem()
        navItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelNewTimeZone))
        navItem.searchController = searchController
        navItem.searchController?.hidesNavigationBarDuringPresentation = false
        navItem.hidesSearchBarWhenScrolling = false
        return navItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(NewTimeCityListCell.self, forCellReuseIdentifier: "NewTimeCityListCell")
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.filteredCitites = self.cities
    }

    @IBAction func cancelNewTimeZone() {
        self.navigationController?.dismiss(animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCitites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewTimeCityListCell") as? NewTimeCityListCell {
            cell.loadViewData(cityName: filteredCitites[indexPath.row])
            return cell
        }

        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nickNameController = NewTimeZoneNickNameViewController()
        nickNameController.selectedCity = self.filteredCitites[indexPath.row]
        self.show(nickNameController, sender: self)
    }

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            self.filteredCitites = self.cities.filter({ city in city.contains(searchText) })
        } else {
            self.filteredCitites = self.cities
        }
        self.tableView.reloadData()
    }
}

