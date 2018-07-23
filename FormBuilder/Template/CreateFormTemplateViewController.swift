//
//  CreateFormTemplateViewController.swift
//  FormBuilder
//
//  Created by daqian zeng on 2018/7/10.
//  Copyright © 2018年 zengdaqian. All rights reserved.
//

import UIKit
import Eureka

class CreateFormTemplateViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
    @IBAction func cancleAction(_ sender: Any) {
        dismiss(animated: true) {
            
        }
    }
    
}

class _CreateFormTemplateViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        form
            +++ Section(header: "基本信息", footer: "打*号的为必填项，请完整填写")
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
