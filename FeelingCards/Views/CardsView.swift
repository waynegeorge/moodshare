//
//  HomeView.swift
//  FeelingCards
//
//  Created by Wayne George on 23/11/2023.
//

import SwiftData
import UIKit
import SwiftUI

enum ViewDestination: Hashable {
    case chooseScore
    case chooseWords
    case chooseReason
}

struct CardsView: View {
    @Query var cards: [Card]
    @Environment(\.modelContext) var modelContext
    
    @State private var navigationPath = NavigationPath()
    @State private var showingShareSheet = false
    @State private var shareItems: [Any] = []
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            Group {
                if let lastCard = cards.last {
                    CardView(card: lastCard)
                        .onTapGesture {
                            navigationPath.append(ViewDestination.chooseScore)
                        }
                        .background(backgroundForLastCard())
                }
                if let lastCard = cards.last
                {
                    if lastCard.score != 0 {
                        Button {
                            captureAndPrepareShare()
                        } label: {
                            Label("Share", systemImage: "square.and.arrow.up")
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 30))
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue)
                            )
                        }
                    }
                }
                Spacer()
                
                Spacer()
            }
            .navigationDestination(for: ViewDestination.self) { destination in
                if let lastCard = cards.last
                {
                    switch destination {
                    case .chooseScore:
                        ChooseScoreView(navigationPath: $navigationPath, card: lastCard)
                    case .chooseWords:
                        ChooseWordsView(navigationPath: $navigationPath, card: lastCard)
                    case .chooseReason:
                        ChooseReasonView(navigationPath: $navigationPath, card: lastCard)
                    }
                }
            }
            .onAppear {
                checkForNewCard()
                
            }
            .sheet(isPresented: $showingShareSheet) {
                ShareView(itemsToShare: shareItems)
            }
            .navigationTitle("Mood Share")
        }
        .ignoresSafeArea()
        .environment(\.modelContext, modelContext)
        .preferredColorScheme(.dark)
    }
    
    private func backgroundForLastCard() -> some View {
        let imageName = cards.last.map { "Mood\($0.score)" } ?? "defaultBackground"
        return Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(minWidth: 0, maxWidth: .infinity)
    }
    
    func checkForNewCard() {
        if cards.isEmpty || !isToday(date: cards.last!.date) {
            addNewCard()
        }
    }
    
    func addNewCard() {
        let newCardDate = Calendar.current.startOfDay(for: Date())
        
        // Check if a card with the same date already exists
        let existingCard = cards.first { card in
            Calendar.current.isDate(card.date, inSameDayAs: newCardDate)
        }
        
        if existingCard == nil {
            let newCard = Card(date: newCardDate)
            print("addNewCard: \(newCard.date)")
            modelContext.insert(newCard)
        }
    }
    
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        let todayComponents = calendar.dateComponents([.year, .month, .day], from: Date())
        let selectedDateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        
        return todayComponents == selectedDateComponents
    }
    
    private func captureAndPrepareShare() {
        if let windowScene = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows
            .filter({ $0.isKeyWindow }).first {
            
            let screenshot = windowScene.rootViewController?.view.takeScreenshot()
            
            let scale = UIScreen.main.scale
            let cropY = (screenshot?.size.height ?? 0) * 0.1
            let cropHeight = (screenshot?.size.height ?? 0) * 0.74
            let cropRect = CGRect(x: 0, y: cropY * scale, width: (screenshot?.size.width ?? 0) * scale, height: cropHeight * scale)
            
            if let croppedImage = screenshot?.cropped(to: cropRect),
               let imageData = croppedImage.jpegData(compressionQuality: 0.8) {
                shareItems = [imageData]
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showingShareSheet = true
                }

                print("Image ready for sharing")
            } else {
                print("Failed to prepare image data")
            }
        } else {
            print("No key window found")
        }
        
        
    }
    
}

extension UIImage {
    func cropped(to rect: CGRect) -> UIImage? {
        guard let cgImage = self.cgImage?.cropping(to: rect) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}

extension UIView {
    func takeScreenshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        if drawHierarchy(in: bounds, afterScreenUpdates: true) {
            return UIGraphicsGetImageFromCurrentImageContext()
        }
        return nil
    }
}
