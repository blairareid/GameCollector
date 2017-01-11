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
    @IBOutlet weak var addupdateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
// Property to know if it is an update or add
    var game : Game? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        
        if game != nil {
            gameImageview.image = UIImage(data: game!.image as! Data) //Need to covert to image as stored as binary data
            titleTextField.text = game!.title
            addupdateButton.setTitle("Update", for: .normal) // Change text so screen is reused
            
        }else{
            deleteButton.isHidden = true        // Hide the delete button
        }
    
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
        
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)

        
    }
   
    @IBAction func addTapped(_ sender: Any) {
      
        if game != nil {

            // No need to get context as I have a object and update object
            game!.title = titleTextField.text
            game!.image = UIImagePNGRepresentation(gameImageview.image!) as NSData!  //  NSdata coersion required before PNG is data not NSData
        }else{
        
            // should validate if field is empty
            if titleTextField.text == "" {
                
                //It takes the title and the alert message and prefferred style
                let alertController = UIAlertController(title: "Validation", message: "Please Enter Game Title", preferredStyle: .alert)
                
                //then we create a default action for the alert...
                //It is actually a button and we have given the button text style and handler
                //currently handler is nil as we are not specifying any handler
                let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
                
                //now we are adding the default action to our alertcontroller
                alertController.addAction(defaultAction)
                
                //and finally presenting our alert using this method
                self.present(alertController, animated: true, completion: nil)
                
            } else {
            
                // Get context to store
                let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
                let game = Game(context: context)
      
                game.title = titleTextField.text
 
                game.image = UIImagePNGRepresentation(gameImageview.image!) as NSData!  //  NSdata coersion required before PNG is data not NSData
            }

        }
 
        
        // Save the data to the context store
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // Exit this screen and pop the the screen that called us
        navigationController!.popViewController(animated: true)
        
           }
    
    
    @IBAction func deleteTapped(_ sender: Any) {
        // Get context to store
        let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
        context.delete(game!)
  
        // Save the data to the context store
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // Exit this screen and pop the the screen that called us
        navigationController!.popViewController(animated: true)

        
    }
    
    
    
}
