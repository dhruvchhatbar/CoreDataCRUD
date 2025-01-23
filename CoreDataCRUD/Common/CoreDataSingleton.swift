//
//  CoreDataSingleton.swift
//  CoreDataCRUD
//
//  Created by Dhruv Chhatbar on 13/01/24.
//

import Foundation
import CoreData
import UIKit


class CoreDataSingleton{
    static let shared = CoreDataSingleton()
    
    func createCoreData(username: String,password: String,email: String, completion: () -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        // creating a reference of dataModel using persistance controller
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // creating a reference of our entity to store new data
        let userEntity = NSEntityDescription.entity(forEntityName: StringConstants.entityName, in: managedContext)!
        
        // creating this loop to add list of data
        
            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            user.setValue(username, forKey: StringConstants.userName)
            user.setValue(password, forKey: StringConstants.password)
            user.setValue(email, forKey: StringConstants.emailId)
        do{
            try managedContext.save()
            completion()
            print("saved")
        }
        catch let error as NSError{
            print("could not save \(error), \(error.userInfo)")
        }
    }
    func fetchUserData(userEmail: String, completion: ([DataModel]) -> Void){
        var arrData = [DataModel]()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        // creating a reference of dataModel using persistance controller
        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: StringConstants.entityName)
        do{
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject]{
                arrData.append(DataModel(userName: (data.value(forKey: StringConstants.userName) as? String ?? "username"), password: (data.value(forKey: StringConstants.password) as? String ?? "password"), emailId: (data.value(forKey: StringConstants.emailId) as? String ?? "email")))
                print(data.value(forKey: StringConstants.userName) as? String ?? "username")
            }
            completion(arrData)
        }catch{
            print("Failed to fetch")
        }
    }
    func updateUserData(username: String,password: String,email: String, updatingEmail: String, completion: ()->Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        // creating a reference of dataModel using persistance controller
        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: StringConstants.entityName)
        fetchRequest.predicate = NSPredicate(format: "\(StringConstants.userName) = %@",updatingEmail)
        do{
            let test = try managedContext.fetch(fetchRequest)
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(username, forKey: StringConstants.userName)
            objectUpdate.setValue(password, forKey: StringConstants.password)
            objectUpdate.setValue(email, forKey: StringConstants.emailId)
            do{
                try managedContext.save()
                completion()
            }
            catch{
                print(error)
            }
        }catch{
            print(error)
        }
    }
    func deleteUserData(username: String, completion: () -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        // creating a reference of dataModel using persistance controller
        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: StringConstants.entityName)
        fetchRequest.predicate = NSPredicate(format: "\(StringConstants.userName) = %@",username)
        do{
            let test = try managedContext.fetch(fetchRequest)
            let objToDelete = test[0] as! NSManagedObject
            managedContext.delete(objToDelete)
            do{
                try managedContext.save()
                completion()
            }
            catch{
                print(error)
            }
        }
        catch{
            print(error)
        }
    }

    
}
