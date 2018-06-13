//
//  CreateEditLocationViewController.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/12/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import UIKit

class CreateEditLocationViewController: UIViewController {

    var viewModel: CreateEditLocationViewModel!

    // TODO: I would like to have a view model to bear the responsibility to update a corresponding view just like the MVVM pattern implies, however due to the time constraints I chose the solution with the modelUpdated closure implemented below. Ideally I would use the data binding approach here and bind the view and view model. Alternatively, it is possible to use the unidirectional flow approach when our app has a state and certain actions that update the state where the view models observe the state changes and update the view accordingly (see ReSwift https://github.com/ReSwift/ReSwift)
    var modelUpdated: ((ScenicPhotoLocation) -> Void)?

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var notesTextView: UITextView!
    @IBOutlet private weak var saveButton: UIBarButtonItem!

    private let notesPlaceholderColor = UIColor.lightGray
    private let notesDefaultTextColor = UIColor.black
    private var notesPlaceholderText = NSLocalizedString("Enter the description", comment: "Notes placeholder")

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.screenTitle
        nameTextField.becomeFirstResponder()
        nameTextField.text = viewModel.name
        notesTextView.text = viewModel.notes
        saveButton.isEnabled = viewModel.isSaveEnabled

        if notesTextView.text.isEmpty {
            enableNotesTextViewPlaceholder()
        }
    }

    // MARK: - Actions

    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func savePressed(_ sender: Any) {
        viewModel.name = nameTextField.text
        viewModel.notes = isNotesPlaceholderEnabled ? nil : notesTextView.text

        viewModel.saveLocation()
        if let location = viewModel.location {
            modelUpdated?(location)
        }
        dismiss(animated: true, completion: nil)
    }

    @IBAction func nameChanged(_ sender: Any) {
        viewModel.name = nameTextField.text
        saveButton.isEnabled = viewModel.isSaveEnabled
    }

    // MARK: - Private

    private var isNotesPlaceholderEnabled: Bool {
        return notesTextView.text == notesPlaceholderText && notesTextView.textColor == notesPlaceholderColor
    }

    private func enableNotesTextViewPlaceholder() {
        notesTextView.text = notesPlaceholderText
        notesTextView.textColor = notesPlaceholderColor
    }

    private func disableNotesTextViewPlaceholder() {
        notesTextView.text = nil
        notesTextView.textColor = notesDefaultTextColor
    }

}

extension CreateEditLocationViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

extension CreateEditLocationViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if isNotesPlaceholderEnabled {
            disableNotesTextViewPlaceholder()
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            enableNotesTextViewPlaceholder()
        }
    }

}
