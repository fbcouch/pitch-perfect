//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jami Couch on 5/19/15.
//  Copyright (c) 2015 Jami Couch. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {
    
    var audioRecorder:AVAudioRecorder!
    
    var recordedAudio:RecordedAudio!
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        // called after viewDidLoad, before viewDidAppear
        // ensure initial state
        stopButton.hidden = true
        recordButton.enabled = true
        recordingInProgress.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        // called after view appears
    }
    
    override func viewWillDisappear(animated: Bool) {
        //
    }
    
    override func viewDidDisappear(animated: Bool) {
        //
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsViewCtrl:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            playSoundsViewCtrl.receivedAudio = sender as! RecordedAudio
            
        }
    }

    @IBAction func recordAudio(sender: UIButton) {
        //TODO: Record user voice
        println("recordAudio")
        recordingInProgress.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        //TODO: Stop recording
        println("stopRecording")
        stopButton.hidden = true
        recordingInProgress.hidden = true
        recordButton.enabled = true
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}

extension RecordSoundsViewController : AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if flag {
            recordedAudio = RecordedAudio()
            recordedAudio.filePathUrl = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent
            
            performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
    }
}

