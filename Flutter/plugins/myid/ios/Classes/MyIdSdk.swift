import Foundation
import MyIdSDK

public class AppearancePublic: NSObject {

    public let colorPrimary: UIColor?
    public let colorOnPrimary: UIColor?
    public let colorError: UIColor?
    public let colorOnError: UIColor?
    public let colorOutline: UIColor?
    public let colorDivider: UIColor?
    public let colorSuccess: UIColor?
    public let colorButtonContainer: UIColor?
    public let colorButtonContainerDisabled: UIColor?
    public let colorButtonContent: UIColor?
    public let colorButtonContentDisabled: UIColor?
    public let colorScanButtonContainer: UIColor?
    public let buttonCornerRadius: Int?
    
    public init(
        colorPrimary: UIColor?,
        colorOnPrimary: UIColor?,
        colorError: UIColor?,
        colorOnError: UIColor?,
        colorOutline: UIColor?,
        colorDivider: UIColor?,
        colorSuccess: UIColor?,
        colorButtonContainer: UIColor?,
        colorButtonContainerDisabled: UIColor?,
        colorButtonContent: UIColor?,
        colorButtonContentDisabled: UIColor?,
        colorScanButtonContainer: UIColor?,
        buttonCornerRadius: Int?
    ) {
        self.colorPrimary = colorPrimary
        self.colorOnPrimary = colorOnPrimary
        self.colorError = colorError
        self.colorOnError = colorOnError
        self.colorOutline = colorOutline
        self.colorDivider = colorDivider
        self.colorSuccess = colorSuccess
        self.colorButtonContainer = colorButtonContainer
        self.colorButtonContainerDisabled = colorButtonContainerDisabled
        self.colorButtonContent = colorButtonContent
        self.colorButtonContentDisabled = colorButtonContentDisabled
        self.colorScanButtonContainer = colorScanButtonContainer
        self.buttonCornerRadius = buttonCornerRadius
    }
}

public func loadAppearance(config: NSDictionary) throws -> AppearancePublic? {
    if let jsonResult = config as? Dictionary<String, AnyObject> {
        let colorPrimary = (jsonResult["colorPrimary"] == nil)
                ? nil : UIColor.from(hex: jsonResult["colorPrimary"] as! String)
        
        let colorOnPrimary = (jsonResult["colorOnPrimary"] == nil)
                ? nil : UIColor.from(hex: jsonResult["colorOnPrimary"] as! String)
        
        let colorError = (jsonResult["colorError"] == nil)
                ? nil : UIColor.from(hex: jsonResult["colorError"] as! String)
        
        let colorOnError = (jsonResult["colorOnError"] == nil)
                ? nil : UIColor.from(hex: jsonResult["colorOnError"] as! String)
        
        let colorOutline = (jsonResult["colorOutline"] == nil)
                ? nil : UIColor.from(hex: jsonResult["colorOutline"] as! String)
        
        let colorDivider = (jsonResult["colorDivider"] == nil)
                ? nil : UIColor.from(hex: jsonResult["colorDivider"] as! String)
        
        let colorSuccess = (jsonResult["colorSuccess"] == nil)
                ? nil : UIColor.from(hex: jsonResult["colorSuccess"] as! String)
        
        let colorButtonContainer = (jsonResult["colorButtonContainer"] == nil)
                ? nil : UIColor.from(hex: jsonResult["colorButtonContainer"] as! String)
        
        let colorButtonContainerDisabled = (jsonResult["colorButtonContainerDisabled"] == nil)
                ? nil : UIColor.from(hex: jsonResult["colorButtonContainerDisabled"] as! String)
        
        let colorButtonContent = (jsonResult["colorButtonContent"] == nil)
                ? nil : UIColor.from(hex: jsonResult["colorButtonContent"] as! String)
        
        let colorButtonContentDisabled = (jsonResult["colorButtonContentDisabled"] == nil)
                ? nil : UIColor.from(hex: jsonResult["colorButtonContentDisabled"] as! String)

        let colorScanButtonContainer = (jsonResult["colorScanButtonContainer"] == nil)
                ? nil : UIColor.from(hex: jsonResult["colorScanButtonContainer"] as! String)

        let buttonCornerRadius: Int? = (jsonResult["buttonCornerRadius"] == nil) ? nil : 8
                        
        let appearancePublic = AppearancePublic(
            colorPrimary: colorPrimary,
            colorOnPrimary: colorOnPrimary,
            colorError: colorError,
            colorOnError: colorOnError,
            colorOutline: colorOutline,
            colorDivider: colorDivider,
            colorSuccess: colorSuccess,
            colorButtonContainer: colorButtonContainer,
            colorButtonContainerDisabled: colorButtonContainerDisabled,
            colorButtonContent: colorButtonContent,
            colorButtonContentDisabled: colorButtonContentDisabled,
            colorScanButtonContainer: colorScanButtonContainer,
            buttonCornerRadius: buttonCornerRadius
        )
        return appearancePublic
    } else {
        return nil
    }
}

