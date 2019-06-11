//
//  ViewController.swift
//  MonRadio
//
//  Created by suwit supawas on 6/6/2562 BE.
//  Copyright © 2562 suwit supawas. All rights reserved.
//

import UIKit
import AVFoundation  // sound
import WebKit  // web

class ViewController: UIViewController, WKNavigationDelegate {
    
    // ส่วนนี้เป็นการเปิด web
    
    var WebViewFrame: UIView!
    
    var webView: WKWebView!
    
    // ต่อไปเป็นส่วนของ song
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    
    var playMusic: Bool = false  // ถ้าใช้ true จะเป็นการเล่นไฟล์เสียงแบบ Auto 
    var pauseMusic: Bool = true
    
    @IBOutlet weak var Share: UIBarButtonItem!
    
    @IBOutlet weak var label: UILabel!
    

    
    
    //  เงาหลังของ Cover
//    let coverImageShadow: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        view.layer.cornerRadius = 270/2
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOffset = .zero
//        view.layer.shadowRadius = 10
//        view.layer.shadowOpacity = 0.5
//        return view
//    }()
//    // Cover ที่จะมีการหมุน
//    let coverImage: UIImageView = {
//        let image = UIImageView()
//        image.image = UIImage(named: "melanie-van-leeuwen-83775-unsplash")
//        image.contentMode = .scaleAspectFill
//        image.layer.masksToBounds = true
//        image.layer.cornerRadius = 270/2
//        return image
//    }()
    
//    // ชื่อรายการ
//    let songName: UILabel = {
//        let label = UILabel()
//        label.text = "Song Name"
//        label.textColor = UIColor.blackAlpha(alpha: 0.8)
//        //        label.font = UIFont.boldSystemFont(ofSize: 22)
//        label.font = UIFont.KanitMedium(size: 22)
//        label.numberOfLines = 0
//        label.textAlignment = .center
//        return label
//    }()
    
//    // ผู้จัดรายการ
//    let songArtist: UILabel = {
//        let label = UILabel()
//        label.text = "Artist"
//        //        label.textColor = UIColor.blackAlpha(alpha: 0.5)
//        label.textColor = UIColor.mediumBlue
//        //        label.font = UIFont.boldSystemFont(ofSize: 17)
//        label.font = UIFont.KanitLight(size: 18)
//        label.numberOfLines = 0
//        label.textAlignment = .center
//        return label
//    }()
    
    // วันเวลาที่ออกรายการ
//    let songDays: UILabel = {
//        let label = UILabel()
//        label.text = "Days"
//        label.textColor = UIColor.blackAlpha(alpha: 0.5)
//        //        label.font = UIFont.boldSystemFont(ofSize: 16)
//        label.font = UIFont.PoppinsLight(size: 15)
//        label.numberOfLines = 0
//        label.textAlignment = .center
//        return label
//    }()
//
//
    
    // ส่วนของ slider
    let sliderSong: CustomSlider = {
        let slider = CustomSlider()
        
        slider.maximumTrackTintColor = UIColor.blackAlpha(alpha: 0.15)
        slider.minimumTrackTintColor = UIColor.navy
        slider.setThumbImage(UIImage(named: "thumb-image"), for: .normal)
        slider.value = 0.0
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        
        return slider
    }()
    
    // เวลาที่เดินไปตามการเปิดรายการ
    let songStartTime: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = UIColor.blackAlpha(alpha: 0.5)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    // เวลาทั้งหมดของรายการ
    let songTotalTime: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = UIColor.blackAlpha(alpha: 0.5)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    
    // ปุ่มต่อไปนี้ ได้ทำสีให้เป็นสีขาวไว้ เพื่อไม่ให้โชว์
    let suffleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "suffle"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        //        button.tintColor = UIColor.blackAlpha(alpha: 0.5)
        button.tintColor = UIColor.white
        return button
    }()
    
    let replayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "replay"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        //        button.tintColor = UIColor.blackAlpha(alpha: 0.5)
        button.tintColor = UIColor.white
        return button
    }()
    
    let backwardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "backward-arrow"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        //        button.tintColor = UIColor.blackAlpha(alpha: 0.5)
        button.tintColor = UIColor.white
        return button
    }()
    
    let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "play"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.blackAlpha(alpha: 0.8)
        button.addTarget(self, action: #selector(handlePlayMusic), for: .touchUpInside)
        return button
    }()
    
    let forwardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "forward-arrow"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        //        button.tintColor = UIColor.blackAlpha(alpha: 0.5)
        button.tintColor = UIColor.white
        return button
    }()
    
    // ฟังชั่นของการเล่นเสียง
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let url = URL(string: "https://febradio.org/mp3/mon/r.mp3")
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        handlePlayMusic()
    }
    // Action การแชร์
    @IBAction func Share(_ sender: UIBarButtonItem) {
        let text = "ข้อความที่ต้องการแชร์........"
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
        
        
    }
    // ฟังชั่นของ web
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView()
        getCurrentDateTime()   // Date
        
        
        
        
        view.backgroundColor = .white
        
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
        
