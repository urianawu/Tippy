//
//  ViewController.swift
//  tips
//
//  Created by you wu on 11/30/15.
//  Copyright © 2015 you wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalLabel2: UILabel!
    @IBOutlet weak var totalLabel3: UILabel!
    @IBOutlet weak var totalLabel4: UILabel!
    @IBOutlet weak var tipView: UIView!
    
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        totalLabel2.text = "$0.00"
        totalLabel3.text = "$0.00"
        totalLabel4.text = "$0.00"
        
        billTextField.becomeFirstResponder()
        self.tipView.alpha = 0
        self.tipControl.alpha = 0
        self.tipView.transform.ty = 100
        self.tipControl.transform.ty = 100
        self.billTextField.transform.ty = 100

        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: "defaultTip")
        defaults.synchronize()
        
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
            
            tipLabel.text = String.localizedStringWithFormat("$%.2f", tip)
            totalLabel.text = String.localizedStringWithFormat("$%.2f", total)
            totalLabel2.text = String.localizedStringWithFormat("$%.2f", total2)
            totalLabel3.text = String.localizedStringWithFormat("$%.2f", total3)
            totalLabel4.text = String.localizedStringWithFormat("$%.2f", total4)
        }else {
            UIView.animateWithDuration(0.2, animations: {
                // This causes first view to fade in and second view to fade out
                self.billTextField.transform.ty = 100
                self.tipView.transform.ty = 100
                self.tipControl.transform.ty = 100
                self.tipView.alpha = 0
                self.tipControl.alpha = 0
                
            })
            
            tipLabel.text = "$0.00"
            totalLabel.text = "$0.00"
            totalLabel2.text = "$0.00"
            totalLabel3.text = "$0.00"
            totalLabel4.text = "$0.00"
        }
        
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
}

