//
//  DeviceManager.swift
//  PlayGround
//
//  Created by kim jason on 16/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import Material

class DeviceManager {

    
    class func getDeviceName() -> String {
        return  "\(UIDevice.modelName)"
    }
    

    class func checkSmallDevice() -> Bool {
        //5s, 5, SE의 등의 스크린이 작은 단말일때 true를 보냅니다.
        let deviceModel = Devices.model
        switch deviceModel {
        case DeviceModels.iPhone4s,
             DeviceModels.iPhone5,
             DeviceModels.iPhone5c,
             DeviceModels.iPhone5s,
             DeviceModels.iPhoneSE:
            log?.debug("is small device!!")
            return true
            
        case DeviceModels.simulator:
            if(UIDevice.modelName.contains("5") || UIDevice.modelName.contains("SE")) {
                return true
            } else {
                return false
            }

        default:
            log?.debug("is big device!!")
            return false
        }
    }
    
    class func checkXDevice() -> Bool {
        //놋치 디자인의 X시리즈들 일경우 True를 보내줍니다
        let deviceModel = Devices.model
        switch deviceModel {
            case DeviceModels.iPhoneX,
                 DeviceModels.iPhoneXs,
                 DeviceModels.iPhoneXsMax,
                 DeviceModels.iPhoneXR:
            log?.debug("is X Model")
            return true
        case DeviceModels.simulator:
            if(UIDevice.modelName.contains("X")) {
                return true
            } else {
                return false
            }
        default:
            return false
        }
    }

    class func checkBigDevice() -> Bool {
        //놋치 디자인의 X시리즈들 일경우 True를 보내줍니다
        let deviceModel = Devices.model
        switch deviceModel {
        case
             DeviceModels.iPhoneXsMax,
             DeviceModels.iPhone6Plus,
             DeviceModels.iPhone6sPlus,
             DeviceModels.iPhone7Plus,
             DeviceModels.iPhone8Plus:
            log?.debug("is Big Model")
            return true
        case DeviceModels.simulator:
            if(UIDevice.modelName.contains("Plus") ||
                    UIDevice.modelName.contains("XsMax")) {
                return true
            } else {
                return false
            }
        default:
            return false
        }
    }


    class func checkXsMaxDevice() -> Bool {
        let deviceModel = Devices.model
        switch deviceModel{
        case DeviceModels.iPhoneXsMax:
            log?.debug("is Xms Model")
                    return true
        default:
            return false
        }
    }
    
    class func checkPad() -> Bool {
        //패드 인지 확인 합니다.
        return UIDevice.modelName.contains("Pad")
    }

    class func checkHapticDevice() -> Bool {
        let deviceModel = Devices.model
        switch deviceModel {
        case DeviceModels.iPhone4s,
             DeviceModels.iPhone5,
             DeviceModels.iPhone5c,
             DeviceModels.iPhone5s,
             DeviceModels.iPhoneSE,
             DeviceModels.iPhone6s,
             DeviceModels.iPhone6,
             DeviceModels.iPhone6Plus,
             DeviceModels.iPhone6sPlus:
            log?.debug("is not supported device!!")
            return false

        default:
            log?.debug("is Support device!!")
            return true
        }
    }
}



public extension UIDevice {
    
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String {
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad11,3", "iPad11,4":                    return "iPad Air 3"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad7,5", "iPad7,6":                      return "iPad 6"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad Mini 5"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
}
