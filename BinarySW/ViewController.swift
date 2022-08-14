//
//  ViewController.swift
//  Binary
//
//  Created by 山崎颯汰 on 2022/05/12.
//

import UIKit
import AppTrackingTransparency
import AdSupport


class ViewController: UIViewController {

    var selectTag = 0
    
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var difficultButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        easyButton.layer.cornerRadius = 90
        difficultButton.layer.cornerRadius = 90.0
        
        let backItem  = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
        
        // Do any additional setup after loading the view.
        
        
    }
    

       override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           
           //ATT対応
           if #available(iOS 14, *) {
               switch ATTrackingManager.trackingAuthorizationStatus {
               case .authorized:
                   print("Allow Tracking")
                   print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
               case .denied:
                   print("拒否")
               case .restricted:
                   print("制限")
               case .notDetermined:
                   showRequestTrackingAuthorizationAlert()
               @unknown default:
                   fatalError()
               }
           } else {// iOS14未満
               if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                   print("Allow Tracking")
                   print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
               } else {
                   print("制限")
               }
           }
       }
       

       private func showRequestTrackingAuthorizationAlert() {
           if #available(iOS 14, *) {
               ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                   switch status {
                   case .authorized:
                       print("🎉")
                       //IDFA取得
                       print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
                   case .denied, .restricted, .notDetermined:
                       print("😥")
                   @unknown default:
                       fatalError()
                   }
               })
           }
       }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let VC = segue.destination as! TimeViewController
        VC.selectLevel = selectTag
    }
    
    @IBAction func levelButtonAction(sender: UIButton){
        print(sender.tag)
        selectTag = sender.tag
        performSegue(withIdentifier: "TimeVC", sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}

