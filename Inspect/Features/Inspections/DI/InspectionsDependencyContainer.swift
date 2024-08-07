//
//  InspectionsDependencyContainer.swift
//  Inspect
//
//  Created by Manish Charhate on 06/08/24.
//

import Foundation

final class InspectionsDependencyContainer {
    
    // MARK: Properties
    
    let networkManager: NetworkManager
    let dataStore: InspectionsDataStore
    
    // MARK: Init
    
    init(appDependencyContainer: AppDependencyContainer) {
        self.networkManager = appDependencyContainer.networkManager
        self.dataStore = InspectionsFileDataStore()
    }
    
    // MARK: Public methods
    
    func makeInspectionsTabView() -> InspectionsTabView {
        return InspectionsTabView(viewModel: makeInspectionsTabViewModel())
    }
    
    func makeInspectionsTabViewModel() -> InspectionsTabViewModel {
        return InspectionsTabViewModel(
            repository: InspectionsAPIRepository(
                networkManager: networkManager,
                dataStore: dataStore
            )
        )
    }
}
