//
//  CreateEditLocationViewController.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/12/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import UIKit

class CreateEditLocationViewController: UIViewController {

    var viewModel = CreateEditLocationViewModel()

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.becomeFirstResponder()
        nameTextField.text = viewModel.name
        descriptionTextView.text = viewModel.description
        saveButton.isEnabled = viewModel.isSaveEnabled
    }

    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func savePressed(_ sender: Any) {
        // TODO: save to storage and return back to parent VC
        dismiss(animated: true, completion: nil)
    }

    @IBAction func nameChanged(_ sender: Any) {
        viewModel.name = nameTextField.text
        saveButton.isEnabled = viewModel.isSaveEnabled
    }

}

extension CreateEditLocationViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}