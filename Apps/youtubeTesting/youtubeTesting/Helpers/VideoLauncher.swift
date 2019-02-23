//
//  VideoLauncher.swift
//  youtubeTesting
//
//  Created by Ben Gavan on 03/11/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    var player: AVPlayer?
    
    var isPlaying = false
    
    let activityIndecatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "pause")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    lazy var videoSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        let image = UIImage(named: "thumb")
        slider.setThumbImage(image, for: .normal)
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc private func handleSliderChange() {
        print(videoSlider.value)
        
        guard let durration = player?.currentItem?.duration else { return }
        let totalSeconds = CMTimeGetSeconds(durration)
        let value = Float64(videoSlider.value) * totalSeconds
        let seekTime = CMTime(value: Int64(value), timescale: 1)
        
        player?.seek(to: seekTime, completionHandler: { (completedSeek) in
            // Do stuff after
        })
    }
    
    @objc private func handlePause() {
        if isPlaying {
            player?.pause()
            let image = UIImage(named: "play")
            pausePlayButton.setImage(image, for: .normal)
        } else {
            player?.play()
            let image = UIImage(named: "pause")
            pausePlayButton.setImage(image, for: .normal)
        }

        isPlaying = !isPlaying
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        setupGradientLayer()
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndecatorView)
        activityIndecatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndecatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(videoLengthLabel)
//        videoLengthLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
//        videoLengthLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        videoLengthLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
//        videoLengthLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        _ = videoLengthLabel.anchor(nil, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 2, rightConstant: 8, widthConstant: 50, heightConstant: 24)
        
        controlsContainerView.addSubview(currentTimeLabel)
        _ = currentTimeLabel.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 8, bottomConstant: 2, rightConstant: 0, widthConstant: 50, heightConstant: 24)
        
        controlsContainerView.addSubview(videoSlider)
//        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
//        videoSlider.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        videoSlider.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        _ = videoSlider.anchor(nil, left: self.currentTimeLabel.rightAnchor, bottom: self.bottomAnchor, right: videoLengthLabel.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
        self.backgroundColor = .black
    }
    
    private func setupPlayerView() {
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                let seconds = CMTimeGetSeconds(progressTime)
                let secondsString = String(format: "%02d", Int(seconds) % 60)
                let minutesString = String(format: "%02d", Int(seconds / 60))
                self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
                
                guard let durration = self.player?.currentItem?.duration else { return }
                let durrationSeconds = CMTimeGetSeconds(durration)
                self.videoSlider.value = Float(seconds / durrationSeconds)
            })
        }
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndecatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            isPlaying = true
            
            guard let durration = player?.currentItem?.duration else { return }
            let seconds = CMTimeGetSeconds(durration)
            let secondsText = Int(seconds) % 60 // seconds.truncatingRemainder(dividingBy: 60)
            let minutes = Int(seconds) / 60
            let minutesText = String(format: "%02d", minutes)
            videoLengthLabel.text = "\(minutesText):\(secondsText)"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class VideoLauncher {
    
    func showVideoPlayer() {
        print("Showing video player animation...")
        
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            let height = keyWindow.frame.width * (9 / 16)
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)
            
//            _ = videoPlayerView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: height)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                view.frame = keyWindow.frame

            }, completion: { (isCompletedAnimation) in
                UIApplication.shared.isStatusBarHidden = true
            })

        }
        
    }
    
}


















