//
//  ViewController.swift
//  Calculator tips
//
//  Created by Ali Hadwan on 11/28/15.
//  Copyright © 2015 Ali Hadwan. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var peopleControlOn = false
    var total : Float = 0.0
    let currency_format = NSNumberFormatter()

    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControlSlider: UISlider!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var sliderSlider: UISlider!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var eachpersonLabel: UILabel!
    

    override func viewDidLoad()
    {
        
        super.viewDidLoad()        // Do any additional setup after loading the view, typically from a nib.
    
        currency_format.locale = NSLocale.currentLocale()
        let currencySymbol = currency_format.currencySymbol
        billField.placeholder = "Enter your Amount in \(currencySymbol)"
        
        tipLabel.text = "\(currencySymbol)0.00"
        totalLabel.text = "\(currencySymbol)0.00"
        percentageLabel.text = "\(currencySymbol)0.00"
        eachpersonLabel.text = "👤 \(currencySymbol)0.00"
        eachpersonLabel.hidden = true
        sliderSlider.hidden = true
        peopleLabel.hidden = true
       
    }
    
    
    

   
    @IBAction func peopleControl(sender: UISlider) {
        
        let currencySymbol = currency_format.currencySymbol
        
        let currentValue:String = String (Int(sliderSlider.value))
        peopleLabel.text = "👥 \(currentValue)"
        
        let eachPersonTotal = (total / Float(currentValue)!)
        
        eachpersonLabel.text = String(format: "👤 \(currencySymbol) %.2f", eachPersonTotal)
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let defaultTip = defaults.integerForKey("default_tip")
        print("got default tip: \(defaultTip)")
        
        let savedTipPercent = defaults.floatForKey("defaultTipControl")
        tipControlSlider.value = savedTipPercent
        percentageLabel.text = "\(Int(savedTipPercent))%"
        
        print("savedTipPercent: \(savedTipPercent)")
        calculateAndUptade()
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
            
    @IBAction func controlSwitch(sender: AnyObject) {
        
        if mySwitch.on{
            eachpersonLabel.hidden = false
            sliderSlider.hidden = false
            peopleLabel.hidden = false
            view.endEditing(true)
        }
    else {
            eachpersonLabel.hidden = true
            sliderSlider.hidden = true
            peopleLabel.hidden = true
            view.endEditing(false)
        }
    }
    
    func calculateAndUptade() {
        
        let currentValue = Int(sliderSlider.value)
        currency_format.locale = NSLocale.currentLocale()
        let currencySymbol = currency_format.currencySymbol
        let billAmount = NSString(string: billField.text!).floatValue
        let tipPercentage = (round(tipControlSlider.value * 100)/100)
        
        percentageLabel.text = "\(String(format: "%.0f%",tipPercentage * 100))%"
        let tipAmount = billAmount * tipPercentage
        total = billAmount + tipAmount
        
        tipLabel.text = String(format:"\(currencySymbol) %.2f", tipAmount)
        totalLabel.text = String(format:"\(currencySymbol) %.2f", total)
        let eachPersonTotal = (total / Float(currentValue))
        
        eachpersonLabel.text = String(format: "👤 \(currencySymbol) %.2f", eachPersonTotal)
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    
    
    @IBAction func onEditiingChanged(sender: AnyObject)
    {
        calculateAndUptade()
        
    }

    @IBAction func onTap(sender: AnyObject)
    {
        view.endEditing(true)
    }
}

