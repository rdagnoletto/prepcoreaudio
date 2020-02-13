//
//  SecondViewController.swift
//  testttt
//
//  Created by Rob Agnoletto on 2020-02-07.
//  Copyright © 2020 Rob Agnoletto. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBAction func RestartSong(_ sender: UIButton, forEvent event: UIEvent) {
        MyAVAudioEngine.sharedInstance.restartSong()
    }
    @IBAction func EffectSlider(_ sender: UISlider, forEvent event: UIEvent) {
        
    }
    @IBAction func EffectSwitch(_ sender: UISwitch, forEvent event: UIEvent) {
        MyAVAudioEngine.sharedInstance.toggleEffects(turnOn: sender.isOn)
    }
    @IBAction func SliderMoved(_ sender: UISlider, forEvent event: UIEvent) {
        MyAVAudioEngine.sharedInstance.adjustBassBoost(dB: sender.value)
    }
    @IBAction func SliderDoneMoving(_ sender: UISlider, forEvent event: UIEvent) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

}

