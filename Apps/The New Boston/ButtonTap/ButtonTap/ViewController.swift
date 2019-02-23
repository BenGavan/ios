
import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var testLabel: UILabel!
    
    @IBAction func buttonPressed(sender: UIButton) {
        
        let title = sender.title(for: .normal)!
        
        testLabel.text = "You clicked the \(title) button"
        
        
        
    }
    


}

