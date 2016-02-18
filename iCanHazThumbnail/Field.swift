//
//  Field.swift
//  
//
//  Created by Aditya Rao on 2/16/16.
//
//

import UIKit

public class Field {
    
    public var name : String
    public var id : Int
    public var acres : Double
    public var thumbnail : UIImage?
    
    init(name: String, id: Int, acres: Double) {
        self.name = name
        self.id = id
        self.acres = acres
    }
}
