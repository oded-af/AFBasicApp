//
//  ViewController.swift
//  AFBasicApp
//
//  Created by Oded Rinsky on 10/06/2021.
//

import UIKit
import AppTrackingTransparency

class ViewController: UIViewController {

    @IBOutlet weak var conversionDataParams: UITextView!
    @IBOutlet weak var showConversionDataButton: UIButton!
    
    @IBAction func showConversionData(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let conversionData = appDelegate.ConversionData
        conversionDataParams.sizeToFit()
        if conversionData != nil{
            if let conversionData = conversionData as! [String:Any]? {
                conversionDataParams.attributedText = attributionDataToString(data: conversionData)
                conversionDataParams.textColor = .label
                showConversionDataButton.isHidden = true
            }
        }
        else{
            conversionDataParams.text = "Conversion data not available. \nPlease try again"
            conversionDataParams.textColor = .label
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showConversionDataButton.titleLabel?.adjustsFontSizeToFitWidth = true
        if #available(iOS 14, *) {
          ATTrackingManager.requestTrackingAuthorization { (status) in
            switch status {
            case .denied:
                print("AuthorizationSatus is denied")
            case .notDetermined:
                print("AuthorizationSatus is notDetermined")
            case .restricted:
                print("AuthorizationSatus is restricted")
            case .authorized:
                print("AuthorizationSatus is authorized")
            @unknown default:
                fatalError("Invalid authorization status")
            }
          }
        }
    }
    
    func attributionDataToString(data : [String: Any]) -> NSMutableAttributedString {
        let newString = NSMutableAttributedString()
        let boldAttribute = [
           NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 18.0)!
        ]
        let regularAttribute = [
           NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 18.0)!
        ]
        let sortedKeys = Array(data.keys).sorted(by: <)
        for key in sortedKeys {
            print("ViewController", key, ":",data[key] ?? "null")
            let keyStr = key
            let boldKeyStr = NSAttributedString(string: keyStr, attributes: boldAttribute)
            newString.append(boldKeyStr)
            
            var valueStr: String
            switch data[key] {
            case let s as String:
                valueStr = s
            case let b as Bool:
                valueStr = b.description
            default:
                valueStr = "null"
            }
            
            let normalValueStr = NSAttributedString(string: ": \(valueStr)\n", attributes: regularAttribute)
            newString.append(normalValueStr)
        }
        return newString
    }
}
