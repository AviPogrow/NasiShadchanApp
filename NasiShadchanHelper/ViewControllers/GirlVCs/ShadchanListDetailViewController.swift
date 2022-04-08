 //
 //  ShadchanListDetailViewController.swift
 //  NasiShadchanHelper
 //
 //  Created by user on 5/29/20.
 //  Copyright © 2020 user. All rights reserved.
 //
 
 import UIKit
 import Firebase
 
 
class ShadchanListDetailViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    

    @IBOutlet weak var lookingForTextView: UITextView!
    
    
    var ref: DatabaseReference!
    
    var selectedNasiGirl: NasiGirl!
    var descriptionArray: [String] = []
    
    
    @IBOutlet weak var girlProfileImageView: UIImageView!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
         super.viewDidLoad()
        self.navigationItem.title =
         selectedNasiGirl.nameSheIsCalledOrKnownBy + " " + selectedNasiGirl.lastNameOfGirl
        
        populateBioTextField()
        
        girlProfileImageView.translatesAutoresizingMaskIntoConstraints = false
        girlProfileImageView.layer.cornerRadius = 8
        girlProfileImageView.layer.masksToBounds = true
        girlProfileImageView.contentMode = .scaleAspectFit
        girlProfileImageView.isUserInteractionEnabled = true
        girlProfileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomTap)))
            
        loadProfilePhoto()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let likeDescription = selectedNasiGirl.briefDescriptionOfWhatGirlIsLike
        let lookingForDescription = selectedNasiGirl.briefDescriptionOfWhatGirlIsLookingFor
        let doingDescription = selectedNasiGirl.briefDescriptionOfWhatGirlIsDoing
        
        descriptionArray = [likeDescription,lookingForDescription,doingDescription]
        
        }
    
    func populateBioTextField() {
    
        let AgeString =  "\(selectedNasiGirl.age)"
        let heightString = "\(selectedNasiGirl.heightInFeet)" + "\'" + " " + "\(selectedNasiGirl.heightInInches)"  + "\""
        let cityString = "\(selectedNasiGirl.cityOfResidence)"
        let seminaryString = "\(selectedNasiGirl.seminaryName)"
        let familySituationString = "\(selectedNasiGirl.girlFamilySituation)"
        let familyBackGroundString = "\(selectedNasiGirl.girlFamilyBackground)"
        
        let planString = "\(selectedNasiGirl.plan)"
        
        
        let learningIsraelString = "\(selectedNasiGirl.livingInIsrael)"
        
        let attributedText = NSMutableAttributedString(string: "Age:  ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)])
        
        attributedText.append(NSAttributedString(string: AgeString, attributes: [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes:  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        
    
        attributedText.append(NSAttributedString(string: "Height:  ", attributes:  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: heightString, attributes: [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]))
        
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes:  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: "City:  ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: cityString, attributes: [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes:  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: "Seminary:  ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: seminaryString, attributes: [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]))
        
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes:  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: "Family Situation:  ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: familySituationString, attributes: [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes:  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: "Family Background:  ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: familyBackGroundString, attributes: [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes:  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: "Learning Plan:  ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: planString, attributes:  [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes:  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: "Learning Israel:  ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: learningIsraelString, attributes: [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes:  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        
        //label.attributedText = attributedText
        lookingForTextView.attributedText = attributedText
    }
   
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowResumeVC" {
            let controller = segue.destination as! ResumeViewController
            controller.selectedNasiGirl  = self.selectedNasiGirl
            
        }
        
        else if segue.identifier == "ShowViewResumeVC" {
        let controller = segue.destination as! ViewResumeVCViewController
           
            controller.selectedNasiGirl  = self.selectedNasiGirl
            
        }
        
        else if segue.identifier == "ShowContactsVC" {
        let controller = segue.destination as! ContactsViewController
           
            controller.selectedNasiGirl  = self.selectedNasiGirl
        }
        
        else if segue.identifier == "ShowNotesVC" {
        let controller = segue.destination as! ShadchanGirlNotesVC
           
            controller.selectedNasiGirl  = self.selectedNasiGirl
        }
        
    }
    
    func loadProfilePhoto(){
    girlProfileImageView.loadImageFromUrl(strUrl: selectedNasiGirl.imageDownloadURLString, imgPlaceHolder:"")
    }
    
    @objc func handleZoomTap(_ tapGesture: UITapGestureRecognizer) {
        if let imageView = tapGesture.view as? UIImageView {
            //PRO Tip: don't perform a lot of custom logic inside of a view class
            self.performZoomInForStartingImageView(imageView)
        }
    }
    
    
    var startingFrame: CGRect?
    var blackBackgroundView: UIView?
    var startingImageView: UIImageView?
    
    //my custom zooming logic
    func performZoomInForStartingImageView(_ startingImageView: UIImageView) {
        
        self.startingImageView = startingImageView
        self.startingImageView?.isHidden = true
        
        startingFrame = startingImageView.superview?.convert(startingImageView.frame, to: nil)
        
        let zoomingImageView = UIImageView(frame: startingFrame!)
        zoomingImageView.backgroundColor = UIColor.black
        zoomingImageView.image = startingImageView.image
        zoomingImageView.isUserInteractionEnabled = true
        zoomingImageView.contentMode = .scaleAspectFit
        zoomingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOut)))
        
        if let keyWindow = UIApplication.shared.keyWindow {
            blackBackgroundView = UIView(frame: keyWindow.frame)
            blackBackgroundView?.backgroundColor = UIColor.black
            blackBackgroundView?.alpha = 0
            keyWindow.addSubview(blackBackgroundView!)
            
            keyWindow.addSubview(zoomingImageView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackBackgroundView?.alpha = 1
                //self.inputContainerView.alpha = 0
                
                // math?
                // h2 / w1 = h1 / w1
                // h2 = h1 / w1 * w1
                let height = self.startingFrame!.height / self.startingFrame!.width * keyWindow.frame.width
                
                zoomingImageView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                
                zoomingImageView.center = keyWindow.center
                
                }, completion: { (completed) in
//                    do nothing
            })
            
        }
    }
    
    @objc func handleZoomOut(_ tapGesture: UITapGestureRecognizer) {
        if let zoomOutImageView = tapGesture.view {
            //need to animate back out to controller
            zoomOutImageView.layer.cornerRadius = 16
            zoomOutImageView.clipsToBounds = true
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                zoomOutImageView.frame = self.startingFrame!
                self.blackBackgroundView?.alpha = 0
               // self.inputContainerView.alpha = 1
                
                }, completion: { (completed) in
                    zoomOutImageView.removeFromSuperview()
                    self.startingImageView?.isHidden = false
            })
        }
    }


