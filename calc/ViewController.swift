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
var answer : Double = 0.0
var countnubers:Int = 0
// case operations
var operationActive = 0
// numers with point
var decimalbool:Bool = false
var power = 1
// +/-
var signPlus: Bool = true

var interestBool:Bool = false


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
        if (operationActive != 0 && countnubers == 0)
        {x = 0;}
        countnubers++
        if countnubers<=10
        {
            if signPlus {
                if decimalbool
                {
                    if ( sender.tag == 0){
                        power++
                    }
                    else {
                        x = x + Double(sender.tag)/pow(10,Double(power));
                        power++;
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
                            power++
                        }
                        else {
                            x = x - Double(sender.tag)/pow(10,Double(power));
                            power++;
                        }
                    }
                    else{
                        x = x * 10 - Double(sender.tag)
                    }
            }
            show(x);
            interestBool = false;
        }
    }
    
    @IBAction func decimal(sender : AnyObject){
    decimalbool = true
    }
    
    @IBAction func operations(sender : UIButton){
        if countnubers != 0 || interestBool == true  {
            switch operationActive
                {
                    case 1001:
                        answer = y + x
                    case 1002:
                        answer = y - x
                    case 1003:
                        answer = y * x
                    case 1004 where  x != 0:
                        answer = y / x
                    case 1004 where  x == 0:
                        answer = 0
                    default:  show(x);
                }   }
        if sender.tag != 1000 {
            operationActive  = sender.tag;
            countnubers = 0;
            if answer != 0 {
                y = answer
            } else {
                y = x
            }
        } else
        {
            countnubers = -1;
            y = answer
            show( answer)
        }
        //show(answer);
        power = 1
        decimalbool = false
        signPlus = true;
        interestBool = false
        answer = 0
    }
    
    @IBAction func clearAllclear(sender:AnyObject){
        if x == 0 {
            y = 0.0
        }
            countnubers = 0
            power = 1
            decimalbool = false;
            self.result.text=String(0)
            signPlus = true
            interestBool = false;
            x = 0.0
            answer = 0.0
        
    }
    
    func show (number: Double)-> Void {
     var test = number/Double(Int64(number))
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
    
    @IBAction func sign (sender: AnyObject){
        if countnubers == 0 && operationActive == 1000 {x = y}
        x = -x
        show(x);
        signPlus = !signPlus
    }
    
    @IBAction func interest (sender : AnyObject){
        if y != 0 {
            answer = y/100*x;
        } else {
            answer=x/100;
            operationActive = 1;
        }
        show(answer);
        countnubers = 0;
        power = 1;
        decimalbool = false;
        signPlus = true;
        interestBool = true
    }
}

