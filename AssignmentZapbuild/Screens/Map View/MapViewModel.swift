//
//  MapViewModel.swift
//  AssignmentZapbuild
//
//  Created by Harpreet Singh on 16/01/24.
//

import SwiftUI
import GoogleMaps

class MapViewModel: ObservableObject {
    let markers: Binding<[GMSMarker]>
    let selectedMarker: Binding<GMSMarker?>
    init(markers: Binding<[GMSMarker]>, selectedMarker: Binding<GMSMarker?>) {
        self.markers = markers
        self.selectedMarker = selectedMarker
    }
}
