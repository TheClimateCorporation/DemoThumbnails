//
//  FieldStore.swift
//  iCanHazThumbnail
//
//  Created by Aditya Rao on 2/16/16.
//  Copyright © 2016 Aditya Rao. All rights reserved.
//

import Foundation
import LoginWithClimate

public class FieldStore {

    var allFields = [Int:Field]()
    var session : Session?

    init(session: Session) {
        self.session = session
    }

    public func fetchAllFields(onComplete : () -> Void) {
        let request = NSMutableURLRequest(URL: ClimateAPI.fieldsUrl())
        request.setValue("Bearer \(self.session!.accessToken)",
            forHTTPHeaderField: "Authorization")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) -> Void in
                let jsonObject = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
                let fields = (jsonObject["fields"] as! Array).map(ClimateAPI.fieldFromJson)
                fields.forEach {
                    (field) -> Void in
                    guard let parsedField = field as Field!
                        else {
                            print("Did not parse field, ignoring")
                            return
                    }

                    self.putField(parsedField)
                }
            onComplete()
        }
        task.resume()
    }

    public func fetchThumbnailForField(id: Int, height: CGFloat? = nil, width: CGFloat? = nil, onComplete : () -> Void) {
        let request = NSMutableURLRequest(URL: ClimateAPI.thumbnailUrl(id, userId: self.session!.userInfo.id, height: height, width: width))
        request.setValue("Bearer \(self.session!.accessToken)",
            forHTTPHeaderField: "Authorization")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            self.getField(id).thumbnail = UIImage(data: data!)
            onComplete()
        }
        task.resume()


    }

    public func putField(field: Field) {
        self.allFields[field.id] = field
    }

    public func getAllFields() -> [Field] {
        return Array(self.allFields.values)
    }

    public func getField(id: Int) -> Field {
        return self.allFields[id]!
    }
    
    public func numFields() -> Int {
        return self.allFields.values.count
    }
}
