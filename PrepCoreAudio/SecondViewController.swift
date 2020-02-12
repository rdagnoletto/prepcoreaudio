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
        MyAVPlayer.sharedInstance.restartSong()
    }
    @IBAction func EffectSlider(_ sender: UISlider, forEvent event: UIEvent) {
    }
    @IBAction func EffectSwitch(_ sender: UISwitch, forEvent event: UIEvent) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

}

