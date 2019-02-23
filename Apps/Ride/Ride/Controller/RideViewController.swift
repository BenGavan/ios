

import UIKit

class RideViewController: UIViewController {
    
    
    let infoView = InfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        view.backgroundColor = .white
        
        view.addSubview(infoView)
        
        _ = infoView.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 200)
    }
}

class InfoView: UIView {
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0.0"
        label.textAlignment = .center
        return label
    }()
    
    let durrationLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0:00"
        label.textAlignment = .center
        return label
    }()
    
    let costLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "£0.00"
        label.textAlignment = .center
        return label
    }()
    
    let seperatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        _ = view.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0.5, heightConstant: 70)
        return view
    }()
    
    let startAndFinishButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(startAndFinish), for: .touchUpInside)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .yellow
     
        setUpInfoBar()
        
        self.addSubview(startAndFinishButton)
        
        _ = startAndFinishButton.anchor(labelStackView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 50, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
    }
    
    @objc func startAndFinish() {
        
        if (startAndFinishButton.titleLabel?.text == "Start") {
            
        }

    }
    
    var labelStackView = UIStackView()
    
    private func setUpInfoBar() {
        let distanceLabelContainerView = UIView()
        distanceLabelContainerView.backgroundColor = .white
        
        let durrationLabelContainerView = UIView()
        durrationLabelContainerView.backgroundColor = .white
        
        let costLabelContainerView = UIView()
        costLabelContainerView.backgroundColor = .white
        
        
        labelStackView = UIStackView(arrangedSubviews: [distanceLabelContainerView, seperatorLine, durrationLabelContainerView, seperatorLine, costLabelContainerView])
        labelStackView.axis = .horizontal
        labelStackView.distribution = .fillEqually
        
        self.addSubview(labelStackView)
        
        self.addSubview(distanceLabel)
        self.addSubview(durrationLabel)
        self.addSubview(costLabel)
        
        _ = labelStackView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 4, rightConstant: 0, widthConstant: 0, heightConstant: 70)
        
        _ = distanceLabel.anchor(distanceLabelContainerView.topAnchor, left: distanceLabelContainerView.leftAnchor, bottom: distanceLabelContainerView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        
        _ = durrationLabel.anchor(durrationLabelContainerView.topAnchor, left: durrationLabelContainerView.leftAnchor, bottom: durrationLabelContainerView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        
        _ = costLabel.anchor(costLabelContainerView.topAnchor, left: costLabelContainerView.leftAnchor, bottom: costLabelContainerView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
