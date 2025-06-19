import SwiftUI



struct FilterBarView: View {
    @Binding var isExpanded: Bool
    @Binding var selectedMaxPrice: Double
    let minPrice: Double
    let maxPrice: Double
    let onFilterChanged: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
          
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .foregroundColor(.orangeCustom)
                    Text("Filter")
                        .foregroundColor(.orangeCustom)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.orangeCustom)
                }
            }

         
            if isExpanded {
                HStack(alignment: .top, spacing: 10) {
                  let safeMin = minPrice == maxPrice ? minPrice-1 : minPrice

                    Slider(value: $selectedMaxPrice, in: safeMin...maxPrice, step: 1)
                        .accentColor(.deepPurple)

                    Text(" \(Int(selectedMaxPrice)) ")
                        .font(.caption)
                        .padding(.top,7)

                    Button("Apply Filter") {
                        onFilterChanged()
                    }
                    .font(.callout)
                    .foregroundColor(.orangeCustom)
                    .padding(.top, 4)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
        }
        .padding()
    }
}
