//
//  MapViewController.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/11/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    var viewModel = MapViewModel(locations: []) {
        didSet {
            guard isViewLoaded else {
                return
            }
            showScenicPhotoLocations()
            setupSelectedLocationInfoView()
        }
    }

    private let locationManager: CLLocationManager = CLLocationManager()

    /// Newly created by user but not yet saved annotation
    private var inProgressAnnotation: MKAnnotation?

    private var selectedAnnotation: MKAnnotation? {
        return mapView.annotations.map({ mapView.view(for: $0) }).compactMap({ $0 }).first(where: { $0.isSelected })?.annotation
    }

    private var isSelectedLocationSaved: Bool {
        return selectedAnnotation != nil && isAnnotationSaved(selectedAnnotation!)
    }

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var selectedLocationContainerView: UIStackView!
    @IBOutlet private weak var selectedLocationInfoView: UIView!
    @IBOutlet private weak var selectedLocationTitleLabel: UILabel!
    @IBOutlet private weak var selectedLocationSubtitleLabel: UILabel!
    @IBOutlet private weak var locationActionButton: UIButton!

    private let defaultAnimationDuration = 0.2

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        setupCurrentLocationTracking()
        showScenicPhotoLocations()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Actions

    @IBAction func longPressGesture(_ sender: UILongPressGestureRecognizer) {
        guard sender.state == .began else {
            return
        }
        let touchPoint = sender.location(in: mapView)
        let coordinate = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
        addAnnotation(
            at: coordinate,
            withName: NSLocalizedString("New location", comment: "Title for not yet saved locations")
        )
    }

    @IBAction func locationActionButtonPressed(_ sender: Any) {
        if isSelectedLocationSaved {
            presentDetailsForSelectedLocation()
        } else {
            presentCreateNewLocationScreen()
        }
    }

    @IBAction func closeInfoViewPressed(_ sender: Any) {
        setSelectedLocationInfoView(hidden: true)
        if let annotation = selectedAnnotation {
            if !isSelectedLocationSaved {
                // remove marker for not saved location
                mapView.removeAnnotation(annotation)
            } else {
                mapView.deselectAnnotation(annotation, animated: true)
            }
        }
    }

    // MARK: - Private

    private func presentDetailsForSelectedLocation() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LocationDetailsViewController") as! LocationDetailsViewController
        guard let selectedSceneLocation = selectedAnnotation as? ScenicPhotoLocation else {
            return
        }
        viewController.viewModel = LocationDetailsViewModel(location: selectedSceneLocation)
        viewController.modelUpdated = { newLocation in
            self.replaceAnnotation(selectedSceneLocation, with: newLocation)
        }
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func presentCreateNewLocationScreen() {
        guard let selectedAnnotation = selectedAnnotation else {
            return
        }
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateEditLocationViewController") as! CreateEditLocationViewController
        viewController.viewModel = CreateEditLocationViewModel(coordinate: selectedAnnotation.coordinate)
        viewController.modelUpdated = { newLocation in
            self.replaceAnnotation(selectedAnnotation, with: newLocation)
        }
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true, completion: nil)
    }

    private func setupCurrentLocationTracking() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }

    private func showScenicPhotoLocations() {
        guard viewModel.hasLocations else {
            return
        }

        mapView.removeAnnotations(mapView.annotations)
        let allAnnotations = viewModel.locations
        mapView.addAnnotations(allAnnotations)
        mapView.showAnnotations(allAnnotations, animated: true)
    }

    private func addAnnotation(at coordinate: CLLocationCoordinate2D, withName name: String?) {
        removeInProgressAnnotation()
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = name
        inProgressAnnotation = annotation
        mapView.addAnnotation(annotation)
    }

    private func replaceAnnotation(_ annotation: MKAnnotation, with newAnnotation: MKAnnotation) {
        if annotation.isEqual(inProgressAnnotation) {
            inProgressAnnotation = newAnnotation
        }
        mapView.removeAnnotation(annotation)
        mapView.addAnnotation(newAnnotation)
        if let newLocation = newAnnotation as? ScenicPhotoLocation {
            setupLocationInfoView(with: newLocation)
        }
    }

    private func removeInProgressAnnotation() {
        guard let inProgressAnnotation = inProgressAnnotation else {
            return
        }
        mapView.removeAnnotation(inProgressAnnotation)
        self.inProgressAnnotation = nil
    }

    // MARK: - Helpers

    private var hasSelectedAnnotations: Bool {
        return mapView.annotations.map({ mapView.view(for: $0) }).compactMap({ $0 }).reduce(false, { $0 || $1.isSelected })
    }

    private func isAnnotationSaved(_ annotation: MKAnnotation) -> Bool {
        return annotation as? ScenicPhotoLocation != nil
    }

    private func deselectAllAnnotations(except excludeAnnotation: MKAnnotation? = nil) {
        mapView.annotations.map { annotation -> MKAnnotationView? in
            guard annotation.isEqual(excludeAnnotation) == false else {
                return nil
            }
            return mapView.view(for: annotation)
            }.compactMap({ $0 }).forEach {
                $0.setSelected(false, animated: true)
        }
    }

    private func setSelectedLocationInfoView(hidden: Bool) {
        UIView.animate(withDuration: defaultAnimationDuration) {
            self.selectedLocationInfoView.isHidden = hidden
            self.selectedLocationContainerView.layoutIfNeeded()
        }
    }

    private func configureAppearance() {
        selectedLocationInfoView.layer.masksToBounds = false
        selectedLocationInfoView.layer.shadowOffset = CGSize(width: 0, height: -2)
        selectedLocationInfoView.layer.shadowOpacity = 0.3
        selectedLocationInfoView.layer.shadowRadius = 2
        selectedLocationInfoView.layer.shadowColor = UIColor.black.cgColor
        selectedLocationInfoView.layer.cornerRadius = 8

        locationActionButton.layer.cornerRadius = locationActionButton.frame.height / 2
    }

    private func setupSelectedLocationInfoView() {
        if let location = selectedAnnotation as? ScenicPhotoLocation {
            setupLocationInfoView(with: location)
        } else {
            setupSelectedNewLocationInfoView()
        }
    }

    private func setupLocationInfoView(with location: ScenicPhotoLocation) {
        selectedLocationTitleLabel.text = location.name
        updateDistanceInfo(to: location.coordinate)
        locationActionButton.setTitle(NSLocalizedString("Details", comment: "Details button title"), for: .normal)
        setSelectedLocationInfoView(hidden: false)
    }

    private func setupSelectedNewLocationInfoView() {
        guard let newLocation = selectedAnnotation as? MKPointAnnotation else {
            return
        }
        selectedLocationTitleLabel.text = newLocation.title
        updateDistanceInfo(to: newLocation.coordinate)
        locationActionButton.setTitle(NSLocalizedString("Save Location", comment: "Save button title"), for: .normal)
        setSelectedLocationInfoView(hidden: false)
    }

    private func updateDistanceInfo(to coordinate: CLLocationCoordinate2D) {
        selectedLocationSubtitleLabel.text = mapView.userLocation.location?.coordinate.formattedDistance(to: coordinate)
    }

}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        guard let annotationView = views.last else {
            return
        }

        if let annotation = annotationView.annotation,
            let inProgressAnnotation = inProgressAnnotation,
            annotation.isEqual(inProgressAnnotation) {
            deselectAllAnnotations()
            annotationView.setSelected(true, animated: true)
        }

        if let annotation = annotationView.annotation, !isAnnotationSaved(annotation) {
            setupSelectedNewLocationInfoView()
        } else {
            inProgressAnnotation = nil
        }
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        deselectAllAnnotations(except: view.annotation)
        removeInProgressAnnotation()
        setupSelectedLocationInfoView()
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if !hasSelectedAnnotations {
            setSelectedLocationInfoView(hidden: true)
        }
    }

}

// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
}
