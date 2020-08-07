//
//  ErrorMessage.swift
//  GithubFinder
//
//  Created by Diego Oruna on 5/08/20.
//

import Foundation

enum GFError:String, Error {
    case invalidUsername = "This username created an invalid request"
    case unableToComplete = "Unable to complete your request. Check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server was invalid. Please try again"
}
