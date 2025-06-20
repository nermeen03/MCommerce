import SwiftUI



struct FilterBarView: View {
    @Binding var isExpanded: Bool
    @Binding var selectedMaxPrice: Double
    let minPrice: Double
    let maxPrice: Double
    let onFilterChanged: () -> Void

    var body: some View {
        VStack(alignment: .leading) {

         
            if isExpanded {
                HStack(alignment: .top, spacing: 10) {
                  let safeMin = minPrice == maxPrice ? minPrice-1 : minPrice
                    Text(" \(Int(safeMin)) " + "USD".symbol)
                        .font(.caption)
                        .padding(.top,7)
                    Slider(value: $selectedMaxPrice, in: safeMin...maxPrice, step: 1)
                        .accentColor(.deepPurple)

                    Text(" \(Int(selectedMaxPrice)) " + "USD".symbol)
                        .font(.caption)
                        .padding(.top,7)

                   Text("By Price")
                    .font(.callout)
                    .foregroundColor(.deepPurple)
                    .padding(.top, 4)
                }
                .padding(.horizontal).padding(.vertical,8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
        }
        .padding()
    }
}
