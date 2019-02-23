//
//  ViewController.swift
//  CircularLoaderTesting
//
//  Created by Ben Gavan on 14/12/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate {
    
    var shapeLayer: CAShapeLayer!
    var pulsatingLayer: CAShapeLayer!
    
    let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
    
    let urlString = "https://firebasestorage.googleapis.com/v0/b/firestorechat-e64ac.appspot.com/o/intermediate_training_rec.mp4?alt=media&token=e20261d0-7219-49d2-b32d-367e1606500c"
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        
        setupNotificationObservers()
        setupCircleLayers()
        setupPercentageLabel()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @objc private func handleEnterForeground() {
        animatePulsatingLayer()
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)
    }
    
    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer{
        let layer = CAShapeLayer()
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 20
        layer.lineCap = kCALineCapRound
        layer.fillColor = fillColor.cgColor
        layer.position = view.center
        return layer
    }
    
    private func setupPercentageLabel() {
        view.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = view.center
    }
    
    private func setupCircleLayers() {
        pulsatingLayer = createCircleShapeLayer(strokeColor: .clear, fillColor: .pulsatingFillColor)
        view.layer.addSublayer(pulsatingLayer)
        animatePulsatingLayer()
        
        let trackLayer = createCircleShapeLayer(strokeColor: .trackStrokeColor, fillColor: .backgroundColor)
        view.layer.addSublayer(trackLayer)
        
        shapeLayer = createCircleShapeLayer(strokeColor: .outlineStrokeColor, fillColor: .clear)
        shapeLayer.strokeEnd = 0
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        view.layer.addSublayer(shapeLayer)
    }
    
    private func animatePulsatingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.3
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        pulsatingLayer.add(animation, forKey: "pulsating")
    }
    
    private func beginDownloadingFile() {
        print("Attempting to download file")
        shapeLayer.strokeEnd = 0
        
        let configuration = URLSessionConfiguration.default
        let operationQueue = OperationQueue()
        let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
        
        guard let url = URL(string: urlString) else { return }
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Finished downloading file")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        //        print(totalBytesWritten, totalBytesExpectedToWrite)
        let percentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        DispatchQueue.main.async {
            self.percentageLabel.text = "\(Int(percentage * 100))%"
            self.shapeLayer.strokeEnd = percentage
        }
        
        print(percentage)
    }
    
    fileprivate func animateCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
    @objc private func handleTap() {
        print("Attempting to animate stroke")
        
        beginDownloadingFile()
    }
}


extension UIColor {
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
    }
    
    static let backgroundColor = UIColor.rgb(r: 21, g: 22, b: 33)
    static let outlineStrokeColor = UIColor.rgb(r: 234, g: 46, b: 111)
    static let trackStrokeColor = UIColor.rgb(r: 56, g: 25, b: 49)
    static let pulsatingFillColor = UIColor.rgb(r: 86, g: 30, b: 63)
}











