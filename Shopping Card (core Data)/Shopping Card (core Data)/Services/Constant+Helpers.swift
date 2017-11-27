//
//  Constant+Helpers.swift
//  Shopping Card (core Data)
//
//  Created by Yveslym on 11/22/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import Foundation

protocol stackDelegate:class {
    func favoriteButtonPressed(_ indexPath: IndexPath, product: Product)
    func sendProduct(_ item: Product)
    func deleteProductFromCard(_ indexPath: IndexPath, product: Product)
}


