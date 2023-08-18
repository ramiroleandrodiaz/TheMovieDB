//
//  Shows+UIImage.swift
//  TheMovies
//
//  Created by Ramiro Diaz on 18/08/2023.
//

import Foundation
import UIKit

extension UIImage {
    // Extension to calculate the average color of an image.
    
    var getAverageColour: UIColor? {
        //A CIImage object is the image data you want to process.
        guard let inputImage = CIImage(image: self) else { return nil }
        // A CIVector object representing the rectangular region of inputImage .
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}