public func loadAppearanceFromConfig(appearancePublic: AppearancePublic?) throws -> MyIdAppearance {
    if let appearancePublic = appearancePublic {
        let appearance = MyIdAppearance()
        appearance.colorPrimary = appearancePublic.colorPrimary
        appearance.colorOnPrimary = appearancePublic.colorOnPrimary
        appearance.colorError = appearancePublic.colorError
        appearance.colorOnError = appearancePublic.colorOnError
        appearance.colorOutline = appearancePublic.colorOutline
        appearance.colorDivider = appearancePublic.colorDivider
        appearance.colorSuccess = appearancePublic.colorSuccess
        appearance.colorButtonContainer = appearancePublic.colorButtonContainer
        appearance.colorButtonContainerDisabled = appearancePublic.colorButtonContainerDisabled
        appearance.colorButtonContent = appearancePublic.colorButtonContent
        appearance.colorButtonContentDisabled = appearancePublic.colorButtonContentDisabled
        appearance.colorScanButtonContainer = appearancePublic.colorScanButtonContainer

        if let buttonCornerRadius = appearancePublic.buttonCornerRadius {
            appearance.buttonCornerRadius = Float(buttonCornerRadius)
        }
        
        return appearance
    } else {
        return MyIdAppearance()
    }
}

