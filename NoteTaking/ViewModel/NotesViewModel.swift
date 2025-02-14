import Foundation
import SwiftUI

class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = [] {
        didSet {
            saveNotes()
        }
    }
    
    @AppStorage("notesData") private var notesData: String = ""

    init() {
        loadNotes()
    }

    func addNote(title: String, content: String) {
        let newNote = Note(title: title, content: content)
        notes.append(newNote)
    }

    func updateNote(id: UUID, title: String, content: String) {
        if let index = notes.firstIndex(where: { $0.id == id }) {
            notes[index].title = title
            notes[index].content = content
        }
    }

    func toggleCompletion(id: UUID) {
        if let index = notes.firstIndex(where: { $0.id == id }) {
            notes[index].isCompleted.toggle()
        }
    }

    func deleteNotes(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }

    private func saveNotes() {
        do {
            let data = try JSONEncoder().encode(notes)
            notesData = String(data: data, encoding: .utf8) ?? ""
        } catch {
            print("Error saving notes: \(error)")
        }
    }

    private func loadNotes() {
        guard !notesData.isEmpty else { return }
        
        do {
            if let data = notesData.data(using: .utf8) {
                notes = try JSONDecoder().decode([Note].self, from: data)
            }
        } catch {
            print("Error loading notes: \(error)")
        }
    }
}
