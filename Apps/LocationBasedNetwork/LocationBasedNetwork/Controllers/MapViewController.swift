////
////  MapViewController.swift
////  LocationBasedNetwork
////
////  Created by Ben Gavan on 24/11/2017.
////  Copyright © 2017 Ben Gavan. All rights reserved.
////
//
//import Foundation
//
////
////  ViewController.swift
////  LocationBasedNetwork
////
////  Created by Ben Gavan on 30/09/2017.
////  Copyright © 2017 Ben Gavan. All rights reserved.
////
//
//import MapKit
//import AVFoundation
//
//protocol GestureDelegate: class {
//    func upDateViewPossition(with constant: CGFloat)
//    func getBottomViewHeightAnchor() -> CGFloat
//    func getHeightOfWindow() -> CGFloat
//}
//
//class MapViewController: UIViewController, GestureDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    let cellId = "cellId"
//
//    let locationManager = CLLocationManager()
//
//    var bottomViewHeightAnchor: NSLayoutConstraint?
//
//    var moments = [Moment]()
//
//    var newMomentTextBodyBottomPadding: NSLayoutConstraint?
//    var postButtonBottomPadding: NSLayoutConstraint?
//
//    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
//    let blurEffectView = UIVisualEffectView()
//
//    let mapView: MKMapView = {
//        let map = MKMapView()
//        return map
//    }()
//
//    lazy var extraInfoPannelView: ExtraInfoPannel = {
//        let view = ExtraInfoPannel()
//        view.delegate = self
//        return view
//    }()
//
//    lazy var newMomentView: NewMomentView = {
//        let view = NewMomentView()
//        return view
//    }()
//  
//    let newMomentTextBody: UITextField = {
//        let textField = UITextField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.placeholder = "Enter Text"
//        textField.layer.borderColor = UIColor.lightGray.cgColor
//        textField.layer.borderWidth = 1
//        return textField
//    }()
//
//    lazy var postButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .orange
//        button.setTitle("Post", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.addTarget(self, action: #selector(postMoment), for: .touchUpInside)
//        return button
//    }()
//
//    lazy var cameraButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .orange
//        button.setTitle("Camera", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
//        return button
//    }()
//
//    lazy var newButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .orange
//        button.setTitle("New", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.addTarget(self, action: #selector(newMoment), for: .touchUpInside)
//        return button
//    }()
//
//    lazy var infoTestButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .orange
//        button.setTitle("More Info", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.addTarget(self, action: #selector(moreInfoTesting), for: .touchUpInside)
//        return button
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupLocationManager()
//        setupViews()
//        observeKeyBoardNotifications()
//
//    }
//
//    private func setupLocationManager() {
//        //                locationManager.delegate = self as! CLLocationManagerDelegate
//        //                locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        //                locationManager.requestWhenInUseAuthorization()
//        //                locationManager.startUpdatingLocation()
//    }
//
//    @objc func moreInfoTesting() {
//        print("more info")
//    }
//
//    @objc func postMoment() {
//        print("posting...")
//        view.endEditing(true)
//
//        let bodyText = newMomentTextBody.text!
//        if bodyText.characters.count <= 0 { return }
//        let newMoment = Moment(user: User(), text: bodyText, id: "3", type: .text, time: Date(), location: CLLocationCoordinate2D(latitude: 51.496548, longitude: -0.174968))
//        moments.append(newMoment)
//        drawMomentOnMapFor(index: moments.count - 1)
//        print("done")
//        print(newMoment)
//        newMomentTextBody.text = ""
//
//        keyboardHide()
//
//        print(mapView.annotations)
//    }
//
//
//    var captureSession: AVCaptureSession?
//    var stillImageOutput: AVCapturePhotoOutput?
//    var previewLayer: AVCaptureVideoPreviewLayer?
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        //
//        //        captureSession = AVCaptureSession()
//        //        captureSession?.sessionPreset = .hd1920x1080
//        //
//        //        var backCamera = AVCaptureDevice.default(for: .video)
//        //        var error: NSError?
//        //        var input =  AVCaptureDeviceInput(device: backCamera!, error: error)
//    }
//
//    @objc func openCamera() {
//        print("opening camera...")
//
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = .camera
//            imagePicker.allowsEditing = false
//            self.present(imagePicker, animated: true, completion: nil)
//            print("success")
//        } else {
//            print("fail")
//        }
//
//    }
//
//    @objc func newMoment() {
//        view.addSubview(newMomentView)
//        _ = newMomentView.anchor(self.view.topAnchor, left: view.leftAnchor, bottom: extraInfoPannelView.topAnchor, right: view.rightAnchor, topConstant: 50, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: view.frame.height - 100)
//    }
//
//    private func setupViews() {
//        mapView.mapType = MKMapType.standard
//        mapView.isZoomEnabled = true
//        mapView.isScrollEnabled = true
//        mapView.showsUserLocation = true
//
//        let statusBarBackgroundView = UIView()
//        statusBarBackgroundView.backgroundColor = .orange
//
//        view.addSubview(statusBarBackgroundView)
//        _ = statusBarBackgroundView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
//
//
//        view.addSubview(mapView)
//        view.addSubview(cameraButton)
//        view.addSubview(newButton)
//        view.addSubview(extraInfoPannelView)
//        view.bringSubview(toFront: statusBarBackgroundView)
//
//        _ = mapView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
//
//        _ = cameraButton.anchor(nil, left: nil, bottom: newButton.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5, rightConstant: 10, widthConstant: 70, heightConstant: 0)
//
//        _ = newButton.anchor(cameraButton.bottomAnchor, left: nil, bottom: extraInfoPannelView.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5, rightConstant: 10, widthConstant: 70, heightConstant: 0)
//
//        bottomViewHeightAnchor = extraInfoPannelView.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40).last
//
//
//        fetchtMoments()
//    }
//
//    private func postMoments() {
//        let testMoment = Moment(user: User(), text: "", id: "", type: nil, time: Date(), location: CLLocationCoordinate2D())
//        ApiService.shared.postMomentFor(user: User(), moment: testMoment)
//
//    }
//
//    private func fetchtMoments() {
//        ApiService.shared.fetchMoments { (moments: [Moment]) in
//            self.moments = moments
//            self.drawMomentsOnMap()
//        }
//    }
//
//    private func drawMomentsOnMap() {
//        for moment in self.moments {
//            let annotation = makeAnnotation(with: (moment.user?.userName)!, body: moment.text!, location: moment.location!)
//            self.mapView.addAnnotation(annotation)
//        }
//    }
//
//    private func drawMomentOnMapFor(index: Int) {
//        let annotation = makeAnnotation(with: (moments[index].user?.userName)!, body: moments[index].text!, location: moments[index].location!)
//        print("user: \(String(describing: moments[index].user))")
//        self.mapView.addAnnotation(annotation)
//    }
//
//    private func makeAnnotation(with title: String, body: String, location: CLLocationCoordinate2D) -> MapAnnotation {
//        // TODO needs custom annotation
//        let annotation = MapAnnotation(location: location)
//        annotation.title = title
//        annotation.subtitle = body
//        return annotation
//    }
//
//    fileprivate func observeKeyBoardNotifications() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: .UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardWillHide, object: nil)
//
//    }
//
//    @objc func keyboardShow() {
//        self.newMomentTextBodyBottomPadding?.constant = -270
//        self.newMomentTextBody.backgroundColor = UIColor(white: 0.9, alpha: 1)
//        self.postButtonBottomPadding?.constant = -270
//        //self.newMomentTextBody.heightAnchor.constraint(equalToConstant: 200).isActive = true
//
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.view.layoutIfNeeded()
//        })
//
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        mapView.addSubview(blurEffectView)
//    }
//
//    @objc func keyboardHide() {
//        self.newMomentTextBodyBottomPadding?.constant = -10
//        self.newMomentTextBody.backgroundColor = .clear
//
//        self.postButtonBottomPadding?.constant = -10
//
//        for subview in mapView.subviews {
//            if subview is UIVisualEffectView {
//                subview.removeFromSuperview()
//            }
//        }
//
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.view.layoutIfNeeded()
//        })
//    }
//
//    // Swipe up bottom Pannel
//    func upDateViewPossition(with constant: CGFloat) {
//        bottomViewHeightAnchor?.constant = constant
//        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.view.layoutIfNeeded()
//        })
//    }
//
//
//    func getBottomViewHeightAnchor() -> CGFloat {
//        return (bottomViewHeightAnchor?.constant)!
//    }
//
//    func getHeightOfWindow() -> CGFloat {
//        return view.frame.height
//    }
//
//
//    func showExpandedDetail() {
//        // Show expanded detail in area
//    }
//}
//
//
//
//
//
//
//
//
//
