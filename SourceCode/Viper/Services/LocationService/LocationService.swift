//
//  LocationService.swift
//  Viper
//

import UIKit
import CoreLocation
import CocoaLumberjack

/// Location detail model
class LocationDetail {

    // MARK: - Variables

    ///
    let latitude: Double
    ///
    let longitude: Double
    ///
    var address: Address?

    // MARK: - Life cycle methods

    ///
    init(latitude: Double, longitude: Double, address: Address?) {
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
    }
}

///
class Address {

    // MARK: - Variables

    ///
    var name = ""
    ///
    var street = ""
    ///
    var city = ""
    ///
    var state = ""
    ///
    var country = ""
    ///
    var postalCode = ""
    ///
    var completeAddress: String {
            return name + ", " + street + ", " + city + ", " + state + ", " + country + ", " + postalCode
    }
}

/// Protocol for location service
protocol LocationServiceDelegate: class {

    ///
    func didUpdateLocation(locationDetail: LocationDetail)
    ///
    func authorizationChanged(status: CLAuthorizationStatus)
}

///
class LocationService: NSObject {

    // MARK: - Variable

    ///
    private var notificationService: NotificationService?
    ///
    private var locationManager: CLLocationManager?
    ///
    weak var delegate: LocationServiceDelegate?
    /// current location of the device
    var currentLocation: LocationDetail?
    /// Enable this to continously fetch location not just once
    private var isContinousLocationUpdate = false
    ///
    private(set) var isLocationServicesEnabled: Bool = false
    /// Enable this to fetch location in background
    private var isBackgroundModeEnabled = false

    // MARK: - Life cycle methods

    ///
    convenience init(notificationService: NotificationService?) {
        self.init()
        self.notificationService = notificationService
    }

    ///
    private func setupLocationManager() {

        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .restricted, .denied:
            showEnableLocationAlert()
            isLocationServicesEnabled = false
            //delegates.invoke { $0.authorizationChanged(status: status) }
        default:
            if CLLocationManager.locationServicesEnabled() {
                initializeLocationManager()
            }
        }
    }

    ///
    private func initializeLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        /*locationManager?.allowsBackgroundLocationUpdates = true*/
        locationManager?.pausesLocationUpdatesAutomatically = false
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        /*locationManager.requestAlwaysAuthorization()*/
        locationManager?.requestWhenInUseAuthorization()
    }

    ///
    private func deinitializeLocationManager() {
        locationManager = nil
        locationManager?.delegate = nil
    }

    // MARK: - Location methods

    /// Fetch current location of the user
    ///
    /// - Parameters:
    ///   - isEnable: Determine if the location is to be fetched in background mode
    ///   - isContinousUpdate: Determines if the location is to be fetched continously or only one time.
    func fetchCurrentLocation(withBackgroundModeEnable isEnable: Bool, isContinousUpdate: Bool) {

        isContinousLocationUpdate = isContinousUpdate
        isBackgroundModeEnabled = isEnable
        guard isLocationServicesEnabled else {
            setupLocationManager()
            return
        }
        if locationManager == nil {
            initializeLocationManager()
        }
        startUpdatingLocation(withBackgroundModeEnable: self.isBackgroundModeEnabled)
    }

    /// Start updaitng location
    ///
    /// - Parameter isEnable: Determine if the location is to be fetched in background mode
    private func startUpdatingLocation(withBackgroundModeEnable isEnable: Bool) {
        locationManager?.allowsBackgroundLocationUpdates = isEnable
        locationManager?.startUpdatingLocation()
    }

    ///
    func stopUpdatingLocation() {
        locationManager?.stopUpdatingLocation()
        locationManager?.allowsBackgroundLocationUpdates = false
        deinitializeLocationManager()
    }

    // MARK: - Helper methods

    /// get place, city, street, zip & country using current location
    func getLocationDetail(_ location: LocationDetail, _ completion: @escaping ( Address? ) -> Void ) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(CLLocation(latitude: location.latitude, longitude: location.longitude)) { (placemarks, error) -> Void in
            guard error == nil else {
                completion(nil)
                return
            }
            if let placeArray = placemarks {
                // Place details
                let placeMark = placeArray[0]
                let address = Address()
                address.name = placeMark.name ?? ""
                address.street = placeMark.thoroughfare ?? ""
                address.city = placeMark.locality ?? ""
                address.state = placeMark.administrativeArea ?? ""
                address.country = placeMark.country ?? ""
                address.postalCode = placeMark.postalCode ?? ""
                completion(address)
            }
            completion(nil)
        }
    }

    ///
    private func showEnableLocationAlert() {
        notificationService?.showAlert(forTitle: "Enable Location", message: "Please enable location from settings", buttonTitles: ["Settings", "Cancel"], customAlertViewTapButtonBlock: { [weak self](index) in
            if index == 0 {
                self?.openSettings()
            }
        }, isHighPriority: true)
    }

    ///
    private func openSettings() {
        if let openSettingsUrl = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(openSettingsUrl) {
                UIApplication.shared.open(openSettingsUrl, completionHandler: nil)
            }
        }
    }
}

///
extension LocationService: CLLocationManagerDelegate {

    ///
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
           DDLogError("Location permission restricted or denied")
            showEnableLocationAlert()
            isLocationServicesEnabled = false
        case .notDetermined:
            DDLogError("Location permission not determined")
            showEnableLocationAlert()
            isLocationServicesEnabled = false
        case .authorizedAlways, .authorizedWhenInUse:
            print("Access")
            isLocationServicesEnabled = true
            fetchCurrentLocation(withBackgroundModeEnable: isBackgroundModeEnabled, isContinousUpdate: isContinousLocationUpdate)
        }
        delegate?.authorizationChanged(status: status)
    }

    ///
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.first else {
            return
        }

        currentLocation = LocationDetail(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, address: nil)

        guard let currentLocation = currentLocation else { return }
        if !isContinousLocationUpdate {
             stopUpdatingLocation()

        }
        DDLogInfo("Location: - \(currentLocation.latitude) \(currentLocation.longitude)")
        delegate?.didUpdateLocation(locationDetail: currentLocation)

        /// Use below method to get address
        getLocationDetail(currentLocation) { (addressDetails) in
            print(addressDetails?.completeAddress ?? "")
            currentLocation.address = addressDetails
        }
    }

    ///
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DDLogError(error.localizedDescription)
    }
}
