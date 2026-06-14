import Foundation
import SwiftData

@MainActor
class DataManager {
    static let shared = DataManager()
    
    // Shared model container setup
    let modelContainer: ModelContainer
    
    private init() {
        do {
            let schema = Schema([Perfume.self])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    func seedDataIfNeeded() {
        let context = modelContainer.mainContext
        
        do {
            let descriptor = FetchDescriptor<Perfume>()
            let existingCount = try context.fetchCount(descriptor)
            
            if existingCount == 0 {
                print("DataManager: Database is empty. Seeding initial perfume data...")
                for perfume in perfumeDataArray {
                    context.insert(perfume)
                }
                try context.save()
                print("DataManager: Successfully seeded \(perfumeDataArray.count) perfumes.")
            } else {
                print("DataManager: Database already has \(existingCount) perfumes. Skipping seed.")
            }
        } catch {
            print("DataManager: Failed to seed data. Error: \(error.localizedDescription)")
        }
    }
}
