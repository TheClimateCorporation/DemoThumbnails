//
// Wrapper around Climate API
//  
//
//  Created by Aditya Rao on 2/17/16.
//
//

import Foundation
import LoginWithClimate

public enum ThumbnailOpts: String{
    case Fill = "fill" // Color should be an html color name or a hex color
    case Height = "height" // Image height in pixels
    case Width = "width" // Image width in pixels
    case Stroke = "stroke" // Color should be an html color name or a hex color
    case StrokeWidth = "stroke-width" // Stroke width for field outline
    case BackgroundStroke = "background-stroke" // Color should be an html color name or a hex color
    case BackgroundStrokeWidth = "background-stroke-width" // Color should be an html color name or a hex color
    case BackgroundFill = "background-fill" // Color should be an html color name or a hex color
    case Margin = "margin" // Margin in pixels
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
            components!.queryItems?.append(NSURLQueryItem(name: optionName.rawValue, value: optionValue))
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
