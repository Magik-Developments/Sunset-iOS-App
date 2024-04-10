//
//  LandingView.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 14/3/24.
//

import SwiftUI

struct LandingView: View {
    @Environment(SunsetAppViewModel.self) var appViewModel

    var body: some View {
        TabView {
            HomeView().tabItem { Label(String(localized: "tabitem.home"), systemImage: "house.fill") }
            SunsetQualityView().tabItem { Label(String(localized:"tabitem.sunset.quality"), systemImage: "sun.haze.fill") }
            SpotsMapView().tabItem { Label(String(localized:"tabitem.spots.map"), systemImage: "mappin.and.ellipse") }
            ProfileView().tabItem { Label(String(localized:"tabitem.profile"), systemImage: "figure.wave.circle.fill") }
        }
        .tint(.primaryBackgroundDefault)
    }
}

