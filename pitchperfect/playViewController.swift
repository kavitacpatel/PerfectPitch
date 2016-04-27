//
//  playviewcontroller.swift
//  pitchperfect
//
//  Created by kavita patel on 3/30/16.
//  Copyright © 2016 kavita patel. All rights reserved.
//

import UIKit
import AVFoundation

class playViewController: UIViewController {
   
    var recordedAudio: NSURL!
    var recordedAudioUrl: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var pitchPlayer: AVAudioPlayerNode!
    var audioPlayer = AVAudioPlayer()
     
    @IBOutlet weak var snailBtn: UIButton!
    @IBOutlet weak var rabbitBtn: UIButton!
    @IBOutlet weak var chipmunkBtn: UIButton!
    @IBOutlet weak var darthBtn: UIButton!
    @IBOutlet weak var reverbBtn: UIButton!
    @IBOutlet weak var echoBtn: UIButton!
    
    enum buttonType: Int {
        case slow = 0, fast , chipmunk , vader , echo , reverb
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
      
       audioPlayer = try! AVAudioPlayer(contentsOfURL: recordedAudio)
     
       audioPlayer.enableRate = true
       audioEngine = AVAudioEngine()
        do
        {
            audioFile = try AVAudioFile(forReading: recordedAudio)
  
        }        catch{
            print("error audio file")
        }
       
    }
    @IBAction func playSound(sender: AnyObject)
    {
        
      if let btnObj = buttonType(rawValue: sender.tag)
      {
        switch btnObj {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 2.0)
        case .chipmunk:
            playSound(pitch: 1000)
            
        case .vader:
            playSound(pitch: -1000)
        
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        }
        
    
    }
   
    func playSound(rate rate: Float? = nil,pitch: Float? = nil, echo: Bool = false, reverb: Bool = false)
    {
        
        stopAllAudio()
        audioEngine.reset()
        let pitchplayer = AVAudioPlayerNode()
        
        let timepitch = AVAudioUnitTimePitch()
        if let pitch = pitch
       {
        timepitch.pitch = pitch
        }
        if let rate = rate
        {
        timepitch.rate = rate
        }
        
        audioEngine.attachNode(pitchplayer)
        audioEngine.attachNode(timepitch)
        
        
        let echonode = AVAudioUnitDistortion()
        echonode.loadFactoryPreset(AVAudioUnitDistortionPreset.MultiEcho1)
        echonode.preGain = -2
        echonode.wetDryMix = 50
       
        audioEngine.attachNode(echonode)
        
        let revebnode = AVAudioUnitReverb()
        revebnode.loadFactoryPreset(.Cathedral)
        revebnode.wetDryMix = 67
        audioEngine.attachNode(revebnode)
        
        if echo
        {
            audioEngineConnect(pitchplayer, toNode: echonode)
    
        }
        if reverb
        {
          audioEngineConnect(pitchplayer, toNode: revebnode)
          
        }
        else{
            audioEngineConnect(pitchplayer, toNode: timepitch)
       
        }
        
       pitchplayer.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        if audioPlayer.playing
        {
            stopAllAudio()
        }
        pitchplayer.play()
        
    }
    
    @IBAction func stopBtnPressed(sender: AnyObject) {
        stopAllAudio()
    }
   
    func audioEngineConnect(fromNode: AVAudioNode, toNode: AVAudioNode)
    {
        
        audioEngine.connect(fromNode, to: toNode, format: nil)
        audioEngine.connect(toNode, to: audioEngine.outputNode, format: nil)
    }
    func stopAllAudio()
    {
        if audioPlayer.playing
        {
            audioPlayer.stop()
        }
        audioEngine.stop()

    }
    func playButton(rate: Float)
    {
        stopAllAudio()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }
}
