//
//  FirstViewController.swift
//  testttt
//
//  Created by Rob Agnoletto on 2020-02-07.
//  Copyright © 2020 Rob Agnoletto. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.songs.count
     }
     
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AudioTableViewCell = self.songTable.dequeueReusableCell(withIdentifier: "cell") as! AudioTableViewCell
         cell.audioName?.text = self.songs[indexPath.row]
         return cell
     }
    @IBOutlet var songTable: UITableView!
    var songs: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        songs =  getSongs()
        print(songs)
        self.songTable.register(AudioTableViewCell.self, forCellReuseIdentifier: "cell")
        songTable.delegate = self
        songTable.dataSource = self
        
        
    }
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
    

}

func getSongs() -> [String] {
    var names: [String] = []
    let path = Bundle.main.resourceURL?.appendingPathComponent("SongFolder")
    do{
        let songs =  try FileManager.default.contentsOfDirectory(at: path!, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
        
        for song in songs{
            
            let strArray =  song.absoluteString.components(separatedBy: "/")
            var songName = strArray[strArray.count-1].replacingOccurrences(of: "%20", with: " ")
            songName =  songName.replacingOccurrences(of: ".mp3", with: "")
            names.append(songName)
            
        }
    }catch{}
    
    return names
}

