
import UIKit

class DrawExamples: UIView {

    
    override func draw(_ rect: CGRect) {
        // context is hte object used for drawing
        let context = UIGraphicsGetCurrentContext()
        
        let testImage = UIImage(named: "Dedication")
        
        //fill screen (with image)
        let entireScreen = UIScreen.main.bounds
        testImage?.draw(in: entireScreen)
        
        //Draw image to screen
        let location = CGPoint(x: 25, y: 25)
        testImage?.draw(at: location)
        
        
        
        
//        context!.setLineWidth(3.0)
//        context!.setStrokeColor(UIColor.blue.cgColor)
        
       //Create path //Create straight line
//        context!.move(to: CGPoint(x: 10, y: 15))    //can use CGPoint(x,y) or CGPoint.init(x,y)
//        context!.addLine(to: CGPoint.init(x: 300, y: 500))
        
         /*Random 4 vertice shape
        context!.move(to: CGPoint.init(x: 50, y: 50))
        context!.addLine(to: CGPoint.init(x: 90, y:130))
        context!.addLine(to: CGPoint.init(x: 180, y:100))
        context!.addLine(to: CGPoint.init(x: 90, y:90))
        context!.addLine(to: CGPoint.init(x: 50, y:50))
        */
    
        
        //Rectangle
        /*let rectangle = CGRect(x: 50, y: 50, width: 200, height: 400)
        context?.addRect(rectangle)
        */

        //fill in path
//        context?.fillPath()//need to research/look up
        
        
        //Draw path
//        context?.strokePath()
    }
    

}