public func buildMyIdConfig(
    config: NSDictionary,
    appearanceConfig: NSDictionary
) throws -> MyIdConfig {
    let appearancePublic = try loadAppearance(config: appearanceConfig)
    let appearance = try loadAppearanceFromConfig(appearancePublic: appearancePublic)

    let clientId = config["clientId"] as? String ?? ""
    let clientHash = config["clientHash"] as? String ?? ""
    let clientHashId = config["clientHashId"] as? String ?? ""
    let passportData = config["passportData"] as? String ?? ""
    let dateOfBirth = config["dateOfBirth"] as? String ?? ""
    let minAge = config["minAge"] as? Int ?? 16
    let sdkHash = config["sdkHash"] as? String ?? ""
    let externalId = config["externalId"] as? String ?? ""
        
    let threshold = config["threshold"] as? Double ?? 0.55
    let distance = config["distance"] as? Double ?? 0.60
    
    let environmentKey = config["environment"] as? String ?? ""
    var environment = MyIdEnvironment.production
    if (environmentKey == "DEBUG") {
        environment = MyIdEnvironment.debug
    }
    
    let entryTypeKey = config["entryType"] as? String ?? ""
    var entryType = MyIdEntryType.identification
    if (entryTypeKey == "FACE_DETECTION") {
        entryType = MyIdEntryType.faceDetection
    }
    
    let residencyKey = config["residency"] as? String ?? ""
    var residency = MyIdResidency.resident
    if (residencyKey == "USER_DEFINED") {
        residency = MyIdResidency.userDefined
    } else if (residencyKey == "NON_RESIDENT") {
        residency = MyIdResidency.nonResident
    }
    
    let localeKey = config["locale"] as? String ?? ""
    var locale = MyIdLocale.uzbek
    if (localeKey == "RUSSIAN") {
        locale = MyIdLocale.russian
    } else if (localeKey == "ENGLISH") {
        locale = MyIdLocale.english
    }
    
    let cameraShapeKey = config["cameraShape"] as? String ?? ""
    var cameraShape = MyIdCameraShape.circle
    if (cameraShapeKey == "ELLIPSE") {
        cameraShape = MyIdCameraShape.ellipse
    }

    let cameraSelectorKey = config["cameraSelector"] as? String ?? ""
    var cameraSelector = MyIdCameraSelector.front
    if (cameraSelectorKey == "BACK") {
        cameraSelector = MyIdCameraSelector.back
    }
    
    let organizationDetailsDict = config["organizationDetails"] as? NSDictionary

    let logo = (organizationDetailsDict?["logo"] == nil) ? nil : UIImage(named: organizationDetailsDict?["logo"] as! String)
    let organizationDetails = MyIdOrganizationDetails()
    organizationDetails.phoneNumber = organizationDetailsDict?["phone"] as? String ?? ""
    organizationDetails.logo = logo
    
    let config = MyIdConfig()
    config.clientId = clientId
    config.clientHash = clientHash
    config.clientHashId = clientHashId
    config.passportData = passportData
    config.dateOfBirth = dateOfBirth
    config.sdkHash = sdkHash
    config.minAge = minAge
    config.externalId = externalId
    config.threshold = Float(threshold)
    config.distance = Float(distance)
    config.residency = residency
    config.environment = environment
    config.entryType = entryType
    config.locale = locale
    config.cameraShape = cameraShape
    config.cameraSelector = cameraSelector
    config.appearance = appearance
    config.organizationDetails = organizationDetails

    return config
}

@objc(MyIdSdk)
class MyIdSdk: NSObject, MyIdClientDelegate {
    
    private var flutterResult: FlutterResult? = nil
    
    func onSuccess(result: MyIdResult) {
        if let fResult = flutterResult {
            fResult(createResponse(result))
        }
    }
    
    func onError(exception: MyIdException) {
        if let fResult = flutterResult {
            fResult(FlutterError(code: "error", message: "\(exception.code ?? "101") - \(exception.message ?? "Unexpected error starting MyID")", details: nil))
        }
    }
    
    func onUserExited() {
        if let fResult = flutterResult {
            fResult(FlutterError(code: "cancel", message: "User canceled flow", details: nil))
        }
    }
    
    @objc static func requiresMainQueueSetup() -> Bool {
      return false
    }

    @objc func start(
        _ config: NSDictionary,
        result: @escaping FlutterResult
    ) -> Void {
        flutterResult = result
        
        DispatchQueue.main.async {
          let withConfig = config["config"] as! NSDictionary
          let withAppearance = config["appearance"] as! NSDictionary
          self.run(withConfig: withConfig, withAppearance: withAppearance, result: result)
        }
    }
    
    private func run(
        withConfig config: NSDictionary,
        withAppearance appearanceConfig: NSDictionary,
        result: @escaping FlutterResult
    ) {
        do {
            let myidConfig = try buildMyIdConfig(config: config, appearanceConfig: appearanceConfig)
            
            MyIdClient.start(withConfig: myidConfig, withDelegate: self)
        } catch let error as NSError {
            result(FlutterError(code: "error", message: error.domain, details: nil))
            return;
        } catch {
            result(FlutterError(code: "error", message: "Unexpected error starting MyID", details: nil))
            return;
        }
    }
}

extension UIColor {

    static func from(hex: String) -> UIColor {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)

        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }

        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let redInt = Int(color >> 16) & mask
        let greenInt = Int(color >> 8) & mask
        let blueInt = Int(color) & mask

        let red = CGFloat(redInt) / 255.0
        let green = CGFloat(greenInt) / 255.0
        let blue = CGFloat(blueInt) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

