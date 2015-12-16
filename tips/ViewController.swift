//
//  ViewController.swift
//  tips
//
//  Created by you wu on 11/30/15.
//  Copyright © 2015 you wu. All rights reserved.
//

import UIKit
let lightColor = UIColor(red: 175/255, green: 1, blue: 175/255, alpha: 1)
let darkColor = UIColor(red: 10/255, green: 20/255, blue: 10/255, alpha: 1)
let titleColor = UIColor(red: 62/255, green: 125/255, blue: 91/255, alpha: 1)

class ViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalLabel2: UILabel!
    @IBOutlet weak var totalLabel3: UILabel!
    @IBOutlet weak var totalLabel4: UILabel!
    @IBOutlet weak var tipView: UIView!
    
    let currencySymbol = NSLocale.currentLocale().objectForKey(NSLocaleCurrencySymbol) as! String
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let initPrice = currencySymbol + "0.00"
        tipLabel.text = initPrice
        totalLabel.text = initPrice
        totalLabel2.text = initPrice
        totalLabel3.text = initPrice
        totalLabel4.text = initPrice
        
        billTextField.placeholder = currencySymbol
        billTextField.becomeFirstResponder()
        
        self.tipView.alpha = 0
        self.tipControl.alpha = 0
        self.tipView.transform.ty = 100
        self.tipControl.transform.ty = 100
        self.billTextField.transform.ty = 100
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: "defaultTip")
        defaults.setBool(false, forKey: "isDark")
        defaults.synchronize()
        
        //dark light scheme
        navigationController!.navigationBar.translucent = true
        navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController!.navigationBar.shadowImage = UIImage()
        
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: titleColor]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        let defaultTipPercentage = defaults.integerForKey("defaultTip")
        tipControl.selectedSegmentIndex = defaultTipPercentage
        tipControl.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        let isDark = defaults.boolForKey("isDark")
        if (isDark){
            view.backgroundColor = darkColor
            
        }else {
            view.backgroundColor = lightColor
            
        }
        
    }
    
    
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        
        var tipPercentages = [0.18, 0.2, 0.25]
        let tipPercent = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmount = Double(billTextField.text!)
        if let bill = billAmount {
            UIView.animateWithDuration(0.2, animations: {
                // This causes first view to fade in and second view to fade out
                self.billTextField.transform.ty = 0
                self.tipView.transform.ty = 0
                self.tipControl.transform.ty = 0
                self.tipView.alpha = 1
                self.tipControl.alpha = 1
                
            })
            
            let tip = bill * tipPercent
            let total = bill + tip
            let total2 = total/2
            let total3 = total/3
            let total4 = total/4
            
            tipLabel.text = String.localizedStringWithFormat("\(currencySymbol)%.2f",tip)
            totalLabel.text = String.localizedStringWithFormat("\(currencySymbol)%.2f", total)
            totalLabel2.text = String.localizedStringWithFormat("\(currencySymbol)%.2f", total2)
            totalLabel3.text = String.localizedStringWithFormat("\(currencySymbol)%.2f", total3)
            totalLabel4.text = String.localizedStringWithFormat("\(currencySymbol)%.2f", total4)
        }else {
            UIView.animateWithDuration(0.2, animations: {
                // This causes first view to fade in and second view to fade out
                self.billTextField.transform.ty = 100
                self.tipView.transform.ty = 100
                self.tipControl.transform.ty = 100
                self.tipView.alpha = 0
                self.tipControl.alpha = 0
                
            })
            
            let initPrice = currencySymbol + "0.00"

            tipLabel.text = initPrice
            totalLabel.text = initPrice
            totalLabel2.text = initPrice
            totalLabel3.text = initPrice
            totalLabel4.text = initPrice
        }
        
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
}

