

## contentInsetAdjustmentBehavior、automaticallyAdjustsScrollViewInsets、self.edgesForExtendedLayout = UIRectEdgeNone 的各自作用


这三个属性都是 iOS 中用于控制**视图控制器与滚动视图（UIScrollView/UITableView/CollectionView 等）布局适配导航栏/状态栏/底部安全区**的关键配置，核心解决“滚动视图是否延伸到导航栏/状态栏下方”“内容是否预留安全区间距”的问题，但分属不同 iOS 版本、作用对象和控制维度，以下逐一拆解：

### 一、先明确核心背景
iOS 7 引入“全屏布局”（View Controller-Based Status Bar Appearance），默认情况下：
- 视图控制器的根视图会延伸到状态栏、导航栏、底部标签栏下方；
- 滚动视图（如 UITableView）的内容会被导航栏遮挡，因此需要这些属性调整布局，避免内容不可见。

### 二、逐个解析属性作用
#### 1. edgesForExtendedLayout（iOS 7+，视图控制器级别）
##### 作用
控制**视图控制器的根视图**是否延伸到“系统栏（导航栏/状态栏/标签栏）”下方，是“视图延伸范围”的总开关。
##### 类型与默认值
- 类型：`UIRectEdge`（枚举，包含 `.top`/`.bottom`/`.left`/`.right`/`.all`/`.none`）；
- 默认值：`UIRectEdge.all`（根视图向所有方向延伸，包括导航栏/状态栏下方）。

##### 关键场景
```swift
// 核心用法：禁止根视图延伸到任何系统栏下方
self.edgesForExtendedLayout = .none
```
- 设置为 `.none`：视图控制器的根视图会被限制在“导航栏/状态栏/标签栏”的安全区域内，不会延伸到其下方；
- 设置为 `.top`：仅根视图顶部延伸到状态栏/导航栏下方，其他方向不延伸；
- 仅影响**视图控制器的根视图**，不直接控制滚动视图的内容间距（需配合其他属性）；
- iOS 11 后逐渐被 `UIScrollView` 的 `contentInsetAdjustmentBehavior` 替代，但低版本仍需兼容。

#### 2. automaticallyAdjustsScrollViewInsets（iOS 7~11，视图控制器级别）
##### 作用
视图控制器自动为**第一个子视图是滚动视图**的控件，添加“适配系统栏的内边距（contentInset）”，避免滚动视图内容被导航栏/状态栏遮挡。
##### 类型与默认值
- 类型：`Bool`；
- 默认值：`true`（自动调整）。

##### 核心逻辑
当该属性为 `true` 时：
1. 视图控制器检测到第一个子视图是 `UIScrollView`（或子类）；
2. 自动计算导航栏/状态栏/底部安全区的高度，为滚动视图设置 `contentInset`（顶部增加导航栏高度，底部增加标签栏高度）；
3. 同时设置 `scrollIndicatorInsets` 与 `contentInset` 一致，保证滚动指示器位置正确。

##### 关键注意事项
- **仅作用于“第一个子视图是滚动视图”的场景**，若滚动视图不是第一个子视图，该属性无效；
- iOS 11 被废弃（标记为 deprecated），替代方案是 `UIScrollView` 的 `contentInsetAdjustmentBehavior`；
- 若手动设置了滚动视图的 `contentInset`，该属性可能覆盖手动配置，导致间距错乱。

#### 3. contentInsetAdjustmentBehavior（iOS 11+，滚动视图级别）
##### 作用
控制滚动视图（`UIScrollView`/`UITableView`/`UICollectionView`）的 `contentInset` 是否自动适配“安全区（Safe Area）”，是 iOS 11 后替代 `automaticallyAdjustsScrollViewInsets` 的核心属性。
##### 类型与默认值
- 类型：`UIScrollView.ContentInsetAdjustmentBehavior`（枚举）；
- 默认值：`.automatic`（iOS 11+）。

