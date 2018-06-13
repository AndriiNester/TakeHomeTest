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

    private var childViewController: UIViewController? {
        willSet {
            guard let childVC = childViewController else { return }
            removeChildViewController(childVC)
        }
        didSet {
            guard let childVC = childViewController, let containerView = containerView else { return }
            addChildViewController(childVC, toContainerView: containerView)
        }
    }

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
            _self.childMapViewController?.viewModel = MapViewModel(locations: _self.viewModel.locations)
        }

        viewModel.didFailToFetchDefaultLocations = { [weak self] error in
            self?.showErrorDialog(for: error)
        }

        viewModel.fetchLocations()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        childMapViewController = segue.destination as? MapViewController
    }

    @IBAction func tabSegmentChanged(_ sender: UISegmentedControl) {
        guard let tab = PresentationType(rawValue: sender.selectedSegmentIndex) else {
            return
        }
        loadViewController(for: tab)
    }

    // MARK: - Private

    private func loadViewController(for tab: PresentationType) {
        viewModel.fetchLocations()

        switch tab {
        case .map:
            childViewController = createMapViewController()
        case .list:
            childViewController = createListViewController()
        }
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

    private func removeChildViewController(_ childVC: UIViewController) {
        childVC.willMove(toParentViewController: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParentViewController()
    }

    private func addChildViewController(_ childVC: UIViewController, toContainerView containerView: UIView) {
        addChildViewController(childVC)
        childVC.view.frame = containerView.bounds
        childVC.view.setNeedsLayout()
        childVC.view.layoutIfNeeded()
        containerView.addSubview(childVC.view)
        childVC.didMove(toParentViewController: self)
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
    }

}
