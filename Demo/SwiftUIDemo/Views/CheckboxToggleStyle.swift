//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(
            action: {
                configuration.isOn.toggle()
            },
            label: {
                HStack(
                    alignment: .firstTextBaseline,
                    content: {
                        Image(
                            systemName: configuration.isOn ? "checkmark.square" : "square"
                        )
                        configuration.label
                    }
                )
            }
        )
        .foregroundStyle(.black)
    }
}

#Preview {
    Toggle(isOn: .constant(true)) {
        Text("Check here to agree")
    }
    .toggleStyle(CheckboxToggleStyle())
}
