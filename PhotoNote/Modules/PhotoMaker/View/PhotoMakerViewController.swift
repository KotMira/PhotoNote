//
//  PhotoMakerViewController.swift
//  PhotoNote
//
//  Created by AndreWolfsky on 23/11/2021.
//  Copyright © 2021 Wolfsky. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoMakerViewController: UIViewController {
    
    var presenter: PhotoMakerPresenterProtocol!
    private let configurator: PhotoMakerConfiguratorProtocol = PhotoMakerConfigurator()
    var makeSnapshot: UIImageView!
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    @IBOutlet weak var cameraView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        setupInitialState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.previewLayer?.frame = self.cameraView.bounds
        }
    }
}

extension PhotoMakerViewController {
    
    func setupInitialState() {
        view.backgroundColor = .black
        cameraView.backgroundColor = .gray
        configureMakeSnapshotView()
        startCamera()
        let tap = UITapGestureRecognizer(target: self, action: #selector(createSnapshot))
        makeSnapshot.addGestureRecognizer(tap)
        makeSnapshot.isUserInteractionEnabled = true
    }
    
    func startCamera() {
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSession.Preset.photo
        stillImageOutput = AVCapturePhotoOutput()
        
        if let device = AVCaptureDevice.default(for: .video),
           let input = try? AVCaptureDeviceInput(device: device) {
            if ((captureSession?.canAddInput(input)) != nil) {
                captureSession?.addInput(input)
                if ((captureSession?.canAddOutput(stillImageOutput!)) != nil) {
                    captureSession?.addOutput(stillImageOutput!)
                    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                    previewLayer?.connection?.videoOrientation = .portrait
                    previewLayer?.videoGravity = .resize
                    self.cameraView.layer.insertSublayer(self.previewLayer!, at: 0)
                    captureSession?.startRunning()
                }
            } else {
                print("issue here : captureSesssion.canAddInput")
            }
        } else {
            print("some problem here")
        }
    }
    
    func configureMakeSnapshotView() {
        makeSnapshot = UIImageView()
        view.addSubview(makeSnapshot)
        makeSnapshot.translatesAutoresizingMaskIntoConstraints = false
        makeSnapshot.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        makeSnapshot.heightAnchor.constraint(equalToConstant: 70).isActive = true
        makeSnapshot.widthAnchor.constraint(equalToConstant: 70).isActive = true
        makeSnapshot.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        makeSnapshot.image = UIImage(named: "MakeSnapshot")
    }
    
    @objc func createSnapshot() {
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [
            kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
            kCVPixelBufferWidthKey as String: 160,
            kCVPixelBufferHeightKey as String: 160
        ]
        settings.previewPhotoFormat = previewFormat
        stillImageOutput?.capturePhoto(with: settings, delegate: self)
    }
    
//    func failed() {
//        let ac = UIAlertController(title: "Scanner not supported", message: "Please use a device with a camera. Because this device does not support scanning a code", preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
//        captureSession = nil
//    }
    
//    func barCode() {
//        let metadataOutput = AVCaptureMetadataOutput()
//        if ((self.captureSession?.canAddOutput(metadataOutput)) != nil) {
//            self.captureSession?.addOutput(metadataOutput)
//
//            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417, .qr]
//        } else {
//            self.failed()
//            return
//        }
//    }

}

extension PhotoMakerViewController : AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession?.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        dismiss(animated: true)
    }
    
    func found(code: String) {
        print(code)
    }
}

extension PhotoMakerViewController : AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("error occured : \(error.localizedDescription)")
        }
        
        if let dataImage = photo.fileDataRepresentation() {
            print(UIImage(data: dataImage)?.size as Any)
            
            let dataProvider = CGDataProvider(data: dataImage as CFData)
            let cgImageRef: CGImage! = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: .defaultIntent)
            let image = UIImage(cgImage: cgImageRef, scale: 1.0, orientation: UIImage.Orientation.right)
            
            /**
             save image in array / do whatever you want to do with the image here
             */
            //            self.images.append(image)
            print("IT'S HERE!")
            presenter.openImageActions(image: image)
        } else {
            print("some error here")
        }
    }
}
