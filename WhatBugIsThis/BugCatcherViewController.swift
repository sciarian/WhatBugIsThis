//
//  BugCatcherViewController.swift
//  WhatBugIsThis
//
//  Created by user144818 on 12/2/18.
//  Copyright © 2018 user144818. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //DESELECT KEYBOARD WHEN TOUCHING OUTSIDE IT
        let detectTouch = UITapGestureRecognizer(target:self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(detectTouch)

    }

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
            print("delegate is fucked mate")
        }
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
        print("\nSaved Entrie\n")
        entries.append(Catch(image: self.lastPic.image!, date: Date(), description: self.catchDescriptionField.text!))
        print("Total number of entries \(self.entries.count)")
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
