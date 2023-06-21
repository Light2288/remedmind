//
//  ThemeData.swift
//  Remedmind
//
//  Created by Davide Aliti on 29/01/23.
//

import SwiftUI

let themeData: [Theme] = [
    Theme(
        id: 0,
        themeName: String(localized: "theme.name.default"),
        themeColors: ThemeColors(
            primaryColor: Color(String(localized: "theme.color.darkCyan")),
            secondaryColor: Color(String(localized: "theme.color.princetonOrange"))
        )
    ),
    Theme(
        id: 1,
        themeName: String(localized: "theme.name.darkCyan"),
        themeColors: ThemeColors(
            primaryColor: Color(String(localized: "theme.color.darkCyan")),
            secondaryColor: Color(String(localized: "theme.color.darkCyan"))
        )
    ),
    Theme(
        id: 2,
        themeName: String(localized: "theme.name.princetonOrange"),
        themeColors: ThemeColors(
            primaryColor: Color(String(localized: "theme.color.princetonOrange")),
            secondaryColor: Color(String(localized: "theme.color.princetonOrange"))
        )
    ),
    Theme(
        id: 3,
        themeName: String(localized: "theme.name.monochrome"),
        themeColors: ThemeColors(
            primaryColor: Color(.systemGray),
            secondaryColor: Color(.systemGray)
        )
    )
]
