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

    var viewModel = MapViewModel(defaultLocations: [], userLocations: []) {
        didSet {
            guard isViewLoaded else {
                return
            }
            showScenicPhotoLocations()
            moveToFetchedPhotoLocations()
        }
    }

    @IBOutlet private weak var mapView: MKMapView!

    private let locationManager: CLLocationManager = CLLocationManager()
    private let locationSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCurrentLocationTracking()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showScenicPhotoLocations()
        moveToFetchedPhotoLocations()
    }

    private func setupCurrentLocationTracking() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }

    private func showScenicPhotoLocations() {
        guard viewModel.hasLocations else {
            return
        }

        mapView.removeAnnotations(mapView.annotations)

        let markers = (viewModel.defaultLocations + viewModel.userLocations).map { location -> MKAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            annotation.title = location.name
            return annotation
        }
        mapView.addAnnotations(markers)
    }

    private func moveToFetchedPhotoLocations() {
        guard viewModel.hasLocations else {
            return
        }
        guard let firstFetchedLocation = viewModel.defaultLocations.first ?? viewModel.userLocations.first else {
            return
        }
        moveToLocation(CLLocationCoordinate2D(latitude: firstFetchedLocation.latitude, longitude: firstFetchedLocation.longitude))
    }

    private func moveToLocation(_ location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: location, span: locationSpan)
        mapView.setRegion(region, animated: true)
    }

}

extension MapViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }

}
