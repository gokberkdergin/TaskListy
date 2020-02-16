

import UIKit

@available(iOS 10.0, *)
class ToDoDetailsViewController: UIViewController {
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    
    @IBOutlet weak var taskDetailsTextView: UITextView!
    
    @IBOutlet weak var taskCompletionButton: UIButton!
    
    @IBOutlet weak var taskCompletionDate: UILabel!
    
    weak var delegate: ToDoListDelegate?
    
    var toDoItem: ToDoItem!
    
    var toDoIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        taskTitleLabel.text = toDoItem.name
        
        taskDetailsTextView.text = toDoItem.details
        
        if toDoItem.isComplete {
            
            disableButton()
            
        }
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMM dd, yyyy hh:mm"
        
        let taskDate = formatter.string(from: toDoItem.completionDate!)
        
        taskCompletionDate.text = taskDate
        
    }
    
    func disableButton() {
        
        taskCompletionButton.backgroundColor = UIColor.gray
        
        taskCompletionButton.isEnabled = false
        
    }
    
    @IBAction func taskDidComplete(_ sender: Any) {
        
        let alert = UIAlertController(title: "Confirm", message: "Did you complete the task?", preferredStyle: .alert)
        
        let okay = UIAlertAction(title: "Yes!", style: .default) { (okay) in
            self.completeTask(alert: alert)
        }
        
        let cancel = UIAlertAction(title: "No", style: .cancel) { (cancel) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okay)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    
    func completeTask(alert : UIAlertController) {
        
        toDoItem.isComplete = true
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()

        delegate?.update()
        
        disableButton()
        
    }
    

}