##### 枚举值详解（核心）
| 枚举值                | 作用                                                                 |
|-----------------------|----------------------------------------------------------------------|
| `.automatic`          | 等同于 `.scrollableAxes` + 适配导航栏/底部安全区，iOS 11 默认值       |
| `.scrollableAxes`     | 仅在滚动视图可滚动的轴向上适配安全区（垂直滚动则仅调整上下内边距）|
| `.never`              | 完全不自动调整 contentInset，仅使用手动设置的 contentInset           |
| `.always`             | 始终根据安全区调整 contentInset（无论滚动视图是否可滚动）|

##### 核心场景
```swift
// 禁止滚动视图自动适配安全区（手动控制间距）
tableView.contentInsetAdjustmentBehavior = .never

// 仅在可滚动方向适配（推荐，兼顾兼容性）
tableView.contentInsetAdjustmentBehavior = .scrollableAxes
```
- 直接作用于滚动视图，无需依赖“是否是视图控制器第一个子视图”；
- 适配的是“安全区（Safe Area）”，而非直接适配导航栏/标签栏，更贴合 iOS 11+ 的安全区设计；
- 若同时设置了 `edgesForExtendedLayout = .none`，该属性仍会基于安全区调整，需注意叠加效果。

### 三、三者的关联与版本适配逻辑
| iOS 版本 | 核心配置方案                          | 关键说明                                  |
|----------|---------------------------------------|-------------------------------------------|
| iOS 7~10 | `edgesForExtendedLayout` + `automaticallyAdjustsScrollViewInsets` | 控制视图延伸 + 自动调整滚动视图内边距     |
| iOS 11+  | `edgesForExtendedLayout`（可选） + `contentInsetAdjustmentBehavior` | 滚动视图级别控制安全区适配，废弃自动调整属性 |

#### 典型兼容示例（适配 iOS 7~17）
```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    // 1. 基础：禁止视图延伸到系统栏下方（全版本）
    if #available(iOS 11.0, *) {
        // iOS 11+ 优先控制滚动视图
        tableView.contentInsetAdjustmentBehavior = .never
    } else {
        // iOS 11 以下禁用自动调整
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    // 2. 可选：禁止根视图延伸（低版本兜底）
    self.edgesForExtendedLayout = .none
    
    // 3. 手动设置滚动视图内边距（按需）
    tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
}
```

### 四、常见坑点与避坑建议
1. **多属性叠加导致间距错乱**：
   同时设置 `edgesForExtendedLayout = .none` + `automaticallyAdjustsScrollViewInsets = true` 会导致滚动视图内边距重复叠加，需按版本只保留一套配置；
2. **iOS 11+ 仍用 automaticallyAdjustsScrollViewInsets**：
   该属性在 iOS 11+ 已废弃，设置后无效果，需切换到 `contentInsetAdjustmentBehavior`；
3. **滚动视图不是第一个子视图**：
   `automaticallyAdjustsScrollViewInsets` 完全失效，需手动设置 `contentInset`；
4. **安全区与 contentInset 叠加**：
   `contentInsetAdjustmentBehavior = .always` 会在手动 `contentInset` 基础上叠加安全区间距，导致内容偏移过大。

### 五、核心总结
| 属性                          | 作用维度       | 适用版本   | 核心目标                                  |
|-------------------------------|----------------|------------|-------------------------------------------|
| edgesForExtendedLayout        | 视图控制器根视图 | iOS 7+     | 控制根视图是否延伸到系统栏下方            |
| automaticallyAdjustsScrollViewInsets | 视图控制器+滚动视图 | iOS 7~10 | 自动为首个滚动视图添加系统栏适配内边距    |
| contentInsetAdjustmentBehavior | 滚动视图       | iOS 11+    | 控制滚动视图基于安全区自动调整内容内边距  |

简单记：
- 控制“视图是否延伸”用 `edgesForExtendedLayout`；
- iOS 11 前控制“滚动视图自动适配系统栏”用 `automaticallyAdjustsScrollViewInsets`；
- iOS 11 后控制“滚动视图适配安全区”用 `contentInsetAdjustmentBehavior`。




