# SwiftUI macOS @AppStorage 持久化存储

## 简介

演示 SwiftUI 中 @AppStorage 的用法，用于简化 UserDefaults 的读写操作，自动持久化数据。

## 快速开始

```bash
cd swiftui-macos-appstorage-demo
xcodegen generate
open SwiftUIAppStorageDemo.xcodeproj
# Cmd+R 运行
```

关闭应用后重新打开，输入的值会保留。

## 概念讲解

### 基础 @AppStorage

```swift
@AppStorage("username") private var username = ""

TextField("用户名", text: $username)
```

`@AppStorage` 使用字符串作为 key，对应 UserDefaults 中的 key。

### 支持的类型

- String
- Int
- Double
- Bool
- Date
- URL

### 常用模式

```swift
@AppStorage("username") private var username = "默认用户"
@AppStorage("isEnabled") private var isEnabled = false
@AppStorage("volume") private var volume = 50
```

## 完整示例

```swift
struct SettingsView: View {
    @AppStorage("username") private var username = ""
    @AppStorage("enableNotifications") private var enableNotifications = true

    var body: some View {
        Form {
            TextField("用户名", text: $username)
            Toggle("启用通知", isOn: $enableNotifications)
        }
    }
}
```

## 完整讲解（中文）

### @AppStorage vs @State

| 特性 | @State | @AppStorage |
|------|--------|-------------|
| 持久化 | 否 | 是 |
| 存储位置 | 内存 | UserDefaults |
| 关闭后保留 | 否 | 是 |
| 适合场景 | 临时状态 | 用户偏好 |

### 工作原理

`@AppStorage` 本质上是对 UserDefaults 的封装：
- 读取：UserDefaults.standard.string(forKey:)
- 写入：UserDefaults.standard.set(value, forKey:)

### 注意事项

- key 必须唯一，建议使用 app 前缀，如 `"myapp_username"`
- 默认值只在首次没有数据时使用
- 适合存储简单的用户偏好设置
- 不适合存储大量数据
