//
//  MyAVPlayer.swift
//  PrepCoreAudio
//
//  Created by Rob Agnoletto on 2020-02-10.
//  Copyright © 2020 Rob Agnoletto. All rights reserved.
//

import Foundation
import AVFoundation

class MyAVPlayer {
    static let sharedInstance = MyAVPlayer()
    
    var player:AVAudioPlayer = AVAudioPlayer()
    
    let engine = AVAudioEngine()
    let distortion = AVAudioUnitDistortion()
    let reverb = AVAudioUnitReverb()
    
    
    var songs: [String] = getSongs()
    var currSong: Int = -1
    func playPauseSong(index: Int){
        if index < 0 || index >= MyAVPlayer.sharedInstance.songs.count {
            return
        }
        if self.currSong != index {
            do{
                let songPath = Bundle.main.path(forResource: songs[index], ofType: ".mp3", inDirectory: "SongFolder")
                try self.player =  AVAudioPlayer(contentsOf: URL(fileURLWithPath: songPath!))
                self.player.numberOfLoops = -1
                self.player.play()
                self.currSong = index
            }catch{}
        } else if self.player.isPlaying {
            self.player.pause()
        } else {
            self.player.play()
        }
    }

    func stopSong() {
        self.player.stop()
        self.currSong = -1
    }
    
    func restartSong() {
        print("restart",self.currSong, self.player)
        if self.currSong == -1 {
            return
        }
        self.player.currentTime = 0
    }

    func playWithURL(url : NSURL) {
        // Put play code here
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
