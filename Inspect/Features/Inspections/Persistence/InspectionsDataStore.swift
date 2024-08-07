//
//  InspectionsDataStore.swift
//  Inspect
//
//  Created by Manish Charhate on 06/08/24.
//

import Foundation

protocol InspectionsDataStore {
    
    func saveInspections(_ inspections: [Inspection])
    
    func saveInspection(_ inspection: Inspection)
    
    func fetchInspections() -> [Inspection]
}
