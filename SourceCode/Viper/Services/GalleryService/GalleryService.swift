//
//  GalleryService.swift
//  PDP
//

import UIKit
import Photos

/// Gallery Extension
enum AttachmentType: String {
    case camera, video, photoLibrary
}

///
protocol GalleryServiceDelegate: class {

    ///
    func cameraAuthorizationFailed(withMessage message: String, navigateToSettings: Bool)

    ///
    func cameraResult(image: UIImage)
}
///
class GalleryService: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Variable

    ///
    private weak var navigationController: UINavigationController?
    ///
    weak var delegate: GalleryServiceDelegate?

    // MARK: - Life cycle method

    ///
    override init() {
    }

    ///
    convenience init(navigationController: UINavigationController?) {
        self.init()

        self.navigationController = navigationController
    }

    // MARK: - Camera methods

    ///
    func openCamera(withFrontCamer isFrontCam: Bool = false) {
        //self.authorisationStatus(attachmentType: .camera, withFrontCamer: isFrontCam)
        openCameraAfterAuthorization(withFrontCamer: isFrontCam)
    }

    ///
    func authorisationStatus(attachmentType: AttachmentType, withFrontCamer isfrontCam: Bool = false) {

        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            switch attachmentType {
            case .camera: openCameraAfterAuthorization(withFrontCamer: isfrontCam)
            default: delegate?.cameraAuthorizationFailed(withMessage: "'PDP' needs authorisation to you photo library to save your profile image.", navigateToSettings: true)
            }
        case .denied: delegate?.cameraAuthorizationFailed(withMessage: "'PDP' needs authorisation to you photo library to save your profile image.", navigateToSettings: true)
        case .notDetermined:
            // Permission not determined
            PHPhotoLibrary.requestAuthorization({ [weak self] (status) in
                if status == PHAuthorizationStatus.authorized {
                    // photo library access given
                    print("access given")
                    switch attachmentType {
                    case .camera: self?.openCamera()
                    default: break
                    }
                } else {
                    // Restricted manually
                    self?.delegate?.cameraAuthorizationFailed(withMessage: "'PDP' needs authorisation to you photo library to save your profile image.", navigateToSettings: true)
                    //self?.showSettingsAlert(withMessage: "'PDP' needs authorisation to you photo library to save your profile image.")
                }
            })
        case .restricted:
        delegate?.cameraAuthorizationFailed(withMessage: "'PDP' needs authorisation to you photo library to save your profile image.", navigateToSettings: true)
        //showSettingsAlert(withMessage: "'PDP' needs authorisation to you photo library to save your profile image.")
        default: break
        }
    }

    ///
    func openCameraAfterAuthorization(withFrontCamer isFrontCam: Bool = false) {
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = self
                myPickerController.sourceType = .camera
                myPickerController.cameraDevice =  isFrontCam ? .front : .rear
               // myPickerController.allowsEditing = true
             //   DispatchQueue.main.async { [weak self] in
                    self.navigationController?.present(myPickerController, animated: true, completion: nil)
               // }
            }
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { [weak self] (granted: Bool) in
                if granted {
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        let myPickerController = UIImagePickerController()
                        myPickerController.delegate = self
                        myPickerController.sourceType = .camera
                        myPickerController.cameraDevice = isFrontCam ? .front : .rear
                      //  myPickerController.allowsEditing = true
                        DispatchQueue.main.async {
                            self?.navigationController?.present(myPickerController, animated: true, completion: nil)
                        }
                    }
                } else {
                    //access denied
                    self?.delegate?.cameraAuthorizationFailed(withMessage: "'PDP' needs authorisation to you camera to capture your profile image.", navigateToSettings: true)
                }
            })
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        // To handle image
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            delegate?.cameraResult(image: image)
            navigationController?.dismiss(animated: true, completion: nil)
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            delegate?.cameraResult(image: image)
            navigationController?.dismiss(animated: true, completion: nil)
        } else {
            navigationController?.dismiss(animated: true, completion: { [weak self] in
               // self?.showCustomAlert(message: "Something went wrong! Please try again!")
                self?.delegate?.cameraAuthorizationFailed(withMessage: "Something went wrong! Please try again!", navigateToSettings: false)
            })
        }
    }
}
