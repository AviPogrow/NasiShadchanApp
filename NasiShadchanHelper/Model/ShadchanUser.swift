//
//  ShadchanUser.swift
//  NasiShadchanHelper
//
//  Created by test on 4/9/22.
//  Copyright © 2022 user. All rights reserved.
//


import Foundation
import Firebase

class ShadchanUser: NSObject {
    
    var  ref: DatabaseReference?
    var  key: String = ""
    
    var shadchanEmail = ""
    var shadchanUserID = ""
    var shadchanLastName = ""
    var shadchanFirstName = ""
    var shadchanTitle = ""
    var shadchanProfileImageURLString = ""
    var shadchanCell = ""
    var yearsAsShadchan = ""
    var about = ""
    
    
    
    var familyTypes: [String] = []
    var singlesPlan: [String] = []
    var singlesType: [String] = []
    
    // initialize from a firebase snapshot coming down into app
    init(snapshot: DataSnapshot) {
    //let value = snapshot.value as! [String: AnyObject]
    guard  let value = snapshot.value! as? [String: AnyObject] else { return }
        
        // FB snapshot has a ref and key property
        self.ref = snapshot.ref
        self.key = snapshot.key
        
        let shadchanEmail = value["shadchanEmail"]  as? String
        let shadchanUserID = value["shadchanUserID"]  as? String
        let shadchanLastName = value["shadchanLastName"]  as? String
        let shadchanFirstName = value["shadchanFirstName"]  as? String
        let shadchanTitle = value["shadchanTitle"]  as? String
        let shadchanProfileImageURLString = value["shadchanProfileImageURLString"]  as? String
        
        let shadchanCell = value["shadchanCell"]  as? String
        let yearsAsShadchan = value["yearsAsShadchan"]  as? String
        let about = value["about"]  as? String
        let familyTypes = value["familyTypes"] as? [String]
        
        
        self.shadchanEmail = shadchanEmail ?? ""
        self.shadchanFirstName = shadchanFirstName ?? ""
        self.shadchanLastName = shadchanLastName ?? ""
        self.shadchanUserID = shadchanUserID ?? ""
        
        self.shadchanTitle = shadchanTitle ?? ""
        self.shadchanProfileImageURLString = shadchanProfileImageURLString ?? ""
        
        self.shadchanCell = shadchanCell ?? ""
        self.yearsAsShadchan = yearsAsShadchan ?? ""
        self.about = about ?? ""
        
        self.familyTypes = familyTypes ?? [String]()
        self.singlesPlan = singlesPlan ?? [String]()
        self.singlesType =  singlesType ?? [String]()
        
    }
        
        // MARK: Initialize with user input data to send up
        // to firebase
    init(shadchanEmail: String, shadchanFirstName: String, shadchanLastName: String, shadchanUserID: String,shadchanCell: String, shadchanTitle: String, shadchanProfileImageURLString: String, yearsAsShadchan: String,about: String,familyTypes:[String],singlesPlan:[String],singlesType:[String], key: String = "") {
            
          self.ref = nil
          self.key = key
          self.shadchanEmail = shadchanEmail
          self.shadchanFirstName = shadchanFirstName
          self.shadchanLastName = shadchanLastName
         self.shadchanCell = shadchanCell
            
          self.shadchanUserID = shadchanUserID
          self.shadchanTitle = shadchanTitle
          self.shadchanProfileImageURLString = shadchanProfileImageURLString
        
          self.yearsAsShadchan = yearsAsShadchan
          self.about = about
            
        self.familyTypes = familyTypes
        self.singlesPlan = singlesPlan
        self.singlesType =  singlesType
        
        }
    
    // MARK: Convert GroceryItem to AnyObject
    func toAnyObject() -> Any {
      return [
        "shadchanEmail": shadchanEmail,
        "shadchanFirstName": shadchanFirstName,
        "shadchanLastName": shadchanLastName,
        "shadchanCell": shadchanCell,
        "shadchanUserID" : shadchanUserID,
        "shadchanTitle": shadchanTitle,
        "shadchanProfileImageURLString": shadchanProfileImageURLString,
        "yearsAsShadchan": yearsAsShadchan,
        "about": about,
        "familyTypes": familyTypes,
        "singlesPlan": singlesPlan,
        "singlesType": singlesType
        
      ]
    }
    
    func createNewShadchanUserInFirebase(){
        
        let userID = Auth.auth().currentUser?.uid ?? ""
        let email = Auth.auth().currentUser?.email
        
        let shadchanEmail = email
        let shadchanFirstName = "Avi"
        let shadchanLastName = "Pogrow"
        let shadchanUserID = userID
        let shadchanTitle = "Rabbi"
        let shadchanProfileImageURLString = ""
        let yearsAsShadchan = "10"
        let about = "Best in the world"
        let familyTypes: [String] = ["","",""]
        let singlesPlan: [String] = ["","",""]
        let singlesType: [String] = ["","",""]
        
        let newUser = ShadchanUser(shadchanEmail: shadchanEmail!, shadchanFirstName: shadchanFirstName, shadchanLastName: shadchanLastName, shadchanUserID: shadchanUserID, shadchanCell: shadchanCell, shadchanTitle: shadchanTitle, shadchanProfileImageURLString: shadchanProfileImageURLString, yearsAsShadchan: yearsAsShadchan, about: about, familyTypes: familyTypes, singlesPlan: singlesPlan, singlesType: singlesType)
        
        let shadchanUserNodeRef = Database.database().reference(withPath: "NasiShadchanUserList")
        
        let shadchanChildRef = shadchanUserNodeRef.child(shadchanUserID)
        
        shadchanChildRef.setValue(newUser.toAnyObject())
        
    }
    }
        
        
    
        
    

