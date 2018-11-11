//
//  Response.swift
//  LAPay
//
//  Created by Matt Deuschle on 11/10/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import Foundation

enum Response<T> {
    case success(T)
    case failure(Error?)
}
