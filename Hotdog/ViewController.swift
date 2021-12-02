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
        imagePicker.allowsEditing = false
        
        present(imagePicker,animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 1. Select the image
        if let image = info[.originalImage]as? UIImage{
            
            //Display selected image
            imageView.image = image
            
            //Dismiss imagePicker after capturing the image
            imagePicker.dismiss(animated: true, completion: nil)
            
        // 2. Convert this image from UIImage data type into CIImage
            guard let ciImage = CIImage(image: image) else {return}
            
        // 3. Detect (CIImage)
            detect(image : ciImage)
        }
    }
    
    // Detect function:
        // 1. Model
        // 2. Request
        // 3. Result
        // 4. Handler
    func detect(image : CIImage){
        // initialize model
        if let model = try? VNCoreMLModel(for: Inceptionv3_().model){
           
            
            let request = VNCoreMLRequest(model: model, completionHandler: { (request, error) in
                
                
                guard let results = request.results as? [VNClassificationObservation], let
                        topResult = results.first else{return}
                
                if topResult.identifier.contains("hotdog"){
                    DispatchQueue.main.async {
                        self.navigationItem.title = "Hotdog"
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self.navigationItem.title = "Not Hotdog"
                        
                    }
                }
                
            })
        
        
        let handler = VNImageRequestHandler(ciImage : image)
                    do {
                        try handler.perform([request])
                    }
                    
                    catch {
                        
                        print(error)
                    }
}


}
}
