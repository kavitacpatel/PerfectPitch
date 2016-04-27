//
//  ViewController.swift
//  pitchperfect
//
//  Created by kavita patel on 3/30/16.
//  Copyright © 2016 kavita patel. All rights reserved.
//

import UIKit
import AVFoundation

class recordViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var recordBtn: UIButton!
       var images = [UIImage]()
   
    var audioRecorder: AVAudioRecorder!
   
    var recordingSession: AVAudioSession!
    var recording: Bool = true
    var stopRecording:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        for i in 1...12
        {
            images.append(UIImage(named: "\(i)")!)
        }
        imgView.animationImages = images
        
    }

    override func viewWillAppear(animated: Bool) {
        
        recordBtn.setTitle("START RECORDING", forState: .Normal)
        
        stopRecording = false
        
    }
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       if(stopRecording)
       {
        stopRecording = false
        if let stoppedRecord = segue.destinationViewController as? playViewController {
           let recordedAudioUrl = sender as! NSURL
            stoppedRecord.recordedAudio = recordedAudioUrl
        }
        
       }
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag
        {
        self.performSegueWithIdentifier("stoppedRecording", sender: audioRecorder.url)
            doAnimation(false)
        }
        else
        {
            print("saving of recording failed")
        }
    }
    
    func doAnimation(animation: Bool)
    {
        if animation
        {
            imgView.animationDuration = 2
            imgView.startAnimating()
        }
        else
        {
            imgView.stopAnimating()
        }
    }
    
    @IBAction func recordBtn_Pressed(sender: AnyObject) {
       
       
        
        if recording
            {
                // start recording
                doAnimation(true)
                recording = false
                
                recordBtn.setTitle("STOP RECORDING", forState: .Normal)
                startRecording()
                
            }
            else{
            audioRecorder.stop()
            
            //stop recording
            recording = true
            recordBtn.setTitle("START RECORDING", forState: .Normal)
            stopRecording = true
            
            
            }
        }
   
   
    func startRecording() -> Bool
    {
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000.0,
            AVNumberOfChannelsKey: 1 as NSNumber,
            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
        ]

        
         recordingSession = AVAudioSession.sharedInstance()
        do
        {
            let documents: AnyObject = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory,  NSSearchPathDomainMask.UserDomainMask, true)[0]
            let str =  documents.stringByAppendingPathComponent("recordTest.m4a")
            let url = NSURL.fileURLWithPath(str as String)

        audioRecorder = try AVAudioRecorder(URL: url,settings: settings)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        
        audioRecorder.record()
           return true
        }
        catch{
           return false
        }
}
  }


