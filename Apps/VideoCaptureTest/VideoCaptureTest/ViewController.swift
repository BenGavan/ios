//
//  ViewController.swift
//  VideoCaptureTest
//
//  Created by Ben Gavan on 02/10/2020.
//  Copyright © 2020 Ben Gavan. All rights reserved.
//

import UIKit
import AVFoundation
import CoreImage

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class CameraPreviewViewController: UIViewController{
    
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private let previewContainer = UIView()
    
    private let captureSession: AVCaptureSession = {
        let session = AVCaptureSession()
//        session.sessionPreset = .high
        session.sessionPreset = .hd4K3840x2160
        return session
    }()
    
    // Used as the buffer for captured video frames before being used (e.g. by the AVCaptureVideoPreviewLayer (to be displayed to the user))
    private let sampleBufferQueue = DispatchQueue.global(qos: .userInteractive)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .red
        
        setupPreviewContainer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            setupCaptureSession()
        } else {
            AVCaptureDevice.requestAccess(for: .video) { (isAuthorized) in
                DispatchQueue.main.async {
                    if isAuthorized {
                        self.setupCaptureSession()
                    }
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        previewLayer?.bounds = view.bounds
        previewLayer?.bounds = previewContainer.bounds
    }
    
    private func setupPreviewContainer() {
        previewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(previewContainer)
        
        previewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        previewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        previewContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        previewContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }

//    private func setupCaptureSession() {
//        captureSession.beginConfiguration()
//
//        guard let videoDevice  = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .unspecified) else { return }
//        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }
//
//        guard captureSession.canAddInput(videoDeviceInput) else { return }
//        captureSession.addInput(videoDeviceInput)
//
//
//        let videoOutput = AVCaptureVideoDataOutput()
//
//        guard captureSession.canAddOutput(videoOutput) else { return }
//        captureSession.sessionPreset = .high  // Sets the preset quality suitable for streaming over wifi = .medium (3G = .low)
//        captureSession.addOutput(videoOutput)
//        captureSession.commitConfiguration()
//
//        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        previewLayer?.frame = view.bounds
//        previewLayer?.backgroundColor = UIColor.black.cgColor
//
//        view.layer.addSublayer(previewLayer!)
//
//        captureSession.startRunning()
//    }
    
    // MARK:- Rotation
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait]
    }
    
    // MARK:- Camera Capture
    private func findCamera() -> AVCaptureDevice? {
        let deviceTypes: [AVCaptureDevice.DeviceType] = [
            .builtInDualCamera,
            .builtInTelephotoCamera,
            .builtInTelephotoCamera,
            .builtInWideAngleCamera
        ]
        
        let discovery = AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes, mediaType: .video, position: .back)
        return discovery.devices.first
    }
    
    private func setupCaptureSession() {
        guard captureSession.inputs.isEmpty else { return }
        
        guard let camera = findCamera() else {
            print("No camera found")
            return
        }
        
        guard let cameraInput = try? AVCaptureDeviceInput(device: camera) else {
            print("Error creating capture session")
            return
        }
        captureSession.beginConfiguration()
        captureSession.addInput(cameraInput)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = previewContainer.bounds
        previewLayer.backgroundColor = UIColor.black.cgColor
        previewLayer.videoGravity = .resizeAspect
        
        previewContainer.layer.addSublayer(previewLayer)
        
        let output = AVCaptureVideoDataOutput()
        output.alwaysDiscardsLateVideoFrames = true
        output.setSampleBufferDelegate(self, queue: sampleBufferQueue)
        
        guard captureSession.canAddOutput(output) else {
            print("captureSession.canAddOutput(output) returned false for AVCaptureVideoDataOutput()")
            return
        }
        
        captureSession.addOutput(output)
        captureSession.commitConfiguration()
        captureSession.startRunning()
        
        print("Running capture session")
    }
    
    var buffCounter: Int = 0
    var prevT = Date().timeIntervalSince1970
    var tenHist = [TimeInterval](repeating: 0, count: 10)
}

extension CameraPreviewViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        connection.videoOrientation = .landscapeLeft
        
        let nowT = Date().timeIntervalSince1970
        let delta = nowT - prevT
        let fps = 1 / delta
        
        prevT = nowT
        buffCounter += 1
        
        let i = buffCounter % 10
        tenHist[i] = fps
        
        let averageFPS = average(tenHist)
    
        print("sampleBuffer: \(buffCounter) - \(fps) - \(averageFPS) -")
    }
    
    private func average(_ array: [Double]) -> Double {
        return sum(array) / Double(array.count)
    }
    
    private func sum(_ array: [Double]) -> Double {
        var t: Double = 0
        for x in array {
            t += x
        }
        return t
    }
}


extension Collection where Element == Double {
    func average() -> Double {
        return sum() / Double(count)
    }
    
    func sum() -> Double {
        return -1
    }
}
