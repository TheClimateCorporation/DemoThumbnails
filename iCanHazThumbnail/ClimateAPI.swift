//
// Wrapper around Climate API
//  
//
//  Created by Aditya Rao on 2/17/16.
//
//

import Foundation
import LoginWithClimate

public enum ThumbnailOpts {
    case fill
    case height
    case width
}

public class ClimateAPI {
    
    private static let baseUrl = "https://hackillinois.climate.com/api"
    
    private static let thumbnailBaseUrl = "https://api.climate.com/api"
    
    public static func fieldsUrl () -> NSURL {
        return NSURL(string: baseUrl + "/fields")!
    }
    
    public static func thumbnailUrl (id: Int, userId: Int, thumbnailOptions: [ThumbnailOpts: String]) -> NSURL {
        
        let components = NSURLComponents(string: thumbnailBaseUrl + "/thumbnail/v1/fields/\(id)")
        components!.queryItems = []
        components!.queryItems?.append(NSURLQueryItem(name: "format", value: "png"))
        components!.queryItems?.append(NSURLQueryItem(name: "user-id", value: String(userId)))
        thumbnailOptions.forEach ({ (optionName: ThumbnailOpts, optionValue: String) -> Void  in
            components!.queryItems?.append(NSURLQueryItem(name: String(optionName), value: optionValue))
        })
        
        return components!.URL!
    }
    
    public static func fieldFromJson(fieldJson: [String: AnyObject]) -> Field? {
        
        guard let
            fieldName = fieldJson["name"] as! String!,
            id = fieldJson["id"] as! String!,
            acres = fieldJson["area"]!["q"]! as! Double!
            else {
                print("Error creating fields from json \(fieldJson)")
                return nil
        }
        return Field(name: fieldName, id: Int(id)!, acres: acres)
    }
}
