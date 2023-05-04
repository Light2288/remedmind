//
//  ReminderListAddIntakeOverlayView.swift
//  Remedmind
//
//  Created by Davide Aliti on 03/05/23.
//

import SwiftUI

struct ReminderListAddIntakeOverlayView: View {
    // MARK: - Properties
    @Binding var selectedReminder: Reminder?
    @Binding var selectedDay: Date
    @Binding var showAddIntakeOverlayView: Bool
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Spacer()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.ultraThinMaterial)
            VStack {
                Text(selectedReminder?.medicineName ?? "Unkown medicine name")
                    .font(.largeTitle)
                DailyIntakeView(selectedDay: $selectedDay, reminder: Binding($selectedReminder)!)
            }
            .frame(maxWidth: .infinity)
        }
        .background(.ultraThinMaterial)
        .ignoresSafeArea(edges: .all)
        .overlay(alignment: .topTrailing) {
            Button {
                showAddIntakeOverlayView.toggle()
            } label: {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
            }
            .offset(CGSize(width: -16, height: 16))
        }
    }
}

// MARK: - Preview
struct ReminderListAddIntakeOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderListAddIntakeOverlayView(selectedReminder: .constant(Reminder(context: PersistenceController.preview.container.viewContext)), selectedDay: .constant(Date.now), showAddIntakeOverlayView: .constant(false))
    }
}
