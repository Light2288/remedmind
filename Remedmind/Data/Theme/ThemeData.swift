//
//  ThemeData.swift
//  Remedmind
//
//  Created by Davide Aliti on 29/01/23.
//

import SwiftUI

let themeData: [Theme] = [
    Theme(id: 0, themeName: "Default", themeColors: ThemeColors(primaryColor: Color("DarkCyan"), secondaryColor: Color("PrincetonOrange"))),
    Theme(id: 1, themeName: "Mono Dark Cyan", themeColors: ThemeColors(primaryColor: Color("DarkCyan"), secondaryColor: Color("DarkCyan"))),
    Theme(id: 2, themeName: "Mono Princeton Orange", themeColors: ThemeColors(primaryColor: Color("PrincetonOrange"), secondaryColor: Color("PrincetonOrange"))),
    Theme(id: 3, themeName: "Monochrome", themeColors: ThemeColors(primaryColor: Color(.systemGray), secondaryColor: Color(.systemGray)))
]
