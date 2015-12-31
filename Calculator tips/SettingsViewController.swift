//
//  SettingViewController.swift
//  Calculator tips
//
//  Created by Ali Hadwan on 12/13/15.
//  Copyright © 2015 Ali Hadwan. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tipChangerSlider: UISlider!
    @IBOutlet weak var percentagevalueLabel: UILabel!
    
    
    @IBAction func tipSliderAction(sender: AnyObject) {
        
        super.viewDidLoad()
        let tipPercentage = (round(tipChangerSlider.value * 100)/100)
        print(tipPercentage)
        percentagevalueLabel.text = "\(String(format: "%.0f%",tipPercentage * 100))%"
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setFloat(tipPercentage, forKey: "defaultTipControl")
        defaults.synchronize()
        
    
    }
    
    
        override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(animated)
    
            let defaults = NSUserDefaults.standardUserDefaults()
            let defaultTip = defaults.integerForKey("default_tip")
            print("got default tip: \(defaultTip)")
            
            let savedTipPercent = defaults.floatForKey("defaultTipControl")
            tipChangerSlider.value = savedTipPercent
            percentagevalueLabel.text = "\(Int(savedTipPercent*100))%"
            print("savedTipPercent: \(savedTipPercent)")
    
    }
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        percentagevalueLabel.text = "0%"
        
        
    }

    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
    
    @IBAction func BackButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    

    }
    
}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

