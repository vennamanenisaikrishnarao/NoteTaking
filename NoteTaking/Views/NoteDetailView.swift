import SwiftUI

struct NoteDetailView: View {
    @Binding var note: Note
    @ObservedObject var viewModel: NotesViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {

            Text("Note Details")
                .font(.largeTitle)
                .bold()
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .center)
                .shadow(color: .gray, radius: 5, x: 0, y: 5)

            Text(note.title)
                .font(.title2)
                .bold()
                .strikethrough(note.isCompleted, color: .gray)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 5)
                .overlay(Rectangle().frame(height: 2).foregroundColor(.black), alignment: .bottom)

            Text(note.content)
                .font(.body)
                .multilineTextAlignment(.leading)

            Spacer()

            Button(action: {
                viewModel.toggleCompletion(id: note.id)
            }) {
                HStack {
                    Image(systemName: note.isCompleted ? "hourglass" : "hourglass.bottomhalf.fill")
                        .foregroundColor(.white)
                    Text(note.isCompleted ? "Mark as Incomplete" : "Mark as Completed")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(note.isCompleted ? Color.red : Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 5, x: 0, y: 5)
            }
            .padding(.bottom)
        }
        .padding(.horizontal)
        .toolbar {
            NavigationLink(destination: AddEditNoteView(viewModel: viewModel, note: note)) {
                Image(systemName: "square.and.pencil")
                    .font(.system(size: 12))
                    .padding(2.5)
                    .background(Circle().stroke(Color.blue, lineWidth: 1))

            }
        }
    }
}

