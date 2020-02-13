//
//  FirstViewController.swift
//  testttt
//
//  Created by Rob Agnoletto on 2020-02-07.
//  Copyright © 2020 Rob Agnoletto. All rights reserved.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var songTable: UITableView!
    var songs: [String] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.songs.count
     }
     
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AudioTableViewCell = self.songTable.dequeueReusableCell(withIdentifier: "cell") as! AudioTableViewCell
        cell.textLabel?.text = self.songs[indexPath.row]
        return cell
     }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MyAVAudioEngine.sharedInstance.playPauseSong(index: indexPath.row)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        songs =  MyAVAudioEngine.sharedInstance.songs
        self.songTable.register(AudioTableViewCell.self, forCellReuseIdentifier: "cell")
        songTable.delegate = self
        songTable.dataSource = self
        
    }
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
    

}