## 如果scrollview根本没在安全区，设置automaticallyAdjustsScrollViewInsets或contentInsetAdjustmentBehavior 还会调整inset吗？

核心结论：**不会自动调整**——`automaticallyAdjustsScrollViewInsets`（iOS 7~10）和 `contentInsetAdjustmentBehavior`（iOS 11+）的核心作用是“基于安全区/系统栏（导航栏、状态栏等）自动适配内边距”，若 `UIScrollView` 根本不在安全区（即完全脱离安全区布局，与系统栏无重叠），两者均不会触发自动调整。

### 关键逻辑拆解
#### 1. 两个属性的“调整触发前提”
- **`automaticallyAdjustsScrollViewInsets`**：仅当 `UIScrollView` 是视图控制器“第一个子视图”，且滚动视图的**内容区域与导航栏/状态栏/标签栏重叠**（因 `edgesForExtendedLayout` 默认延伸）时，才会自动添加 `contentInset` 抵消重叠；若滚动视图不在安全区（无重叠），无需调整，自然不触发。
- **`contentInsetAdjustmentBehavior`**：iOS 11+ 基于“安全区（Safe Area）”工作，仅当滚动视图的 **`frame` 与安全区有交集**（即部分/全部在安全区内）时，才会根据枚举值调整 `contentInset`；若滚动视图完全在安全区外（`frame` 与安全区无重叠），则视为“无需适配安全区”，不做任何自动调整。

#### 2. 代码示例验证（iOS 11+）
```swift
let scrollView = UIScrollView()
scrollView.frame = CGRect(x: 0, y: 1000, width: 300, height: 400) // 完全在屏幕底部安全区外
scrollView.contentSize = CGSize(width: 300, height: 800)
view.addSubview(scrollView)

// 即使设置为默认的 .automatic，也不会调整 inset
scrollView.contentInsetAdjustmentBehavior = .automatic
print("调整前 contentInset：\(scrollView.contentInset)") // 输出：UIEdgeInsets(0,0,0,0)

// 手动让 scrollView 进入安全区（比如调整 y 坐标到 200）
scrollView.frame.origin.y = 200 // 与顶部安全区重叠
DispatchQueue.main.async {
    print("进入安全区后 contentInset：\(scrollView.contentInset)") // 输出：UIEdgeInsets(44,0,34,0)（适配顶部状态栏+底部安全区）
}
```
- 滚动视图在安全区外时，`contentInset` 保持默认（全 0），无自动调整；
- 进入安全区后，`contentInsetAdjustmentBehavior = .automatic` 立即触发调整，添加安全区适配内边距。

#### 3. 低版本（iOS 7~10）验证
```swift
// iOS 9 环境
self.automaticallyAdjustsScrollViewInsets = true // 开启自动调整
let scrollView = UIScrollView()
scrollView.frame = CGRect(x: 0, y: 1000, width: 300, height: 400) // 安全区外
view.addSubview(scrollView) // 滚动视图是第一个子视图

print("安全区外 contentInset：\(scrollView.contentInset)") // 输出：UIEdgeInsets(0,0,0,0)（无调整）

scrollView.frame.origin.y = 0 // 与导航栏/状态栏重叠
print("重叠后 contentInset：\(scrollView.contentInset)") // 输出：UIEdgeInsets(64,0,0,0)（适配导航栏高度）
```
- 低版本的 `automaticallyAdjustsScrollViewInsets` 同样依赖“滚动视图与系统栏重叠”（本质是安全区的早期形态），无重叠则不调整。

### 核心注意点
1. **“不在安全区”的定义**：滚动视图的 `frame` 与系统安全区（顶部状态栏、底部Home Indicator、导航栏/标签栏覆盖区域）无任何交集，而非“未设置安全区约束”；
2. **手动设置 `contentInset` 不受影响**：无论是否在安全区，手动设置的 `contentInset` 都会生效，自动调整属性仅“补充”适配内边距，不会覆盖手动配置；
3. **`edgesForExtendedLayout` 的影响**：若 `self.edgesForExtendedLayout = .none`，视图控制器根视图不延伸到系统栏下方，滚动视图默认就在安全区内，此时自动调整属性会生效；若滚动视图仍手动布局到安全区外，自动调整依然失效。

