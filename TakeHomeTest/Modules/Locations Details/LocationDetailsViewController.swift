//
//  LocationDetailsViewController.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/12/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import UIKit

class LocationDetailsViewController: UIViewController {

    var viewModel: LocationDetailsViewModel!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var editButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = viewModel.name
        subtitleLabel.text = viewModel.subtitle
        descriptionTextView.text = viewModel.description
    }

    @IBAction func editPressed(_ sender: Any) {
    }

}
