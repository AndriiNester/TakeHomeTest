//
//  MainViewController.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/11/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import UIKit

class MainViewController: UIPageViewController {

    let viewModel = MainViewModel()

    @IBOutlet private weak var tabSegmentedControl: UISegmentedControl!

    private var mainViewControllers: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()

        viewModel.locationsUpdated = { [weak self] in
            guard let _self = self else {
                return
            }
            _self.mainViewControllers.forEach {
                if let mapViewController = $0 as? MapViewController {
                    mapViewController.viewModel = MapViewModel(locations: _self.viewModel.locations)
                } else if let listViewController = $0 as? LocationsListViewController {
                    listViewController.viewModel = LocationsListViewModel(locations: _self.viewModel.locations)
                }
            }
        }

        viewModel.didFailToFetchDefaultLocations = { [weak self] error in
            self?.showErrorDialog(for: error)
        }

        viewModel.fetchLocations()
    }

    // MARK: - Actions

    @IBAction func tabSegmentChanged(_ sender: UISegmentedControl) {
        guard let tab = PresentationType(rawValue: sender.selectedSegmentIndex) else {
            return
        }
        loadViewController(for: tab)
    }

    // MARK: - Private

    private func setupViewControllers() {
        mainViewControllers = [ createMapViewController(), createListViewController() ]
        setViewControllers([mainViewControllers[0]], direction: .forward, animated: false, completion: nil)
    }

    private func loadViewController(for tab: PresentationType) {
        setViewControllers([mainViewControllers[tab.rawValue]], direction: tab.navigationDirection, animated: true, completion: nil)
        viewModel.fetchLocations()
    }

    private func createMapViewController() -> UIViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        viewController.viewModel = MapViewModel(locations: viewModel.locations)
        return viewController
    }

    private func createListViewController() -> UIViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LocationsListViewController") as! LocationsListViewController
        viewController.viewModel = LocationsListViewModel(locations: viewModel.locations)
        return viewController
    }

    private func showErrorDialog(for error: Error?) {
        let defaultErrorMessage = NSLocalizedString("Sorry, could not load default locations", comment: "Default error message")

        let dialog = UIAlertController(
            title: NSLocalizedString("Error!", comment: "Error dialog title"),
            message: error?.localizedDescription ?? defaultErrorMessage,
            preferredStyle: .alert
        )
        dialog.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(dialog, animated: true, completion: nil)
    }

    private enum PresentationType: Int {
        case map
        case list

        var navigationDirection: UIPageViewControllerNavigationDirection {
            switch self {
            case .map:
                return .reverse
            case .list:
                return .forward
            }
        }
    }

}
