//
//  LocationPickerMap.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 19/06/2025.
//

import SwiftUI
import MapKit
import CoreLocation


struct LocationPickerMap: View {
    var onLocationChosen: (CLLocationCoordinate2D) -> Void

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357),
        span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
    )

    var body: some View {
        VStack {
            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, annotationItems: [region.center]) { coordinate in
                MapMarker(coordinate: coordinate, tint: .deepPurple)
            }
            .ignoresSafeArea()

            Button("Choose This Location") {
                onLocationChosen(region.center)
            }
            .padding()
            .background(Color.deepPurple)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding()
        }
    }
}