func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return descriptionArray.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   let cellID = "cellID"
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! DescriptionCollectionViewCell
    
    let whatsSheLike = "Whats she like?"
    let whatsShelookingFor = "Whats she looking for?"
    let whatsSheDoing = "Whats she currently doing?"
    
    cell.descriptionTextView.text = descriptionArray[indexPath.row]
    
    cell.layer.borderWidth = 0.25
    cell.layer.borderColor = UIColor.systemPink.cgColor
    return cell
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width =    (collectionView.frame.width - 20) //300
    return CGSize(width: width, height: width)
}
}
   
    
   
 /*
    func showActionSheet() {
        let alert = UIAlertController(title: "Nasi", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Would you like to save to my projects", style: .default , handler:{ (UIAlertAction)in
            //self.saveToResearch()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
  */


    //TODO: Initialize Data
    private func setUpProfilePhoto() {
    }
    
    
    /*
    @objc func doneButtonClicked(_ sender: Any) {
        
         
        
        //if notesTextView.text.isEmpty {
         //   self.showAlert(title: Constant.ValidationMessages.oopsTitle, msg: Constant.ValidationMessages.msgNotesEmpty)
         //   }
            
         //else {
            
        
            self.view.showLoadingIndicator()
            // make sure you have userID, girlsID, and text for note
            
            let myId = UserInfo.curentUser?.id
        
            // get the UUID for the current Girl
            // by her key property
            let selectedSingle = selectedNasiGirl
            
            let gId = selectedSingle!.key
            //let note = notesTextView.text
                
            // dictionary for note
            let dict = ["note":note]
            
            ref = Database.database().reference()
            
        // go to notes list - then to current user - then to current
        // girl's UUID
        // set girls UUID as the node and set dictionary of notes under
        ref.child("favUserNotes").child(myId!).child(gId).setValue(dict) {
                
                (error, dbRef) in
                
                if error != nil {
                    print( error?.localizedDescription ?? "")
                    
                    self.view.hideLoadingIndicator()
                
                } else {
                    
                    //print("success")
                    //print(dbRef.key ?? "dbKey")
                    
                    self.view.hideLoadingIndicator()
                    //self.saveProfileToResearchList()
                    
                }
            }
        }
        
    */
    /*
    func getFavUserNote() {
    
      let myId = UserInfo.curentUser?.id
        let selectedSingle = selectedNasiGirl
        
        
        //print("the state of selectedNasiGirl is \(selectedNasiGirl.debugDescription)\(selectedNasiGirl.briefDescriptionOfWhatGirlIsLike)and her key is\(selectedNasiGirl.key)and ref is\(selectedNasiGirl.ref)")
        
        let gID = selectedSingle!.key
        
      //let gID = selectedNasiGirl.key
          
        ref = Database.database().reference()
        
        // go to the list of user notes
        // 1. go to user id
        // go to girl id
        // get all the
        ref.child("favUserNotes").child(myId!).child(gID).observe(.childAdded) { (snapShot) in
            if let noteStr = snapShot.value as? String {
                //print("notes txt :- \(noteStr)")
                self.notesTextView.text = noteStr
               // self.isAlreadyAddedNotes = true
                
            }else{
                
                print("invalid data")
            }
            print("user notes :-")
        }
    }
    
   */
    
    
    
   /*
    
    // MARK: - Navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
         
       }
 */
    
    /*
    @IBAction func remveAction(_ sender: Any) {
        print("removed")
        var message = ""

        if tableName == "research" {
                     message =  Constant.ValidationMessages.msgConfirmationToDelete
                 }else {
                     message =  Constant.ValidationMessages.msgConfirmationToDeleteSent

                 }
        
        let alertControler = UIAlertController.init(title:"", message: message, preferredStyle:.alert)
        alertControler.addAction(UIAlertAction.init(title:"Yes", style:.default, handler: { (action) in
            print("yes")
            self.removeFromProject()
        }))
                
        alertControler.addAction(UIAlertAction.init(title:"No", style:.destructive, handler: { (action) in
                     print("no")
               
        }))
                
        self.present(alertControler,animated:true, completion:nil)
        
    }
    */
  
    /*
    fileprivate func removeFromProject() {
        
       // print("here is my child key", strChildKey!)
       // print("here is custom child key", childKey)

        
        ref = Database.database().reference()
        let myId = UserInfo.curentUser?.id
        
        ref.child(tableName).child(myId!).child(childKey).removeValue { (error, dbRef) in // childKey
            self.view.hideLoadingIndicator()
            if error != nil{
                print(error?.localizedDescription)
            } else {
                print(dbRef.key)
               if self.tableName == "research" {
                
                    NotificationCenter.default.post(name: Constant.EventNotifications.notifRemoveFromFav, object: ["updateStatus":"researchList"])
                self.showAlert(title: Constant.ValidationMessages.successTitle, msg: Constant.ValidationMessages.msgSuccessToDelete) {
                                   self.navigationController?.popViewController(animated: true)
                               }
                } else {
                
                    NotificationCenter.default.post(name: Constant.EventNotifications.notifRemoveFromFav, object: ["updateStatus":"sentList"])
                self.showAlert(title: Constant.ValidationMessages.successTitle, msg: Constant.ValidationMessages.msgSuccessToDeleteFromSent) {
                                   self.navigationController?.popViewController(animated: true)
                               }
                }
            }
        }
    }
  */
    
    


 
 /*
 extension ShadchanListDetailViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("the selected indexpath is \(indexPath)")
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 2 && indexPath.row == 3 {
        Utility.makeACall(selectedNasiGirl.girlsCellNumber)
        }
    
        if indexPath.section == 4 && indexPath.row == 2 {
        Utility.makeACall(selectedNasiGirl.cellNumberOfContactToReddShidduch)
     }
        
    if indexPath.section == 4 && indexPath.row == 3 {
        if MFMailComposeViewController.canSendMail() {
        sendEmail(selectedNasiGirl.emailOfContactToReddShidduch)
        }
    }
            //        } else {
                //        self.showAlert(title: Constant.ValidationMessages.oopsTitle, msg: Constant.ValidationMessages.mailUnableToSend) {
                   //     }
                 //   }
                
           //}
  if indexPath.section == 5 && indexPath.row == 2 {
    Utility.makeACall(selectedNasiGirl.cellNumberOfContactWhoKNowsGirl)
    
    
    
   }
    if indexPath.section == 5 && indexPath.row == 3 {
                
    if MFMailComposeViewController.canSendMail() {
        sendEmail(selectedNasiGirl.emailOfContactWhoKnowsGirl)
        }
        }
    
      // else {
       //     self.showAlert(title: Constant.ValidationMessages.oopsTitle, msg: Constant.ValidationMessages.mailUnableToSend) {
                }}
                    
                
           // }
       // }
   // }
    
    
*/
    
    
/*
 extension ShadchanListDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
        if let theImage = image {
            show(image: theImage)
            
            self.uploadImage(theImage)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func takePhotoWithCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.cameraDevice = .front
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            self.showAlert(title: "Warning", msg: "You don't have camera", onDismiss: {
            })
        }

         let imagePicker = UIImagePickerController()
         imagePicker.sourceType = .camera
         imagePicker.delegate = self
         imagePicker.allowsEditing = true
         present(imagePicker, animated: true, completion: nil)
         
    }
    */
 
 
        
    /*
    func choosePhotoFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func pickPhoto() {
        if true || UIImagePickerController.isSourceTypeAvailable(.camera) {
            showPhotoMenu()
        } else {
            choosePhotoFromLibrary()
        }
    }
    
    func showPhotoMenu() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let actCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actCancel)
        
        let actPhoto = UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.takePhotoWithCamera()
        })
        alert.addAction(actPhoto)
        
        let actLibrary = UIAlertAction(title: "Choose From Library", style: .default, handler: { _ in
            self.choosePhotoFromLibrary()
        })
        alert.addAction(actLibrary)
        
        present(alert, animated: true, completion: nil)
    }
    
    func uploadImage(_ img : UIImage) {
        uploadMedia(img) { (imgUrl) in
            
            let myId = UserInfo.curentUser?.id
            let gId = self.selectedSingle.key
            let iUrl = imgUrl
             
            let dict = ["imgUrl":iUrl]
            self.ref = Database.database().reference()
            self.ref.child("favUserPhotos").child(myId!).child(gId).setValue(dict) { (error, dbRef) in
                if error != nil {
                    print( error?.localizedDescription ?? "")
                }else{
                    print("success")
                    print(dbRef.key ?? "dbKey")
                }
            }
        }
    }
    
    func uploadMedia(_ image : UIImage, completion: @escaping (_ url: String?) -> Void) {
        let storageRef = Storage.storage().reference()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        let str = df.string(from: Date())
        let riversRef = storageRef.child("images/Image_\(str).jpg")
        guard let uploadData = image.jpegData(compressionQuality: 0.25) else{
            print("image can’t be converted to data")
            return
        }
        self.view.showLoadingIndicator()
        let uploadTask = riversRef.putData(uploadData, metadata: nil) { (metadata, error) in
            self.view.hideLoadingIndicator()
            guard metadata != nil else {
                // Uh-oh, an error occurred!
                print(error?.localizedDescription ?? "")
                return
            }
            riversRef.downloadURL { (url, error) in
                guard let downloadURL = url else { return }
                print("d1-\(downloadURL)")
                completion("\(downloadURL)")
            }
        }
        _ = uploadTask.observe(.progress) { snapshot in
            // A progress event occurred
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                / Double(snapshot.progress!.totalUnitCount)
            print("progress- \(percentComplete)")
        }
    }
 }
 

 
 
 // MARK:- MFMailCompose ViewController Delegate
 extension ShadchanListDetailViewController : MFMailComposeViewControllerDelegate {
    
    // MARK: Open MailComposer
    func sendEmail(_ emailRecipients:String) {
        let vcMailCompose = MFMailComposeViewController()
        vcMailCompose.mailComposeDelegate = self
        vcMailCompose.setToRecipients([emailRecipients])
        let subject =  "\("Resume")" + " "  + "\(selectedNasiGirl.firstNameOfGirl )" + " "  + "\(selectedNasiGirl.lastNameOfGirl )" //top 1 name
        vcMailCompose.setSubject(subject)
        let strMailBody = "Please type your question here:\n\n\n"
        vcMailCompose.setMessageBody(strMailBody, isHTML: false)
        self.present(vcMailCompose, animated: true) {}
    }
    
    // MARK: MailComposer Delegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true) {
            switch result {
            case .sent:
                self.showAlert(title: Constant.ValidationMessages.successTitle, msg:Constant.ValidationMessages.mailSentSuccessfully, onDismiss: {})
            case .saved:
                self.showAlert(title: Constant.ValidationMessages.successTitle, msg:Constant.ValidationMessages.mailSavedSuccessfully, onDismiss: {})
            case .failed:
                self.showAlert(title: Constant.ValidationMessages.oopsTitle, msg:Constant.ValidationMessages.mailFailed, onDismiss: {})
            default: break
            }
        }
    }
 }
*/
 
    
