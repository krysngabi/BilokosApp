//
//  BilokosViewController.swift
//  BilokosCollector
//
//  Created by Krys Ngabi on 6/15/20.
//  Copyright © 2020 Krys Ngabi. All rights reserved.
//

import UIKit

class BilokosViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imgBilokos: UIImageView!
    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    var imagePicker = UIImagePickerController()
    
    var bilokos : TB_BILOKOS? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if bilokos != nil {
            imgBilokos.image = UIImage(data: (bilokos?.image!)!)
            txtTitle.text = bilokos!.title
            addUpdateButton.setTitle("Update", for: .normal)
            
        }else {
            deleteButton.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imgBilokos.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        txtTitle.text! =  ""
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        
        //present(imagePicker, animated: true, completion: nil)
        
        self .present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
        
        if (bilokos != nil){
            
            bilokos?.title = txtTitle.text
            bilokos!.image = imgBilokos.image!.pngData()
                   
        }else {
        let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let bilokos = TB_BILOKOS(context: context);
        bilokos.title = txtTitle.text
        bilokos.image = imgBilokos.image!.pngData()
        
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
        
      // let bilokos = TB_BILO
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
         let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(bilokos!)
       
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
}
