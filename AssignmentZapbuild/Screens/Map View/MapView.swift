//
//  MapView.swift
//  AssignmentZapbuild
//
//  Created by Harpreet Singh on 16/01/24.
//

import GoogleMaps
import SwiftUI

struct MapView: UIViewControllerRepresentable {
    @ObservedObject var viewModel:MapViewModel
    
    func makeUIViewController(context: Context) -> MapViewController {
        let uiViewController = MapViewController()
        uiViewController.map.delegate = context.coordinator
        return uiViewController
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        viewModel.markers.wrappedValue.forEach { $0.map = uiViewController.map }
        viewModel.selectedMarker.wrappedValue?.map = uiViewController.map
        animateToSelectedMarker(viewController: uiViewController)
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(self)
    }
    
    private func animateToSelectedMarker(viewController: MapViewController) {
        guard let selectedMarker = viewModel.selectedMarker.wrappedValue else {
            viewController.map.selectedMarker = nil
            viewController.map.animate(toZoom: kGMSMinZoomLevel)
            return
        }
        
        let map = viewController.map
        if map.selectedMarker != selectedMarker {
            map.selectedMarker = selectedMarker
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                map.animate(toZoom: kGMSMinZoomLevel)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    map.animate(with: GMSCameraUpdate.setTarget(selectedMarker.position))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        map.animate(toZoom: 12)
                    })
                }
            }
        }
    }
    
    final class MapViewCoordinator: NSObject, GMSMapViewDelegate {
        var mapViewControllerBridge: MapView
        
        init(_ mapViewControllerBridge: MapView) {
            self.mapViewControllerBridge = mapViewControllerBridge
        }
    }
}
