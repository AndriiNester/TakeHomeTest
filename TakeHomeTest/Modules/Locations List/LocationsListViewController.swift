//
//  LocationsListViewController.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/12/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import UIKit
import CoreLocation

class LocationsListViewController: UITableViewController {

    var viewModel: LocationsListViewModel!

    private static let showDetailsSegueId = "ShowDetails"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)

        let location = viewModel.locations[indexPath.row]
        cell.textLabel?.text = location.name
        cell.detailTextLabel?.text = viewModel.distance(to: location.coordinate)

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == LocationsListViewController.showDetailsSegueId {
            guard let selectedRowIndexPath = tableView.indexPathForSelectedRow else {
                return
            }
            let selectedLocation = viewModel.locations[selectedRowIndexPath.row]
            guard let viewController = segue.destination as? LocationDetailsViewController else {
                return
            }
            viewController.viewModel = LocationDetailsViewModel(location: selectedLocation)

            viewController.modelUpdated = { newLocation in
                self.viewModel.locations[selectedRowIndexPath.row] = newLocation
                self.tableView.reloadRows(at: [selectedRowIndexPath], with: .fade)
            }
        }
    }

}
