//
//  LocationDetailsViewController.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/12/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import UIKit

class LocationDetailsViewController: UIViewController {

    var viewModel: LocationDetailsViewModel! {
        didSet {
            guard isViewLoaded else {
                return
            }
            fillLocationInfo()
        }
    }

    var modelUpdated: ((ScenicPhotoLocation) -> Void)?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var editButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        fillLocationInfo()
    }

    @IBAction func editPressed(_ sender: Any) {
        let editViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateEditLocationViewController") as! CreateEditLocationViewController
        editViewController.viewModel = viewModel.createEditLocationViewModel

        editViewController.modelUpdated = { updatedLocation in
            self.viewModel = LocationDetailsViewModel(location: updatedLocation)
            self.modelUpdated?(updatedLocation)
        }

        let navigationController = UINavigationController(rootViewController: editViewController)
        present(navigationController, animated: true, completion: nil)
    }

    private func fillLocationInfo() {
        nameLabel.text = viewModel.name
        subtitleLabel.text = viewModel.subtitle
        descriptionTextView.text = viewModel.description
    }

}
