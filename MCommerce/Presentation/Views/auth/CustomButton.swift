import SwiftUI

struct CustomButton: View {
    var text: String
    var textColor: Color
    var backgroundColor: Color
    var verticalOffset: CGFloat
    var imageExist: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Group {
                if imageExist {
                    HStack {
                        Image("googleLogo")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                        Text(text)
                            .font(.title3)
                            .frame(maxWidth: .infinity)
                    }
                } else {
                    Text(text)
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .cornerRadius(30)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(imageExist ? Color.gray : .clear, lineWidth: imageExist ? 0.5 : 0)
            )
        }
        .offset(y: verticalOffset)
        .padding(.horizontal)
    }
}