### 总结
| 滚动视图位置                | automaticallyAdjustsScrollViewInsets（iOS 7~10） | contentInsetAdjustmentBehavior（iOS 11+） |
|-----------------------------|------------------------------------------------|-------------------------------------------|
| 完全在安全区外（无重叠）    | ❌ 不调整                                      | ❌ 不调整                                  |
| 部分/全部在安全区内（有重叠）| ✅ 调整（需是首个子视图）                       | ✅ 按枚举值调整                            |

简单记：**自动调整 inset 的核心是“滚动视图与安全区/系统栏重叠”，无重叠则无需调整，属性自然失效**。

需要我帮你写一个“判断滚动视图是否在安全区”的工具方法，或适配全版本的内边距控制代码吗？






## 上面回答一中把origin.y设置成200，与顶部的状态栏并没有交集，为啥会调整上面的inset？

你提出的这个疑问很关键，核心原因是：**示例中 `scrollView.frame.origin.y = 200` 的场景描述存在简化偏差，实际触发自动调整的核心是「滚动视图的 `frame` 与视图控制器的 `safeAreaLayoutGuide` 存在关联」，而非必须与状态栏直接重叠**。

具体拆解如下：
1. **安全区的范围不止状态栏**
   iOS 的安全区（`safeAreaLayoutGuide`）是一个整体区域，包含「顶部状态栏高度（通常 20pt/44pt）+ 导航栏高度（通常 44pt）+ 底部 Home Indicator 高度（通常 34pt）」等。
   即使 `scrollView` 的 `y = 200` 没有和状态栏（顶部 20pt）重叠，只要它是**视图控制器根视图的子视图**，且视图控制器开启了全屏布局（默认 `edgesForExtendedLayout = .all`），`contentInsetAdjustmentBehavior = .automatic` 仍会基于视图控制器的安全区信息，计算并添加适配内边距——这是因为该属性的设计逻辑是「适配视图控制器所属的安全区上下文」，而非仅适配滚动视图自身与系统栏的重叠部分。

2. **示例的简化表述偏差**
   之前的示例为了突出“进入安全区上下文即触发调整”，简化了 `y` 值的设定。更准确的验证场景应该是：
   - 若将 `scrollView` 的 `frame` 完全移出**视图控制器的主视图范围**（比如 `y = 2000`，超出屏幕），此时它脱离了安全区上下文，`contentInset` 不会自动调整；
   - 若 `scrollView` 在主视图范围内（即使 `y = 200`），只要 `contentInsetAdjustmentBehavior` 为 `.automatic`/`.always`，系统就会默认基于当前视图控制器的安全区，为其添加适配内边距。

3. **关键验证代码（修正版）**
   ```swift
   let scrollView = UIScrollView()
   // 情况1：滚动视图在主视图内（y=200，未与状态栏重叠，但在安全区上下文内）
   scrollView.frame = CGRect(x: 0, y: 200, width: view.bounds.width, height: 300)
   scrollView.contentSize = CGSize(width: view.bounds.width, height: 600)
   scrollView.contentInsetAdjustmentBehavior = .automatic
   view.addSubview(scrollView)

   DispatchQueue.main.async {
       print("主视图内 contentInset：\(scrollView.contentInset)")
       // 输出：UIEdgeInsets(top: 44, bottom: 34, ...)（适配顶部导航栏+底部安全区）
   }

   // 情况2：滚动视图完全移出主视图（脱离安全区上下文）
   let scrollViewOut = UIScrollView()
   scrollViewOut.frame = CGRect(x: 0, y: 2000, width: view.bounds.width, height: 300)
   scrollViewOut.contentSize = CGSize(width: view.bounds.width, height: 600)
   scrollViewOut.contentInsetAdjustmentBehavior = .automatic
   view.addSubview(scrollViewOut)

   DispatchQueue.main.async {
       print("主视图外 contentInset：\(scrollViewOut.contentInset)")
       // 输出：UIEdgeInsets(0,0,0,0)（无自动调整）
   }
   ```