//        let close = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(handleClose))
//        close.tintColor = UIColor.blackAlpha(alpha: 0.8)
//        navigationItem.leftBarButtonItem = close
        
        
//        let share = UIBarButtonItem(image: UIImage(named: "share"),style: .plain, target: self, action: #selector(handleShare))
//        //        share.tintColor = UIColor.blackAlpha(alpha: 0.8)
//        share.tintColor = UIColor.kelly
//
//        share.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10) //imageInsets คือการจัดตำแหน่งการวางไอคอน
//        navigationItem.rightBarButtonItem = share
        // เมื่อสร้างไอคอนแล้วต้องชี้ไปที่ด้านล่างด้วย @objc func handleShare  เพื่อสั่งงาน Action
        
//        view.addSubview(coverImageShadow)
//        view.addSubview(coverImage)
//        view.addSubview(songName)
//        view.addSubview(songArtist)
//        view.addSubview(songDays)
//        view.addSubview(webView)
        
//
//        let coverImagePadding: CGFloat = ( view.frame.width - 270 ) / 2
//
//        coverImageShadow.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 40, leftConstant: coverImagePadding, bottomConstant: 0, rightConstant: coverImagePadding, widthConstant: 270, heightConstant: 270)
//        coverImage.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 40, leftConstant: coverImagePadding, bottomConstant: 0, rightConstant: coverImagePadding, widthConstant: 270, heightConstant: 270)
//        songName.anchor(coverImage.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 40, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 0)
//        songArtist.anchor(songName.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 0)
//        songDays.anchor(songArtist.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 0)
//        webView.anchor(webView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 0)
        
        
        view.addSubview(sliderSong)
        view.addSubview(songStartTime)
        view.addSubview(songTotalTime)
        
        sliderSong.anchor(nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 140, rightConstant: 20, widthConstant: 0, heightConstant: 10)
        songStartTime.anchor(sliderSong.bottomAnchor, left: sliderSong.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        songTotalTime.anchor(sliderSong.bottomAnchor, left: nil, bottom: nil, right: sliderSong.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(suffleButton)
        view.addSubview(replayButton)
        
        suffleButton.anchor(nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 55, rightConstant: 0, widthConstant: 30, heightConstant: 30)
        replayButton.anchor(nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 55, rightConstant: 20, widthConstant: 30, heightConstant: 30)
        
        let stackView = UIStackView(arrangedSubviews: [backwardButton, playButton, forwardButton])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        view.addSubview(stackView)
        stackView.anchor(nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 100, bottomConstant: 35, rightConstant: 100, widthConstant: 0, heightConstant: 65)
        
    }
    
    // func web
    override func viewDidAppear(_ animated: Bool) {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0)
        webView.frame = frame

        loadRequest(urlStr: "https://febradio.org/index.php/radio/mon")

    }

    func loadRequest(urlStr: String){
        let url = NSURL(string: urlStr)!
        let request = NSURLRequest(url: url as URL)
        webView.load(request as URLRequest)
    }
    
    // ฟังชั่นแสดง Date
    func getCurrentDateTime(){
        
        let formatter = DateFormatter()
//        formatter.dateStyle = .long     // แสดง ปี เดือน วัน
//        formatter.timeStyle = .medium   // แสดง เวลา
        formatter.dateFormat = "EEEE, MMMM,dd,yyyy"  // ถ้าต้องการแสดง เวลาต่อท้าย ก็สามารถใส่ "EEEE, MMMM,dd,yyyy  HH:mm a"
        let str = formatter.string(from: Date())
        label.text = str
    }
    
    // ต่อไปเป็น func close
    
