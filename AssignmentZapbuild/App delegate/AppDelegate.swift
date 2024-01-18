//
//  AppDelegate.swift
//  AssignmentZapbuild
//
//  Created by Harpreet Singh on 16/01/24.
//

import UIKit
import GoogleMaps
import GoogleMapsCore

class AppDelegate:NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GMSServices.provideAPIKey("") //Provide API key here from google credentials
        return true
    }
}