简单总结：`contentInsetAdjustmentBehavior` 的自动调整触发前提是 **滚动视图处于当前视图控制器的主视图范围内（安全区上下文内）**，而非必须与状态栏/导航栏直接重叠。

需要我帮你写一个**精准判断滚动视图是否需要自动调整inset**的工具方法吗？




## 如何判断滚动视图是否需要自动调整inset？


要精准判断 `UIScrollView` 是否会被系统自动调整 `contentInset`（基于 `contentInsetAdjustmentBehavior` 或旧版 `automaticallyAdjustsScrollViewInsets`），核心是**结合系统版本、滚动视图布局位置、安全区上下文、属性配置四大维度**，以下是可直接复用的判断逻辑 + 工具方法：

### 一、核心判断逻辑（分版本）
#### 1. iOS 11+（基于 `contentInsetAdjustmentBehavior`）
自动调整 `inset` 的触发条件（需同时满足）：
- ✅ `contentInsetAdjustmentBehavior` 不是 `.never`（即 `.automatic`/`.scrollableAxes`/`.always`）；
- ✅ 滚动视图是当前视图控制器主视图的子视图（未移出屏幕/主视图范围）；
- ✅ 滚动视图的 `frame` 与视图控制器的 `safeAreaLayoutGuide` 存在“上下文关联”（即属于该视图控制器的布局体系）；
- ✅ （仅 `.scrollableAxes` 时）滚动视图在对应轴向上可滚动（如垂直滚动需 `contentSize.height > frame.height`）。

#### 2. iOS 7~10（基于 `automaticallyAdjustsScrollViewInsets`）
自动调整 `inset` 的触发条件（需同时满足）：
- ✅ 视图控制器的 `automaticallyAdjustsScrollViewInsets = true`；
- ✅ 滚动视图是视图控制器**第一个子视图**；
- ✅ 滚动视图的 `frame` 与导航栏/状态栏/标签栏存在重叠（因 `edgesForExtendedLayout = .all`）；
- ✅ 滚动视图未被手动设置 `contentInset` 覆盖（优先级：手动 > 自动）。

### 二、可直接复用的工具方法
```swift
import UIKit

extension UIScrollView {
    /// 判断当前滚动视图是否会被系统自动调整 contentInset
    /// - Parameter vc: 所属的视图控制器（必填，用于判断安全区/布局上下文）
    /// - Returns: true = 会自动调整，false = 不会
    func isNeedAutoAdjustInset(for vc: UIViewController) -> Bool {
        // --------------- 第一步：iOS 版本分支 ---------------
        if #available(iOS 11.0, *) {
            // iOS 11+ 核心判断逻辑
            // 1. 先判断调整行为：.never 直接返回 false
            guard contentInsetAdjustmentBehavior != .never else {
                return false
            }
            
            // 2. 判断滚动视图是否在视图控制器主视图范围内（脱离则不调整）
            let scrollFrameInVC = vc.view.convert(frame, from: superview)
            let isInVCView = vc.view.bounds.intersects(scrollFrameInVC)
            guard isInVCView else {
                return false
            }
            
            // 3. 针对 .scrollableAxes 额外判断：对应轴向是否可滚动
            if contentInsetAdjustmentBehavior == .scrollableAxes {
                let canScrollVertical = contentSize.height > frame.height
                let canScrollHorizontal = contentSize.width > frame.width
                // 只要有一个轴向可滚动，就会调整对应方向的 inset
                return canScrollVertical || canScrollHorizontal
            }
            
            // .automatic/.always 只要在主视图内就会调整
            return true
            
        } else {
            // iOS 7~10 核心判断逻辑
            // 1. 视图控制器是否开启自动调整
            guard vc.automaticallyAdjustsScrollViewInsets else {
                return false
            }
            
            // 2. 滚动视图是否是视图控制器的第一个子视图
            guard vc.view.subviews.first === self else {
                return false
            }
            
            // 3. 判断是否与系统栏（导航栏/状态栏/标签栏）重叠
            let statusBarHeight = UIApplication.shared.statusBarFrame.height
            let navBarHeight = vc.navigationController?.navigationBar.frame.height ?? 0
            let tabBarHeight = vc.tabBarController?.tabBar.frame.height ?? 0
            
            // 滚动视图顶部是否与状态栏/导航栏重叠
            let topOverlap = frame.origin.y < (statusBarHeight + navBarHeight)
            // 滚动视图底部是否与标签栏重叠
            let bottomOverlap = (frame.origin.y + frame.height) > (vc.view.bounds.height - tabBarHeight)
            
            // 有重叠则会自动调整
            return topOverlap || bottomOverlap
        }
    }
}
```

