//
//  BugCatcherViewController.swift
//  WhatBugIsThis
//
//  Created by user144818 on 12/2/18.
//  Copyright © 2018 user144818. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//BUTTON ACTION FUNCTIONS
/*
    @IBAction func pressedBugCollectionButton(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
*/
 
    //Add most recent picture to the collection
    @IBAction func pressedSaveCatch(_ sender: UIButton) {
        entries.append(Catch(image: self.lastPic.image!, date: Date(), description: self.catchDescriptionField.text!))
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
