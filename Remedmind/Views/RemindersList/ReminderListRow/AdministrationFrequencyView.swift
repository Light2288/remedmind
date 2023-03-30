//
//  AdministrationFrequencyView.swift
//  Remedmind
//
//  Created by Davide Aliti on 08/02/23.
//

import SwiftUI

struct AdministrationFrequencyView: View {
    // MARK: - Properties
    var administrationQuantity: Float
    var administrationType: String
    var numberOfAdministrations: Int32
    var administrationFrequency: String
    
    // MARK: - Body
    var body: some View {
        let frequency =
        {
          switch AdministrationFrequency(rawValue: administrationFrequency)
          {
            case .daily:
              return "a day"
            case .weekly:
              return "a week"
          case .everyOtherDay:
              return "every other day"
          case .none:
              return "a day"
          }
        }()
        
        return VStack(alignment: .trailing) {
            Text("\(administrationQuantity.formatted(.number)) \(administrationType )")
            Text("\(numberOfAdministrations) times \(frequency)")
        }
        .font(.footnote)
    }
}

// MARK: - Preview
struct AdministrationFrequencyView_Previews: PreviewProvider {
    static var previews: some View {
        AdministrationFrequencyView(administrationQuantity: 2.55, administrationType: "pill", numberOfAdministrations: 4, administrationFrequency: "daily")
            .previewLayout(.sizeThatFits)
    }
}