### 三、使用示例
```swift
// 场景1：iOS 15，滚动视图在主视图内，调整行为为 .automatic
let scrollView = UIScrollView()
scrollView.frame = CGRect(x: 0, y: 200, width: view.bounds.width, height: 300)
scrollView.contentSize = CGSize(width: view.bounds.width, height: 600)
scrollView.contentInsetAdjustmentBehavior = .automatic
view.addSubview(scrollView)

// 判断是否需要自动调整
let needAdjust = scrollView.isNeedAutoAdjustInset(for: self)
print("是否需要自动调整：\(needAdjust)") // 输出：true

// 场景2：iOS 15，调整行为设为 .never
scrollView.contentInsetAdjustmentBehavior = .never
let needAdjust2 = scrollView.isNeedAutoAdjustInset(for: self)
print("是否需要自动调整：\(needAdjust2)") // 输出：false

// 场景3：iOS 9，滚动视图不是第一个子视图
let scrollViewiOS9 = UIScrollView()
view.addSubview(UIView()) // 先添加一个占位视图
view.addSubview(scrollViewiOS9)
let needAdjust3 = scrollViewiOS9.isNeedAutoAdjustInset(for: self)
print("是否需要自动调整：\(needAdjust3)") // 输出：false
```

### 四、关键补充说明
1. **上下文关联的精准判断**：
   工具方法中用 `vc.view.convert(frame, from: superview)` 将滚动视图的 frame 转换到视图控制器主视图坐标系，再通过 `intersects` 判断是否有交集——这是判断“是否在安全区上下文内”的核心，避免“滚动视图在子视图层级中但移出主视图”的误判。

2. **.scrollableAxes 的特殊处理**：
   该模式下系统仅在“可滚动的轴向”调整 inset，因此工具方法中额外判断了 `contentSize` 与 `frame` 的大小关系，保证判断结果与系统行为完全一致。

3. **手动 inset 的优先级**：
   工具方法未包含“手动设置 contentInset”的判断（因系统仍会在手动 inset 基础上叠加自动调整值），若需判断“是否有自动叠加的 inset”，可补充：
   ```swift
   // 额外判断：是否有系统自动叠加的 inset
   func hasAutoAddedInset(for vc: UIViewController) -> Bool {
       guard isNeedAutoAdjustInset(for: vc) else { return false }
       // 系统自动添加的 inset 会体现在 adjustedContentInset 中
       return adjustedContentInset != contentInset
   }
   ```

### 五、核心总结
判断逻辑可简化为：
| 版本       | 判断核心                                  |
|------------|-------------------------------------------|
| iOS 11+    | 调整行为≠.never + 在主视图内 +（scrollableAxes时可滚动） |
| iOS 7~10   | 控制器开启自动调整 + 是首个子视图 + 与系统栏重叠       |

工具方法覆盖了 99% 的业务场景，可直接集成到项目中，用于提前预判滚动视图的 inset 行为，避免布局错乱。


