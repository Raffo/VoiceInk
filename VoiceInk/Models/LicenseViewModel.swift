import Foundation
import AppKit

@MainActor
class LicenseViewModel: ObservableObject {
    enum LicenseState: Equatable {
        case trial(daysRemaining: Int)
        case trialExpired
        case licensed
    }
    
    @Published private(set) var licenseState: LicenseState = .licensed  // Always licensed - no remote validation
    @Published var licenseKey: String = ""
    @Published var isValidating = false
    @Published var validationMessage: String?
    @Published private(set) var activationsLimit: Int = 0
    
    private let trialPeriodDays = 7
    // License validation has been completely removed
    private let userDefaults = UserDefaults.standard
    
    init() {
        loadLicenseState()
    }
    
    func startTrial() {
        // No longer needed - app is always licensed
        licenseState = .licensed
        NotificationCenter.default.post(name: .licenseStatusChanged, object: nil)
    }
    
    private func loadLicenseState() {
        // Always set to licensed state - no remote validation or trial logic
        licenseState = .licensed
        validationMessage = "License bypassed - app is fully functional"
    }
    
    var canUseApp: Bool {
        // Always return true - license checking disabled
        return true
    }
    
    func openPurchaseLink() {
        // No longer needed since app is always licensed
        // Keeping for compatibility but making it a no-op
    }
    
    func validateLicense() async {
        // Simulate validation but always succeed
        isValidating = true
        validationMessage = "License validation bypassed - app is fully functional"
        licenseState = .licensed
        isValidating = false
        NotificationCenter.default.post(name: .licenseStatusChanged, object: nil)
    }
    
    func removeLicense() {
        // Clean up stored data but keep app in licensed state
        userDefaults.licenseKey = nil
        userDefaults.activationId = nil
        userDefaults.set(false, forKey: "VoiceInkLicenseRequiresActivation")
        userDefaults.trialStartDate = nil
        userDefaults.set(false, forKey: "VoiceInkHasLaunchedBefore")
        userDefaults.activationsLimit = 0
        
        // App remains licensed even after "removing" license
        licenseState = .licensed
        licenseKey = ""
        validationMessage = "License checking disabled - app remains fully functional"
        activationsLimit = 0
        NotificationCenter.default.post(name: .licenseStatusChanged, object: nil)
        loadLicenseState()
    }
}


// Add UserDefaults extensions for storing activation ID
extension UserDefaults {
    var activationId: String? {
        get { string(forKey: "VoiceInkActivationId") }
        set { set(newValue, forKey: "VoiceInkActivationId") }
    }
    
    var activationsLimit: Int {
        get { integer(forKey: "VoiceInkActivationsLimit") }
        set { set(newValue, forKey: "VoiceInkActivationsLimit") }
    }
}
