//
//  PersistenceManager.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 6/22/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//

import UIKit
import CoreData

final class PersistenceManager {
    
    private init(){}
    static let shared = PersistenceManager()
    
    var photo = [Photo]()
    
    // MARK: - Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataManager")
        container.loadPersistentStores(
            completionHandler: {(storeDescription, error) in
                print(storeDescription)
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }})
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    
    // MARK: - Core Data Saving Support
    func save() {
        if context.hasChanges {
            do {
                try context.save()
                print("Saved Successfully")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    // MARK: - Methods
    
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        save()
    }
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        }
        catch {
            print(error)
            return []
        }
    }
    
    func saveData(imageView: UIImageView, textView: UITextView, locationLabel: UILabel) {
        let photo = Photo(context: self.context)
        photo.image = imageView.image?.pngData()
        photo.comment = textView.text == nil ? "" : textView.text
        photo.tag = locationLabel.text == "사진 찍은 장소" ? "" : locationLabel.text
        photo.thumbnail = imageView.image?.jpegData(compressionQuality: 0.1)
        self.save()
    }
    
    func loadPhotoData() {
        let photo = self.fetch(Photo.self)
        self.photo = photo
        album.removeAll()
                
        self.photo.forEach {
            let picture = Picture(image: $0.image, comment: $0.comment, imageTag: $0.tag, thumbnail: $0.thumbnail)
            album.append(picture)
        }
    }
    
    func updateData(index: Int, textField: UITextField, location: UITextField) {
        let selectedPhoto = photo[index]
        selectedPhoto.comment! = textField.text ?? ""
        selectedPhoto.tag! = location.text ?? ""
        self.save()
    }
    
    func deleteData(index: Int) {
        let selectedPhoto = photo[index]
        self.context.delete(selectedPhoto)
        self.save()
    }
    
    func printData() {
        photo.forEach { print($0.comment ?? "")}
    }
}

