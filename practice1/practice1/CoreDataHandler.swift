//
//  CoreDataHandler.swift
//  practice1
//
//  Created by DCS on 23/02/22.
//  Copyright © 2022 DCS. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataHandler
{
    static let shared = CoreDataHandler()
    let appDel = UIApplication.shared.delegate as! AppDelegate
    let mngObj : NSManagedObjectContext?
    public init (){
        mngObj = appDel.persistentContainer.viewContext
    }
    
    func save(){
        appDel.saveContext()
    }
    func loginInsert(username:String, password:String)
    {
        let user = Login(context: mngObj!)
        user.username = username
        user.password = password
        save()
        
    }
    
    func chkLogin(username:String, password:String) -> Login
    {
        let fetchreq :  NSFetchRequest = Login.fetchRequest()
        let predict = NSPredicate(format: "username contains %@ AND password contains %@ ", username,password)
        fetchreq.predicate = predict
        do{
            let userarry = try (mngObj?.fetch(fetchreq))!
            if userarry.count == 1
            {
                return userarry[0]
            }
            else{
                return Login()
            }
        }catch
        {
            print("Error")
            return Login()
        }
    }
    func noteInsert(title:String, type:String)
    {
        let note = Notes(context: mngObj!)
        note.title = title
        note.type = type
        save()
    }
    func fetch()-> [Notes]
    {
        let fetchreq :  NSFetchRequest = Notes.fetchRequest()
        do{
            return try (mngObj?.fetch(fetchreq))!
        }catch
        {
            print("Error")
            return [Notes]()
        }
    }
    func updateNote(n:Notes,title:String, type:String )
    {
        n.title = title
        n.type = type
        save()
    }
    func deleteNote(n:Notes)
    {
        mngObj!.delete(n)
        save()
    }
}
