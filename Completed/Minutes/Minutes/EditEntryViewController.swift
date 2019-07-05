import Foundation
import UIKit

//
// Added to test crash reporting, then removed after testing completed
//
//import AppCenterCrashes

import AppCenterAnalytics

class EditEntryViewController: UIViewController
{
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    var entry: Entry? = nil
    
    override func viewDidLoad()
    {
        MSAnalytics.trackEvent("My custom event")
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(EditEntryViewController.onSave))

        navigationItem.rightBarButtonItem = saveButton

        if entry == nil
        {
            entry = Entry()
            self.title = "Add New Entry"
        }
        else
        {
            //
            // Added to test custom analytics event
            //
            let time = -((entry?.createdDate.timeIntervalSinceNow)!)
            let interval = String(format: "%.0f", time)
            
            let properties = ["id": entry!.id, "time": interval]
            
            MSAnalytics.trackEvent("EditEntry", withProperties: properties)
        }

        titleTextField.text = entry?.title
        contentTextView.text = entry?.content
    }

    @objc func onSave(_ sender: UIBarButtonItem)
    {
        //
        // Added to test crash reporting, then removed after testing completed
        //
        //MSCrashes.generateTestCrash()
                
        entry?.title = titleTextField.text!
        entry?.content = contentTextView.text!
        
        AppDelegate.entries.write(entry!)
                
        navigationController?.popViewController(animated: true)
    }
}
