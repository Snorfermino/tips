//
//  SettingsViewController.swift
//  tips
//
//  Created by Dat Hoang on 6/14/16.
//  Copyright © 2016 Dat Hoang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var darkThemeChoice: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("setting did disappear")
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: "selectedPercentage")
        defaults.setDouble(0.2, forKey: "defaultPercentage")
        defaults.synchronize()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        
        tipControl.selectedSegmentIndex = defaults.integerForKey("selectedPercentage")
        let darkSwitch = defaults.integerForKey("darkTheme")
        if(darkSwitch == 1){
            darkThemeChoice.on = true
        } else {
            darkThemeChoice.on = false
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPercentageChanged(sender: AnyObject) {
        var tipPercentages = [0.15, 0.2, 0.25]

        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: "selectedPercentage")
        defaults.setDouble(tipPercentages[tipControl.selectedSegmentIndex], forKey: "defaultPercentage")
        defaults.synchronize()
    }
    
    @IBAction func darkThemeSwitch(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if(darkThemeChoice.on) {
            
            
            defaults.setInteger(1, forKey: "darkTheme")
            
        } else {
            defaults.setInteger(0, forKey: "darkTheme")
        }
        defaults.synchronize()

    }



}
