import SwiftUI

struct AddEditNoteView: View {
    @ObservedObject var viewModel: NotesViewModel
    @Environment(\.dismiss) var dismiss

    @State private var title: String
    @State private var content: String
    @State private var showAlert: Bool = false

    var note: Note?

    init(viewModel: NotesViewModel, note: Note? = nil) {
        self.viewModel = viewModel
        self.note = note
        _title = State(initialValue: note?.title ?? "")
        _content = State(initialValue: note?.content ?? "")
    }

    var body: some View {
        ZStack {
            NavigationStack {
                Form {
                    TextField("Title", text: $title)
                    TextEditor(text: $content)
                        .frame(height: 200)
                }
                .navigationTitle(note == nil ? "Add Note" : "Edit Note")
                .frame(maxWidth: .infinity, alignment: .center)
                .shadow(color: .gray, radius: 5, x: 0, y: 5)
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    Button("Save") {
                        if title.isEmpty {
                            showAlert = true
                        } else {
                            if let note = note {
                                viewModel.updateNote(id: note.id, title: title, content: content)
                            } else {
                                viewModel.addNote(title: title, content: content)
                            }
                            dismiss()
                        }
                    }
                }
            }

            if showAlert {
                VStack {
                    Spacer()
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.red)
                        Text("Please enter a title")
                            .foregroundColor(.red)
                            .font(.subheadline)
                    }
                    .padding()
                    .background(Color.red.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
}
