//
//  MapViewController.swift
//  AssignmentZapbuild
//
//  Created by Harpreet Singh on 16/01/24.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    let map =  GMSMapView(frame: .zero)
    var isAnimating: Bool = false

    override func loadView() {
      super.loadView()
      self.view = map
    }
}
