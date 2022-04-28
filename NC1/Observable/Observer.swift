//
//  Observable.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 28/04/22.
//

import Foundation

protocol Observer: AnyObject {
    func update(with: Observable)
}
