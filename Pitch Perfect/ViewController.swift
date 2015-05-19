//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Jami Couch on 5/19/15.
//  Copyright (c) 2015 Jami Couch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        //TODO: Record user voice
        println("recordAudio")
        recordingInProgress.hidden = false
        stopButton.hidden = false
        recordButton.hidden = true
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        //TODO: Stop recording
        println("stopRecording")
        stopButton.hidden = true
        recordingInProgress.hidden = true
        recordButton.hidden = false
    }
}

