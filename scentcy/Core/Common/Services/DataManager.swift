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
            let existingPerfumes = try context.fetch(descriptor)
            
            if existingPerfumes.isEmpty {
                print("DataManager: Database is empty. Seeding initial perfume data...")
                for perfume in perfumeDataArray {
                    context.insert(perfume)
                }
                try context.save()
                print("DataManager: Successfully seeded \(perfumeDataArray.count) perfumes.")
            } else {
                // Sync tags and other fields from perfumeDataArray into existing SwiftData records
                var didUpdate = false
                for sourceData in perfumeDataArray {
                    if let existing = existingPerfumes.first(where: { $0.name == sourceData.name && $0.brand == sourceData.brand }) {
                        if existing.tags != sourceData.tags {
                            existing.tags = sourceData.tags
                            didUpdate = true
                        }
                        if existing.mainAccords != sourceData.mainAccords {
                            existing.mainAccords = sourceData.mainAccords
                            didUpdate = true
                        }
                    }
                }
                if didUpdate {
                    try context.save()
                    print("DataManager: Synced tags/accords for existing perfumes.")
                } else {
                    print("DataManager: Database already up-to-date. Skipping sync.")
                }
            }
        } catch {
            print("DataManager: Failed to seed data. Error: \(error.localizedDescription)")
        }
    }
}
