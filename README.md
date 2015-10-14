# RMB

[![CI Status](http://img.shields.io/travis/banxi1988/RMB.svg?style=flat)](https://travis-ci.org/banxi1988/RMB)
[![Version](https://img.shields.io/cocoapods/v/RMB.svg?style=flat)](http://cocoapods.org/pods/RMB)
[![License](https://img.shields.io/cocoapods/l/RMB.svg?style=flat)](http://cocoapods.org/pods/RMB)
[![Platform](https://img.shields.io/cocoapods/p/RMB.svg?style=flat)](http://cocoapods.org/pods/RMB)

## 用法

### 安装

1. 使用 CocoasPods。

```Ruby
pod "RMB"
```

 2. 手动，将项目的 RMB.swift 文件添加到你的项目中。


### 使用

可以通过查看测试用例，如下，对它就是这样使用的。
如果是使用 pod 安装，先导入： `import RMB` 
   
```Swift
    XCTAssertEqual(convertNumberToAmountOfRMB(10300.05), "壹万零叁佰元零伍分")
    XCTAssertEqual(convertNumberToAmountOfRMB(130.05), "壹佰叁拾元零伍分")
    XCTAssertEqual(convertNumberToAmountOfRMB(13.06), "壹拾叁元零陆分")
    XCTAssertEqual(convertNumberToAmountOfRMB(3.58), "叁元伍角捌分")
    XCTAssertEqual(convertNumberToAmountOfRMB(9.7), "玖元柒角")
    XCTAssertEqual(convertNumberToAmountOfRMB(1234567890.08),"壹拾贰亿叁仟肆佰伍拾陆万柒仟捌佰玖拾元零捌分")
```



## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

RMB is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "RMB"
```

## Author

banxi1988, banxi1988@gmail.com

## License

RMB is available under the MIT license. See the LICENSE file for more info.


