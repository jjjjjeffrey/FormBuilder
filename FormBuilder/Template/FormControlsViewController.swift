//
//  FormControlsViewController.swift
//  FormBuilder
//
//  Created by daqian zeng on 2018/7/19.
//  Copyright © 2018年 zengdaqian. All rights reserved.
//

import UIKit
import Eureka

class FormControlsViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        form +++ Section("文本输入框")
            
            <<< LabelRow () {
                $0.title = "输入框"
                $0.value = "用于字符串输入"
            }
        
        form +++ Section("日期时间")
        
            <<< LabelRow () {
                $0.title = "日期"
                $0.value = "2018-01-01"
            }
            <<< LabelRow () {
                $0.title = "日期时间"
                $0.value = "2018-01-01 09:00"
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
