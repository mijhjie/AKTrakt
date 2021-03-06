//
//  TraktAuthViewControllerDelegate.swift
//  Pods
//
//  Created by Florian Morello on 30/10/15.
//
//

import Foundation

/// Trakt auth view controller delegate protocol
public protocol TraktAuthViewControllerDelegate: class {
    /**
     Called when a user has successfully logged in

     - parameter controller: controller
     */
    func TraktAuthViewControllerDidAuthenticate(controller: UIViewController)

    /**
     Called when a user cancel the auth process

     - parameter controller: controller
     */
    func TraktAuthViewControllerDidCancel(controller: UIViewController)
}
