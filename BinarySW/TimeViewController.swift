//
//  TimeViewController.swift
//  Binary
//
//  Created by 山崎颯汰 on 2022/05/12.
//

import UIKit
import AudioToolbox
import GoogleMobileAds

var vibrationCount = 5

class TimeViewController: UIViewController {
        
    @IBOutlet weak var label: UILabel!
    @IBOutlet var goal: UILabel!
    @IBOutlet var dif: UILabel!
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var pause: UIButton!
    @IBOutlet weak var reset: UIButton!
        
    var bannerView: GADBannerView!
    var OurTImer = Timer()
    var TimerDisplayed = 0.0
    var TextNum = 0.0
    var goalNum = 0
    var selectLevel = 0
    var i = 0

    @IBAction func startButton(_ sender: Any) {
        
        
        start.isEnabled = false
        start.isHidden = true
        pause.isEnabled = true
        pause.isHidden = false
            
        
        
        if(selectLevel == 1){
            OurTImer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(Action), userInfo: nil, repeats: true)
            goalNum = Int.random(in: 30..<50)
            goal.text = String(goalNum, radix: 2)
        }else{
            OurTImer = Timer.scheduledTimer(timeInterval: 0.13, target: self, selector: #selector(Action), userInfo: nil, repeats: true)
            goalNum = Int.random(in: 30..<50)
            goal.text = "\(goalNum)"
        }
            
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        OurTImer.invalidate()
        
        reset.isEnabled = true
        
        pause.isEnabled = false
        
        
        
        if(String(Int(TextNum), radix: 2) == String(goalNum, radix: 2)){
            dif.text = "Perfect!!"
            label.textColor = UIColor.green
            dif.textColor = UIColor.green
            dif.isHidden = false
            self.startVibrateInterval()
            AudioServicesPlaySystemSound(1013)
        }else{
            AudioServicesPlaySystemSound(1011)
            
            i = Int(TextNum) - goalNum
            
            if(i < 0){
                dif.text = String(i, radix: 2)
                dif.textColor = UIColor.blue
            }else{
                dif.text = "+" + String(i, radix: 2)
                dif.textColor = UIColor.red
            }
            
            dif.isHidden = false
        }
            
        if(selectLevel == 2){
            goal.text = "\(goalNum) : " + String(goalNum, radix: 2)
        }
    }
    
    
    func startVibrateInterval() {
        
            // どのバイブレーションを鳴らすか
            let systemSoundID = SystemSoundID(kSystemSoundID_Vibrate)
            
            // 繰り返し用のコールバックをセット
        AudioServicesAddSystemSoundCompletion(systemSoundID, nil, nil, {(systemSoundID, nil) -> Void in
            vibrationCount =  vibrationCount - 1
                
                if ( vibrationCount > 0 ) {
                    // 繰り返し再生
                    AudioServicesPlaySystemSound(systemSoundID)
                }
                else {
                    // コールバックを解除
                    AudioServicesRemoveSystemSoundCompletion(systemSoundID)
                }
                
            }, nil)
            
            // 初回のバイブレーションを鳴らす
            AudioServicesPlaySystemSound(systemSoundID)
            
        }
    
    
    @IBAction func resetButton(_ sender: Any) {
        OurTImer.invalidate()
        TimerDisplayed = 0
        label.text = "0"
        goal.text = "--"
        
        pause.isHidden = true
        start.isEnabled = true
        start.isHidden = false
        
        reset.isEnabled = false
        dif.isHidden = true
        
        label.textColor = UIColor.black
        dif.textColor = UIColor.black
        
        vibrationCount = 5
    }
        
    @objc func Action() {
        TimerDisplayed += 0.1
        TextNum = TimerDisplayed * 10
            
        //label.text = String(format: "%03d", Int(TextNum))
            
        let str2  = String(Int(TextNum), radix: 2)
        label.text = str2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pause.isEnabled = false
        pause.isHidden = true
        reset.isEnabled = false
        dif.isHidden = true
        
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        bannerView.adUnitID = "ca-app-pub-5041739959288046/5298606672"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)
        
        
    }
        
    
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: view.safeAreaLayoutGuide,
                                attribute: .bottom,
                                multiplier: 1,
                                constant: 0) ,
            NSLayoutConstraint(item: bannerView,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .centerX,
                               multiplier: 1,
                               constant: 0)
            ])
    }
    
    
}
