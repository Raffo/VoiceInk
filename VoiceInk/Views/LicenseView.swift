import SwiftUI

struct LicenseView: View {
    @StateObject private var licenseViewModel = LicenseViewModel()
    
    var body: some View {
        VStack(spacing: 15) {
            Text("License Management")
                .font(.headline)
            
            // Always show activated state since license checking is disabled
            VStack(spacing: 10) {
                Text("Premium Features Activated")
                    .foregroundColor(.green)
                
                Text("License checking has been disabled")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            if let message = licenseViewModel.validationMessage {
                Text(message)
                    .foregroundColor(.green)
                    .font(.caption)
            }
        }
        .padding()
    }
}

struct LicenseView_Previews: PreviewProvider {
    static var previews: some View {
        LicenseView()
    }
} 