//
//  LocationTableViewCell.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/13/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailedLabel: UILabel!
    @IBOutlet weak var rightDetailedLabel: UILabel!

    func populate(with viewModel: LocationCellViewModel) {
        titleLabel.text = viewModel.title
        detailedLabel.text = viewModel.details
        rightDetailedLabel.text = viewModel.distance
    }

}
