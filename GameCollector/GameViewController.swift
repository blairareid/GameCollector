//
//  GameViewController.swift
//  GameCollector
//
//  Created by Blair Reid on 2017-01-09.
//  Copyright © 2017 Blair Reid. All rights reserved.
//

import UIKit

class GameViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {


    @IBOutlet weak var gameImageview: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
   var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        // Pull the image from the imagepickercontroller ditctionary
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Assign the image to the control on the screen
        gameImageview.image = image
        
        // Get rid of the imagepicket controller
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func photosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }

    @IBAction func cameraTapped(_ sender: Any) {
    }
   
    @IBAction func addTapped(_ sender: Any) {
       
        // Get context to store
        let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
        let game = Game(context: context)
      
        game.title = titleTextField.text
        game.image = UIImagePNGRepresentation(gameImageview.image!) as NSData!  //  NSdata coersion required before PNG is data not NSData
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
           }
}