//    @objc func handleClose(){
//
//        if sliderSong.value > 0 {
//
//            playMusic = true
//            pauseMusic = true
//            playButton.setImage(UIImage(named: "play"), for: .normal)
////            stopAnimation()
//
//            player.pause()
//
//        }
//
//        dismiss(animated: true, completion: nil)
//    }
    
//    @objc func handleShare(){
//        let text = "ข้อความที่ต้องการแชร์........"
//        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
//        present(activityViewController, animated: true, completion: nil)
//    }
    
    @objc func handlePlayMusic(){
        
        if playMusic {
            
            if pauseMusic {
                
                playMusic = false
                pauseMusic = false
                player!.play()
                
                playButton.setImage(UIImage(named: "pause"), for: .normal)
                
                let playerDuration = player?.currentItem?.asset.duration.seconds
                
                sliderSong.maximumValue = Float((playerDuration)!)
                
                Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleUpdateSlider), userInfo: nil, repeats: true)
                
                let playerTotalTime = formatSecondsToString(playerDuration!)
                songTotalTime.text = playerTotalTime
                
                checkCoverSpin = true
                
            } else {
                
                playMusic = false
                
                player!.play()
                
                playButton.setImage(UIImage(named: "pause"), for: .normal)
//                resumeAnimation(layer: coverImage.layer)
            }
            
            
        } else {
            
            playMusic = true
            player!.pause()
            
            playButton.setImage(UIImage(named: "play"), for: .normal)
            
//            pauseAnimation(layer: coverImage.layer)
        }
        
    }
    
    var checkCoverSpin: Bool = true
    
    @objc func handleUpdateSlider(){
        
        let playerCurrentTime = player?.currentItem?.currentTime().seconds
        
        sliderSong.value = Float((playerCurrentTime)!)
        
//        if sliderSong.value > 0.0 && checkCoverSpin {
//
//            checkCoverSpin = false
//            self.runSpinAnimationOn(view: self.coverImage, duration: 1, rotation: Double.pi / 2 / 60, repeatCount: MAXFLOAT)
//        }
        
        if !playMusic {
            let playerStartTime = formatSecondsToString(playerCurrentTime!)
            songStartTime.text = playerStartTime
        }
        
        let sliderValue = Int(sliderSong.value)
        let sliderMaximumValue = Int(sliderSong.maximumValue)
        
        if sliderValue == sliderMaximumValue {
            
            playMusic = true
            pauseMusic = true
            playButton.setImage(UIImage(named: "play"), for: .normal)
//            stopAnimation()
            
            player!.pause()
            
            songStartTime.text = "00:00"
            let currentTime = CMTime(seconds: 0.0, preferredTimescale: 1)
            player!.seek(to: currentTime)
            
        }
        
    }
    
    @objc func handleSlider(){
        
        let sliderValue = sliderSong.value
        let currentTime = CMTime(seconds: Double(sliderValue), preferredTimescale: 1)
        player!.seek(to: currentTime)
        
    }
    
    func formatSecondsToString(_ seconds: TimeInterval) -> String {
        if seconds.isNaN {
            return "00:00"
        }
        let Min = Int(seconds / 60)
        let Sec = Int(seconds.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", Min, Sec)
    }
    
//    func runSpinAnimationOn(view: UIView, duration: Double, rotation: Double, repeatCount: Float) {
//        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
//        animation.toValue = NSNumber(value: Double.pi * 2.0 * rotation * duration)
//        animation.duration = duration
//        animation.isCumulative = true
//        animation.repeatCount = repeatCount
//        animation.isRemovedOnCompletion = false
//        animation.fillMode = CAMediaTimingFillMode.forwards
//        view.layer.add(animation, forKey: "rotationAnimation")
//    }
    
//    func pauseAnimation(layer: CALayer) {
//        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
//        layer.speed = 0
//        layer.timeOffset = pausedTime
//    }
    
//    func resumeAnimation(layer: CALayer) {
//        let pausedTime = layer.timeOffset
//        if (pausedTime > 0) {
//            layer.speed = 1
//            layer.timeOffset = 0
//            layer.beginTime = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
//        } else {
//            self.runSpinAnimationOn(view: self.coverImage, duration: 1, rotation: Double.pi / 2 / 60, repeatCount: MAXFLOAT)
//        }
//    }
//
//    func stopAnimation(){
//        coverImage.layer.removeAllAnimations()
//    }
    
}
