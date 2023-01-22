//
//  SettingsFormRow.swift
//  Remedmind
//
//  Created by Davide Aliti on 22/01/23.
//

import SwiftUI

struct SettingsFormRow: View {
    // MARK: - Properties
    var icon: String
    var title: String
    var content: String?
    var link: String?
    
    // MARK: - Body
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(Color("SecondaryColor"))
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .padding(6)
                    .foregroundColor(Color(.systemBackground))
            }
            .frame(width: 46, height: 46, alignment: .center)
            Text(title)
                .foregroundColor(Color(.systemGray))
            Spacer()
            if let content = self.content {
                Text(content)
            } else if let link = self.link {
                Button {
                    guard let url = URL(string: link), UIApplication.shared.canOpenURL(url) else { return }
                    UIApplication.shared.open(url)
                } label: {
                    Image(systemName: "chevron.right")
                }

            }
        }
    }
}

// MARK: - Preview
struct SettingsFormRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SettingsFormRow(icon: "gear", title: "Application", content: "Remedmind")
                .previewLayout(.fixed(width: 375, height: 60))
            .padding()
            SettingsFormRow(icon: "link", title: "Developer website", link: "www.lightstimulus.com")
                .previewLayout(.fixed(width: 375, height: 60))
            .padding()
        }
    }
}
