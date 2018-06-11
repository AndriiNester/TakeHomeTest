//
//  MainViewController.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/11/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let viewModel = MainViewModel()

    private var childMapViewController: MapViewController?

    @IBOutlet private weak var tabSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.locationsUpdated = { [weak self] in
            NSLog("locations updated")
            guard let _self = self else {
                return
            }
            _self.childMapViewController?.viewModel = MapViewModel(defaultLocations: _self.viewModel.defaultLocations, userLocations: _self.viewModel.userLocations)
        }

        viewModel.didFailToFetchDefaultLocations = { _ in
            NSLog("error when fetching default locations")
        }

        viewModel.didFailToFetchUserLocations = { _ in
            NSLog("error when fetching user locations")
        }

        viewModel.fetchDefaultLocations()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        childMapViewController = segue.destination as? MapViewController
    }

}
