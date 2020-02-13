//
//  MyAVAudioEngine.swift
//  PrepCoreAudio
//
//  Created by Rob Agnoletto on 2020-02-10.
//  Copyright © 2020 Rob Agnoletto. All rights reserved.
//

import Foundation
import AVFoundation

class MyAVAudioEngine {
    static let sharedInstance = MyAVAudioEngine()
    
//    var player:AVAudioPlayer = AVAudioPlayer()
    
    var engine = AVAudioEngine()
    var playerNode = AVAudioPlayerNode()
    var distortion = AVAudioUnitDistortion()
    var reverb = AVAudioUnitReverb()
    var bassBoost = AVAudioUnitEQ(numberOfBands: 1)
//    var globalGain = AVAudioUnitEQ(numberOfBands: 1)
    
    var currSong: Int = -1
    var songs: [String] = []
//    var audioFile : AVAudioFile!
    
    init() {
//        self.globalGain.globalGain = -5
        self.bassBoost.bands[0].frequency = 500
        self.bassBoost.bands[0].gain = 0
        self.bassBoost.bands[0].bypass = false
        self.bassBoost.bands[0].filterType = (AVAudioUnitEQFilterType(rawValue: 7))!
        
        let format = engine.inputNode.inputFormat(forBus: 0)
        self.songs = getSongs()
        self.engine.attach(self.playerNode)
//        self.engine.attach(self.distortion)
//        self.engine.attach(self.globalGain)
        self.engine.attach(self.bassBoost)

        self.engine.connect(self.playerNode,
                            to: self.bassBoost,
                            format: format)
//        self.engine.connect(self.globalGain,
//                            to: self.bassBoost,
//                            format: format)
        
        self.engine.connect(self.bassBoost,
                            to: engine.outputNode,
                            format: format)
        
        do {
            try self.engine.start()
        } catch {
            print("couldn't start the engine")
        }
    }
    
    func toggleEffects(turnOn: Bool) {
        self.bassBoost.bands[0].bypass = !turnOn
    }
    
    func adjustBassBoost(dB: Float) {
        self.bassBoost.bands[0].gain = dB
    }
    
    func playPauseSong(index: Int){
        if index < 0 || index >= MyAVAudioEngine.sharedInstance.songs.count {
            return
        }
        if self.currSong != index {
            let songPath = Bundle.main.path(forResource: songs[index], ofType: ".mp3", inDirectory: "SongFolder")

            let audioFile = try! AVAudioFile(forReading: URL(fileURLWithPath: songPath!))
            self.playerNode.stop()
            self.playerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)

            self.playerNode.play()
            self.currSong = index
        } else if self.playerNode.isPlaying {
            self.playerNode.pause()
        } else {
            self.playerNode.play()
        }
    }

    func stopSong() {
        self.playerNode.stop()
        self.currSong = -1
    }
    
    func restartSong() {
        if self.currSong == -1 {
            return
        }
        let songInd = self.currSong
        self.stopSong()
        self.playPauseSong(index: songInd)
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
