import SwiftUI

struct ContentView: View {
    @AppStorage("username") private var username = ""
    @AppStorage("email") private var email = ""
    @AppStorage("enableNotifications") private var enableNotifications = true
    @AppStorage("selectedTheme") private var selectedTheme = "light"
    @AppStorage("volume") private var volume = 50
    @AppStorage("lastVisit") private var lastVisit = Date.distantPast

    var body: some View {
        Form {
            Section("用户信息") {
                TextField("用户名", text: $username)
                    .textFieldStyle(.roundedBorder)

                TextField("邮箱", text: $email)
                    .textFieldStyle(.roundedBorder)

                Text("最后访问: \(lastVisit == Date.distantPast ? "从未" : lastVisit.formatted())")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Section("偏好设置") {
                Toggle("启用通知", isOn: $enableNotifications)

                Picker("主题", selection: $selectedTheme) {
                    Text("浅色").tag("light")
                    Text("深色").tag("dark")
                    Text("自动").tag("auto")
                }

                HStack {
                    Text("音量")
                    Slider(value: Binding(
                        get: { Double(volume) },
                        set: { volume = Int($0) }
                    ), in: 0...100, step: 1)
                    Text("\(volume)%")
                        .frame(width: 50)
                }
            }

            Section {
                Button("重置所有设置") {
                    resetSettings()
                }
                .foregroundColor(.red)
            }

            Section("说明") {
                Text("@AppStorage 会自动将数据保存到 UserDefaults")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text("关闭应用后重新打开，数据会保留")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .formStyle(.grouped)
        .padding()
        .onAppear {
            lastVisit = Date()
        }
    }

    func resetSettings() {
        username = ""
        email = ""
        enableNotifications = true
        selectedTheme = "light"
        volume = 50
    }
}
