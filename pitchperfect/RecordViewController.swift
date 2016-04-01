//
//  ViewController.swift
//  pitchperfect
//
//  Created by kavita patel on 3/30/16.
//  Copyright © 2016 kavita patel. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var recordbtn: UIButton!
    
    var images = [UIImage]()
    var audioplayer = AVAudioRecorder()
    var recording: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view, typically from a nib.
        for i in 1...7
        {
            images.append(UIImage(named: "\(i)")!)
        }
        imgview.animationImages = images
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    override func viewWillAppear(animated: Bool) {
    
    }

    @IBAction func recordbtn_pressed(sender: AnyObject) {
        if recording
        {
            //start recording
            recording = false
            recordbtn.setTitle("START RECORDING", forState: .Normal)

        }
        else{
            // stop recording
            recording = true
            recordbtn.setTitle("STOP RECORDING", forState: .Normal)
               }
       
    }
}

