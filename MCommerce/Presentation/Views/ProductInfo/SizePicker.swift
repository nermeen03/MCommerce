import SwiftUI

struct SizePicker: View {
    @ObservedObject var viewModel: ProductViewModel
    @Binding var selectedSize: String?

    // 2 or 3 columns depending on screen size
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
        ,GridItem(.flexible()),
        GridItem(.flexible())
        ,GridItem(.flexible())
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Select Size")
                .font(.headline)
                .padding(.horizontal)
            HStack{
                Spacer()
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(viewModel.availableSizes, id: \.self) { size in
                        Text(size)
                            .fontWeight(.medium)
                            .frame(height: 40)
                            .frame(maxWidth: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedSize == size ? Color.black : Color.gray.opacity(0.3), lineWidth: 2)
                            )
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(selectedSize == size ? Color.gray.opacity(0.2) : Color.clear)
                            )
                            .onTapGesture {
                                selectedSize = size
                            }
                    }
                }
                .padding(.horizontal , 4)
            }
            }
    }
}
