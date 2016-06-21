//
//  ViewController.swift
//  tips
//
//  Created by Dat Hoang on 6/14/16.
//  Copyright © 2016 Dat Hoang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var twoPplSplit: UILabel!
    @IBOutlet weak var threePplSplit: UILabel!
    @IBOutlet weak var fourPplSplit: UILabel!
 
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipResultView: UIView!
    
    @IBOutlet weak var MainView: UIView!

    @IBOutlet weak var percentageLabel: UILabel!

    @IBOutlet weak var percentageView: UIView!
    
    var percentageAmount: Double!
    var colorBirghtnessValue: CGFloat!
    var colorSaturationValue: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Prepare for App appear
        prep()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(NSString(string: billField.text!).doubleValue, forKey: "billAmount")
        defaults.setDouble(percentageAmount, forKey: "percentageAmount")
        defaults.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {

        var billAmount = NSString(string: billField.text!).doubleValue
        var tip = billAmount * percentageAmount
        var total = billAmount + tip
        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"
        twoPplSplit.text = "$\((total / 2))"
        threePplSplit.text = "$\((total / 3))"
        fourPplSplit.text = "$\((total / 4))"
        
        
        billField.text = String(format:"%.0f%",NSString(string: billField.text!).doubleValue)
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        twoPplSplit.text = String(format: "$%.2f", total / 2)
        threePplSplit.text = String(format: "$%.2f", total / 3)
        fourPplSplit.text = String(format: "$%.2f", total / 4)
        showResultView(false)
   
        
        

    }
    
    func prep(){
        //Result view when app opened
        self.tipResultView.alpha = 0
        //initialize labels and fields
        let defaults = NSUserDefaults.standardUserDefaults()
        let billAmount = defaults.doubleForKey("billAmount")

        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        billField.text = String(format:"%.0f%",billAmount)
        percentageAmount = defaults.doubleForKey("defaultPercentage")
        percentageLabel.text = String(format:"%.0f%%",percentageAmount * 100)
        percentageLabel.alpha = 0
        
        //check for darkTheme Activate
        let darkThemeActive = defaults.integerForKey("darkTheme")
        if(darkThemeActive == 1){
            colorBirghtnessValue = 0.3
            colorSaturationValue = 0.4
            switchToDarkTheme()
        } else {
            switchToLightTheme()
            colorBirghtnessValue = 1
            colorSaturationValue = 0.3
        }
        if(billAmount > 0 ){
            onEditingChanged(view)
            
        }
        
        //Auto focus Entering Bill Amount
        billField.becomeFirstResponder()

    }

    func switchToDarkTheme(){
        //Activate dark theme
        view.backgroundColor = UIColor.blackColor()
        billField.textColor = UIColor.darkGrayColor()
        billField.keyboardAppearance = UIKeyboardAppearance.Dark
        tipResultView.backgroundColor = UIColor.blackColor()
        tipLabel.textColor = UIColor.darkGrayColor()
        totalLabel.textColor = UIColor.darkGrayColor()
        twoPplSplit.textColor = UIColor.darkGrayColor()
        threePplSplit.textColor = UIColor.darkGrayColor()
        fourPplSplit.textColor = UIColor.darkGrayColor()
        
    }
    func switchToLightTheme(){
        //Deactive dark theme
        view.backgroundColor = UIColor.whiteColor()
        billField.textColor = UIColor(colorLiteralRed: 0.6, green: 0.6, blue: 0.6, alpha: 0.6)
        billField.keyboardAppearance = UIKeyboardAppearance.Light
        tipResultView.backgroundColor = UIColor.whiteColor()
        tipLabel.textColor = UIColor(red: 0.4, green: 0.8, blue: 1, alpha: 1)
        totalLabel.textColor = UIColor(red: 0.08, green: 0.74, blue: 1, alpha: 1)
        twoPplSplit.textColor = UIColor(red: 0.08, green: 0.74, blue: 1, alpha: 1)
        threePplSplit.textColor = UIColor(red: 0.08, green: 0.74, blue: 1, alpha: 1)
        fourPplSplit.textColor = UIColor(red: 0.08, green: 0.74, blue: 1, alpha: 1)

    }
    
    
    func showResultView(animated: Bool){
        var billAmount = NSString(string: billField.text!).doubleValue
        if(billAmount == 0 ){
            UIView.animateWithDuration(0.3, delay: 0.2, options: .CurveEaseOut, animations: {
                self.tipResultView.alpha = 0
                self.percentageLabel.alpha = 0
                }, completion: nil)
            UpdateBillFieldColor(true)
            

        } else {
            UIView.animateWithDuration(0.3, delay: 0.2, options: .CurveEaseOut, animations: {
                
                //self.billFieldCenter.constant = self.billField.frame.height - self.tipResultView.frame.height/2
                self.percentageLabel.alpha = 1
                self.tipResultView.alpha = 1
                }, completion: nil)
        }
        

    }
    


    @IBAction func panned(sender: AnyObject) {

        view.endEditing(true)

        var tipPercentages = [0.18, 0.2, 0.25]
        var tipPercentMax = 1.0
        var tipPercentMin = 0.1
        var tipPercent = percentageAmount
        var tipPercentTapStart: Double = percentageAmount
        var translation = sender.translationInView(self.view)
        var translationX = Double(translation.x)
        
        if (sender.state == UIGestureRecognizerState.Began) {

            tipPercentTapStart = tipPercent
            UpdateBillFieldColor(true)
            
        } else if (sender.state == UIGestureRecognizerState.Changed) {

            translationX = Double(translation.x)

            tipPercent = (tipPercentTapStart + translationX / 4000)
            
            if (tipPercent > tipPercentMax) {
                tipPercent = tipPercentMax;
            } else if (tipPercent < tipPercentMin) {
                tipPercent = tipPercentMin;
            }
            self.percentageAmount = tipPercent
            self.percentageLabel.text = String(format:"%.0f%%",tipPercent * 100)

            onEditingChanged(sender)
            UpdateBillFieldColor(true)
            
            
            
        } else {
            return;
        }
        

        
    }
    



    func UpdateBillFieldColor(animated: Bool){
        var hueHigh: CGFloat = 0.333
        var hueLow: CGFloat = 0
        var viewBgColorHueValue: CGFloat
        var tipPercentMax: CGFloat = 1
        var tipPercentMin: CGFloat = 0
        var percentageLabelAmount = NSString(string: percentageLabel.text!).floatValue
        print(percentageLabelAmount)
        let percentageLabelAmountCGF = CGFloat(percentageLabelAmount)
        viewBgColorHueValue = ((hueHigh - hueLow) / (tipPercentMax - tipPercentMin)) * (percentageLabelAmountCGF - tipPercentMin) + hueLow
        print(viewBgColorHueValue)
       var billAmountViewColor = UIColor(
            hue:viewBgColorHueValue / 70
            ,saturation:colorSaturationValue
            ,brightness:colorBirghtnessValue
            ,alpha:1.0)
        print(billAmountViewColor)
       
        
                self.view.backgroundColor = billAmountViewColor
        
        }
    
    @IBAction func onTap(sender: AnyObject) {
        //Remove keyboard when tap anywhere on screen beside BillField
        view.endEditing(true)
       
      
    }

}

