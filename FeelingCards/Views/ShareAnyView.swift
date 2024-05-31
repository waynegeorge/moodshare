//
//  ShareAnyView.swift
//  FeelingCards
//
//  Created by Wayne George on 29/05/2024.
//

import SwiftUI

struct ShareAnyView: UIViewControllerRepresentable {
    var itemsToShare: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        
        // Exclude specific activity types
        controller.excludedActivityTypes = [
            .postToFacebook,
            .postToTwitter,
            .postToWeibo,
            .copyToPasteboard,
            .assignToContact,
            .addToReadingList,
            .postToFlickr,
            .postToVimeo,
            .postToTencentWeibo,
            .markupAsPDF,
            .addToHomeScreen,
        ]
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // No need to update the controller in this case
    }
}
