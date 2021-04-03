//
//  ViewController.swift
//  Controls Practics
//
//  Created by Alexwrom on 03.04.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var switches: [UISwitch]!
    
    var bytes: UInt8 = 128{
        didSet{
            updateUI()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        rotate()
        updateUI()
    }
    
    func rotate(){
        for swi in switches{
            swi.layer.transform = CATransform3DMakeRotation(.pi / 2, 0, 0, 1)
        }
    }
    
    /// UpdateUI
    func updateUI(){
        button.setTitle("\(bytes)", for: [])
        setSwitches()
        slider.value = Float(bytes)
        textField.text = "\(bytes)"
    }
    
    func setSwitches(){
        var tmp = bytes
        
        for swi in switches{
            swi.isOn = false
        }
        
        for tag in [128,64,32,16,8,4,2,1]{
            if Int(tmp) - tag >= 0{
                tmp -= UInt8(tag)
                
                for swi in switches{
                    if swi.tag == tag{
                        swi.isOn = true
                        break
                    }
                }
            }
        }
    }
    
    @IBAction func btnClick() {
        bytes = UInt8((Int(bytes) + 1) % 256)
    }
    
    @IBAction func sliderChange() {
        bytes = UInt8(slider.value)
    }
    
    @IBAction func switchCheck(_ sender: UISwitch) {
        var tmp = 0
        for swi in switches{
            if swi.isOn {
               tmp += swi.tag
            }
        }
        bytes = UInt8(tmp)
    }
    
    @IBAction func textChange() {
        bytes = UInt8(textField.text ?? "0" ) ?? 128
    }
    
}

