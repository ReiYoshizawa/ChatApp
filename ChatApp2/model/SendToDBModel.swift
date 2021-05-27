//
//  SendToDBModel.swift
//  ChatApp2
//
//  Created by ヨシザワレイ on 2021/05/19.
//

import Foundation
import FirebaseStorage

protocol SendProfileOKDelegate {

    func sendProfileOKDelegate(url:String)
    
    
}


class SendToDBModel {
    
    
    var sendProfileOKDelegate:SendProfileOKDelegate?
    
    init(){
        
    }
    
    func sendProfileImageDate(date:Data){
        
        let image = UIImage(data: date)
        let profileImageData = image?.jpegData(compressionQuality: 0.1)
        
        let imageRef = Storage.storage().reference().child("profileImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        
        imageRef.putData(profileImageData!, metadata: nil) { (metaDeta, error) in
            
            if error != nil{
                
                print(error.debugDescription)
                return
            }
            
            imageRef.downloadURL { (url, error) in
                
                if error != nil{
                    
                    print(error.debugDescription)
                    return
                    
                }
                
                UserDefaults.standard.setValue(url?.absoluteString, forKey: "userImage")
                
                self.sendProfileOKDelegate?.sendProfileOKDelegate(url: url!.absoluteString)
                
            }
            
            
        }
        
        
        
        
    }
}
