import UIKit
import XCTest
import RMB

class Tests: XCTestCase {
    
    func testOnlyIntegerPart() {
        XCTAssertEqual(convertNumberToAmountOfRMB(15508), "壹万伍仟伍佰零捌元整")
        XCTAssertEqual(convertNumberToAmountOfRMB(10003), "壹万零叁元整")
        XCTAssertEqual(convertNumberToAmountOfRMB(108000), "壹拾万捌仟元整")
        XCTAssertEqual(convertNumberToAmountOfRMB(35680), "叁万伍仟陆佰捌拾元整")
        XCTAssertEqual(convertNumberToAmountOfRMB(2308), "贰仟叁佰零捌元整")
        XCTAssertEqual(convertNumberToAmountOfRMB(2008), "贰仟零捌元整")
        XCTAssertEqual(convertNumberToAmountOfRMB(10038), "壹万零叁拾捌元整")
        XCTAssertEqual(convertNumberToAmountOfRMB(10000), "壹万元整")
        XCTAssertEqual(convertNumberToAmountOfRMB(1200400), "壹佰贰拾万零肆佰元整")
        XCTAssertEqual(convertNumberToAmountOfRMB(1024000), "壹佰零贰万肆仟元整")
        XCTAssertEqual(convertNumberToAmountOfRMB(300000030), "叁亿零叁拾元整")
        XCTAssertEqual(convertNumberToAmountOfRMB(1020004356), "壹拾亿贰仟万肆仟叁佰伍拾陆元整")
        XCTAssertEqual(convertNumberToAmountOfRMB(10204356), "壹仟零贰拾万肆仟叁佰伍拾陆元整")
        XCTAssertEqual(convertNumberToAmountOfRMB(1024356), "壹佰零贰万肆仟叁佰伍拾陆元整")
        
    }
    
    func testVeryBigNumber(){
        XCTAssertEqual(convertNumberToAmountOfRMB(4000000000000), "肆万亿元整")
    }
    
    func testTenMillionZero(){
        XCTAssertEqual(convertNumberToAmountOfRMB(102004356), "壹亿零贰佰万肆仟叁佰伍拾陆元整")
    }
    
    func testOnlyDecimalPart(){
        XCTAssertEqual(convertNumberToAmountOfRMB(0.99), "玖角玖分")
        XCTAssertEqual(convertNumberToAmountOfRMB(0.09), "玖分")
    }
    
    func testMixedNumber(){
        XCTAssertEqual(convertNumberToAmountOfRMB(10300.05), "壹万零叁佰元零伍分")
        XCTAssertEqual(convertNumberToAmountOfRMB(130.05), "壹佰叁拾元零伍分")
        XCTAssertEqual(convertNumberToAmountOfRMB(13.06), "壹拾叁元零陆分")
        XCTAssertEqual(convertNumberToAmountOfRMB(3.58), "叁元伍角捌分")
        XCTAssertEqual(convertNumberToAmountOfRMB(9.7), "玖元柒角")
        XCTAssertEqual(convertNumberToAmountOfRMB(1234567890.08),"壹拾贰亿叁仟肆佰伍拾陆万柒仟捌佰玖拾元零捌分")
    }
    
}
