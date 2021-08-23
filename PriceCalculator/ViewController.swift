//
//  ViewController.swift
//  PriceCalculator
//
//  Created by D M on 2020/08/23.
//  Copyright © 2020 DM. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var PriceYenTextField: UITextField!
    
    @IBOutlet weak var PriceTaxedTextField: UITextField!
    
    @IBOutlet weak var ConversionRate: UITextField!
    
    @IBOutlet weak var PricePesoTextField: UITextField!
    
    @IBOutlet weak var ProfitValuePercent: UILabel!
    
    @IBOutlet weak var SRPTextField: UITextField!
    
    @IBOutlet weak var NetProfitTextField: UITextField!
    
    @IBOutlet weak var MichLabel: UILabel!
    
    @IBOutlet weak var JoyLabel: UILabel!
    
    @IBOutlet weak var EckaiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        PriceYenTextField.delegate = self
        PriceTaxedTextField.delegate = self
        ConversionRate.delegate = self
        SRPTextField.delegate = self
        
        PriceYenTextField.keyboardType = .numberPad   //or .asciicapableNumberPad
        PriceTaxedTextField.keyboardType = .numberPad   //or .asciicapableNumberPad
        ConversionRate.keyboardType = .numberPad   //or .asciicapableNumberPad
        SRPTextField.keyboardType = .numberPad   //or .asciicapableNumberPad
    

            //You can specify your own selector to be send in "myAction"
        PriceYenTextField.addDoneButtonToKeyboard(myAction:  #selector(self.PriceYenTextField.resignFirstResponder))
        PriceTaxedTextField.addDoneButtonToKeyboard(myAction:  #selector(self.PriceTaxedTextField.resignFirstResponder))
        ConversionRate.addDoneButtonToKeyboard(myAction:  #selector(self.ConversionRate.resignFirstResponder))
        SRPTextField.addDoneButtonToKeyboard(myAction:  #selector(self.SRPTextField.resignFirstResponder))
        
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        PriceYenTextField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func PriceYenEditing(_ sender: UITextField) {
        
        let ReadString = sender.text!
        let ConversionString = ConversionRate.text!
        let tax:Double = 1.1
        
        if let doubleNumber = Double(ReadString) {
            
            PriceTaxedTextField.text = String(round(100 * doubleNumber * tax)/100)
            
            if let doubleNumber2 = Double(ConversionString){ PricePesoTextField.text = String(round(100 * doubleNumber * tax * doubleNumber2)/100)
                
            }
            else {
                PricePesoTextField.text = ""
            }
            
        }
        else {
            PriceTaxedTextField.text = ""
            PricePesoTextField.text = ""
            SRPTextField.text = ""
            NetProfitTextField.text = ""
        }
        
    }
    
    
    @IBAction func RateChange(_ sender: UITextField) {
        
        let ReadString2 = sender.text!
        let PriceTaxedRead = PriceTaxedTextField.text!
        
        if let pricetaxedDouble = Double(PriceTaxedRead){
            
            if let taxedRateDouble = Double(ReadString2) {
                PricePesoTextField.text = String(round(100 * taxedRateDouble * pricetaxedDouble)/100)
                
            }
            else {
                PricePesoTextField.text = ""
            }
        }
        else {
            PricePesoTextField.text = ""
        }
        
    }
    
    
    @IBAction func SRPChange(_ sender: UITextField) {
        
        let ReadString3 = sender.text!
        
        if let SRPDouble = Double(ReadString3) {

            
            let PesoRead = PricePesoTextField.text!
            
            if let PesoReadDouble = Double(PesoRead) {
                NetProfitTextField.text = "₱ " +  String(round((SRPDouble - PesoReadDouble)*100)/100)
                
                ProfitValuePercent.text = String(round(10000 * (SRPDouble - PesoReadDouble)/PesoReadDouble)/100) + String("%")
                
                MichLabel.text = "Mich earns: PHP " + String(round((SRPDouble - PesoReadDouble)*100 * 0.4)/100)
                
                JoyLabel.text = "Joy earns:   PHP " + String(round((SRPDouble - PesoReadDouble)*100 * 0.3)/100)
                
                EckaiLabel.text = "Ekai earns:  PHP " + String(round((SRPDouble - PesoReadDouble)*100 * 0.3)/100)
            }
            else {
                NetProfitTextField.text = ""
            }
        }
        else {
            SRPTextField.text = ""
        }
        
    }
    
}

extension UITextField{

 func addDoneButtonToKeyboard(myAction:Selector?){
    let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    doneToolbar.barStyle = UIBarStyle.default

    let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: myAction)

    var items = [UIBarButtonItem]()
    items.append(flexSpace)
    items.append(done)

    doneToolbar.items = items
    doneToolbar.sizeToFit()

    self.inputAccessoryView = doneToolbar
 }
}
