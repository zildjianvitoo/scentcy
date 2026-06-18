import Foundation
import SwiftData

@MainActor
protocol DataManaging {
    var modelContainer: ModelContainer { get }
    func seedDataIfNeeded()
}

@MainActor
class DataManager: DataManaging {
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
            
            let url = Bundle.main.url(forResource: "perfumes", withExtension: "json")!
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([PerfumeCodable].self, from: data)
            let perfumesData = decoded.map { $0.toPerfume() }
            
            if existingPerfumes.isEmpty {
                print("DataManager: Database is empty. Seeding initial perfume data from JSON...")
                for perfume in perfumesData {
                    context.insert(perfume)
                }
                try context.save()
                print("DataManager: Successfully seeded \(perfumesData.count) perfumes.")
            } else {
                // Sync tags and other fields from JSON into existing SwiftData records
                var didUpdate = false
                for sourceData in perfumesData {
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
