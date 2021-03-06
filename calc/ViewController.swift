//
//  ViewController.swift
//  calc
//
//  Created by Pavlo on 2/13/16.
//  Copyright (c) 2016 Buryi. All rights reserved.
//

import UIKit

var x : Double = 0.0
var y : Double = 0.0
var x1 : Double?
var countnubers:Int = 0
// case operations
var operationActive = 0
// numers with point
var decimalbool:Bool = false
var power = 1
// +/-
var signPlus: Bool = true
// %
var interestBool:Bool = false
// =
var equalBoll: Bool = false


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func digitals (sender: UIButton){
        if countnubers == -1 {
            countnubers = 0
        }
        if equalBoll {
            x = 0
            clearAllclear(x)
        }
        if (operationActive != 0 && countnubers == 0)
        {x = 0;}
        countnubers+=1
        if countnubers<=10
        {
            if signPlus {
                if decimalbool
                {
                    if ( sender.tag == 0){
                        power+=1
                    }
                    else {
                        x = x + Double(sender.tag)/pow(10,Double(power));
                        power+=1
                    }
                }
                else
                {
                    x = x * 10 + Double(sender.tag)
                }
            }
            else {
                    if decimalbool {
                        if ( sender.tag == 0){
                            power += 1
                        }
                        else {
                            x = x - Double(sender.tag)/pow(10,Double(power));
                            power += 1
                        }
                    }
                    else{
                        x = x * 10 - Double(sender.tag)
                    }
            }
            show(x);
            interestBool = false
        }
    }
    
    @IBAction func decimal(sender : AnyObject){
    decimalbool = true
    }
    
    @IBAction func operations(sender : UIButton){
        if equalBoll == true && sender.tag != 1000 {
            operationActive = -1
            x = y
        }
        if countnubers != 0 || interestBool == true  {
            switch operationActive
                {
                    case 1001:
                        x1 = x;
                        x = y + x
                    case 1002:
                        x1 = x
                        x = y - x
                    case 1003:
                        x1 = x
                        x = y * x
                    case 1004 where  x != 0:
                        x1 = x
                        x = y / x
                    case 1004 where  x == 0:
                        x = 0
                    case 1010:
                        x1 = x
                        x = 1/x
                    case 1100:
                        x1 = x;
                        x =  pow(y, x);
                    default:  show(x);
                }   }
        show(x)
        if sender.tag != 1000 {
            operationActive  = sender.tag;
            countnubers = 0;
            y = x
            equalBoll = false
        }
        else{
            countnubers = -1;
            y = x
            x = x1 ?? 0
            equalBoll = true
        }
        power = 1
        decimalbool = false
        signPlus = true;
        interestBool = false
    }
    
    @IBAction func clearAllclear(sender:AnyObject){
        if x == 0 {
            y = 0.0
            x1 = nil
            equalBoll = false
        }
            countnubers = 0
            power = 1
            decimalbool = false;
            self.result.text=String(0)
            signPlus = true
            interestBool = false;
            x = 0.0
            operationActive = 0
    }
    
    func show (number: Double)-> Void {
     let test = number/Double(Int64(number))
        if ( test == 1) {
            decimalbool = false}
        else{
            decimalbool = true}
      if decimalbool  {
            self.result.text = "\(number)"
        }
        else{
            self.result.text = String(Int64(number))
        }
    }
    
    @IBOutlet var result: UILabel!
    
    @IBAction func interest (sender : AnyObject){
        if y != 0 {
             x = y/100*x;
        } else {
             x = x/100
            operationActive = 1
            show(x)
        }
        countnubers = 0;
        power = 1;
        decimalbool = false;
        signPlus = true;
        interestBool = true
    }
    
    @IBAction func sign(sender: AnyObject){
        if countnubers == 0 && operationActive == 1000 {x = y}
        x = -x
        show(x);
        signPlus = !signPlus
    }
}