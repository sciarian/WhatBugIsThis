//
//  BugCatcherViewController.swift
//  WhatBugIsThis
//
//  Created by user144818 on 12/2/18.
//  Copyright © 2018 user144818. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseStorage

//PROTOCOL
protocol BugCatcherDelegate {
    func getEntries(entries: [Catch])
}

class BugCatcherViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //BUTTON
    @IBOutlet weak var cameraButton: UIButton!
    
    //IMAGE VIEW
    @IBOutlet weak var lastPic: UIImageView!
    
    //LABELS
    @IBOutlet weak var lastPicLabel: UILabel!
    
    //TEXTFIELDS
    @IBOutlet weak var catchDescriptionField: UITextField!
    
    //ENTRIES FOR LIST
    var entries:[Catch] = []
    
    //DELEGATE
    var delegate: MainMenuViewController?
    
    //FIREBASE
    fileprivate var refDB  : DatabaseReference?     //Reference to firebase database
    fileprivate var refSTR : Storage?      //Reference to firebase file storage
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //DESELECT KEYBOARD WHEN TOUCHING OUTSIDE IT
        let detectTouch = UITapGestureRecognizer(target:self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(detectTouch)

        //SET UP FIRE BASE REFERENCE
        self.refDB  = Database.database().reference()
        self.refSTR = Storage.storage()
        //self.refSTR = Storage.storage()
        
        //SET UP FIREBASE FILE STORAGE REFERENCE
        
        //self.registerForFireBaseUpdates()             //Commented out to we do not double update the database
        
       // print("\n\nImage Description: \(String(describing: self.lastPic.image?))\n\n")
        //print("\n\nImage Description: \(String(describing: self.lastPic.image?.description))\n\n")
        
    }
    
/*
    fileprivate func registerForFireBaseUpdates()
    {
        self.ref!.child("history").observe(.value, with: { snapshot in
            if let postDict = snapshot.value as? [String : AnyObject] {
                var tmpItems = [Catch]()
                for (_,val) in postDict.enumerated() {
                    let entry       = val.1 as! Dictionary<String,AnyObject>
                    let pic         = entry["pic"] as! UIImage?
                    let timestamp   = entry["timestamp"] as! String?
                    let description = entry["description"] as! String?
                    tmpItems.append(Catch(pic: pic, timestamp: timestamp!.description, description: description!))
                }
                self.entries = tmpItems
            }
        })
    }
*/

    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("Entered view will disappear")
        //super.viewWillDisappear(true)
        if let d = self.delegate{
            print("\nAdding entries to main view controller\n")
            d.getEntries(entries: self.entries)
        }else{
            print("delegate nil")
        }
    }
    
//BUTTON ACTION FUNCTIONS
/*
     
     //DISPLAY PHOTOLIB
    @IBAction func pressedBugCollectionButton(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
*/
 
    //Add most recent picture to the collection
    @IBAction func pressedSaveCatch(_ sender: UIButton) {
        
        //SAVE HISTORY TO FIRBASE
        
        //Print program
        print("\npicture description: \(self.lastPic.description)\n")
        print("\nDate: \(Date().description)\n")
        print("\n\(self.catchDescriptionField.text!)\n")
        var timeStamp:String = Date().description   //Get time stamp
        
        
        //FIREBASE STORAGE (Referenced firebase API)
        /**
        //Make image ref to download the image
        var imageRefStr:String = "images\(timeStamp).jpg"
        var imageRef = self.refSTR?.reference().child(imageRefStr)
        var data = UIImageJPEGRepresentation(self.lastPic.image!, 1.0)
        
        //Upload the image data
        let uploadTask = imageRef!.putData(data!, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
        }
        
        //var downloadURL:URL = nil
        
        var picURL:URL?
        imageRef!.downloadURL { (url, error) in
            guard let downloadURL = url else {
                // Uh-oh, an error occurred!
                return
            }
            picURL = downloadURL
       }
        
        //MAKE A CATCH STRUCT WITH THE CURRENT BUG PICTURE, TIMESTAMP, AND DESCRIPTION
        var urlString:String = ""
        do{
            let urlstr = try String(contentsOf: picURL!)
            urlString = urlstr
        }catch{
            print("Error converting catch entry to list")
        }
 */
        let entry = Catch(picURLStr: "", timestamp: Date().description, description:self.catchDescriptionField.text!)
        let newChild = self.refDB?.child("history").childByAutoId()
         //SEND CATCH STRUCT TO HELPER FUNCTION TO CONVERT IT TO A DICTIONARY
         newChild?.setValue(self.toDictionary(c: entry))
 
        //OLD METHOD WITH ARRAY. NON PERSISTANT DATA
        //print("\nSaved Entrie\n")
        //entries.append(Catch(picRef: downloadURL, timestamp: timeStamp, description: self.catchDescriptionField.text!))
        //print("Total number of entries \(self.entries.count)")
    }
    
    
    //FIREBASE DICTIONAIRY IMPLEMENTATION
    func toDictionary(c: Catch) -> NSDictionary {
        //HERE WE TAKE THE CATCH STRUCT AND CONVERT IT A DICTIONARY SO WE CAN SEND IT TO THE DATABASE AS A JSON OBJECT
            return [
                "timestamp"   : NSString(string: c.timestamp!),
                "picURL"      : NSString(string: c.picURLStr!),
                "description" : NSString(string: c.description!),
            ]
    }
    
    @IBAction func pressedCameraButton(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate   = self
        picker.sourceType = .camera
        present(picker,animated: true,completion: nil)
    }
    
    //Save last picture to the image view in the view controller
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.lastPic.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
