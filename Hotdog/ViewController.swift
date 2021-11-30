//
//  ViewController.swift
//  Hotdog
//
//  Created by Yu Jin on 11/29/21.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Delegation design pattern -> Text field: Properties
        
    // Steps to implement a delegate:
    // 1. Create an object
    
    let imagePicker = UIImagePickerController()
    let results : [VNClassificationObservation] = []
    
    
    

    //2. Initialize the delegate in View Did Load
    //3. Implement its functions
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        imagePicker.sourceType = .camera
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    }
    func detect(){
        
    }
}

