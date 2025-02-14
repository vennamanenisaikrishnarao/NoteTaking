import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NotesViewModel()
    @State private var showingAddNote = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(viewModel.notes.enumerated()), id: \ .element.id) { index, note in
                    NavigationLink(destination: NoteDetailView(note: .constant(note), viewModel: viewModel)) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(note.title)
                                    .font(.headline)
                                    .strikethrough(note.isCompleted, color: .black)

                                Text(note.content)
                                    .font(.subheadline)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                            Spacer()

                            if note.isCompleted {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    .listRowBackground(index % 2 == 0 ? Color.orange.opacity(0.3) : Color.blue.opacity(0.3))
                }
                .onDelete(perform: viewModel.deleteNotes)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Notes")
            .toolbar {
                NavigationLink(destination: AddEditNoteView(viewModel: viewModel)) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
