//
//  InspectionsFileDataStore.swift
//  Inspect
//
//  Created by Manish Charhate on 06/08/24.
//

import Foundation

final class InspectionsFileDataStore: InspectionsDataStore {
    
    private let filename = "inspections.json"
    
    func fetchInspections() -> [InspectionData] {
        let fileURL = getDocumentsDirectory().appendingPathComponent(filename)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                let existingInspections = try JSONDecoder().decode([InspectionData].self, from: data)
                return existingInspections
            } catch {
                debugPrint("Error reading existing file: \(error)")
                return []
            }
        }
        
        return []
    }

    func saveInspections(_ inspections: [InspectionData]) {
        let fileURL = getDocumentsDirectory().appendingPathComponent(filename)

        do {
            let data = try JSONEncoder().encode(inspections)
            try data.write(to: fileURL)
            print("Data successfully written to file.")
        } catch {
            print("Error writing data to file: \(error)")
        }
    }
    
    func saveInspection(_ inspection: InspectionData) {
        let fileURL = getDocumentsDirectory().appendingPathComponent(filename)
        
        var combinedArray: [InspectionData] = []

        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                let existingArray = try JSONDecoder().decode([InspectionData].self, from: data)
                combinedArray = existingArray
            } catch {
                print("Error reading existing file: \(error)")
            }
        }
 
        combinedArray.append(inspection)

        do {
            let data = try JSONEncoder().encode(combinedArray)
            try data.write(to: fileURL)
            print("Data successfully written to file.")
        } catch {
            print("Error writing data to file: \(error)")
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
