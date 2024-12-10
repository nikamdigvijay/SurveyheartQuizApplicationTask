//
//  ResultViewController.swift
//  QuizApplication
//
//  Created by Apple on 06/12/24.
//

import UIKit

//MARK: - ResultViewController

class ResultViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var label_result: UILabel!
    @IBOutlet weak var label_heyCong: UILabel!
    @IBOutlet weak var button_backToHome: UIButton!
    @IBOutlet weak var imageView_trophy: UIImageView!
    
    
    //MARK: - Internal Properties
    var finalScore: Int = 0
    var totalQuestions: Int = 0
    
}
//MARK: - Life Cycle Methods
extension ResultViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialConfigurations()
    }
}

//MARK: - Initial Configurations
extension ResultViewController {
    func initialConfigurations() {
        self.configure_hideBackButton()
        self.configure_View()
        self.configure_Image()
        self.configure_label()
        self.configure_button()
    }
    
    //MARK: - Hide the Back Button
    func configure_hideBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    
    func configure_View() {
        self.view.backgroundColor = .black
    }
    
    func configure_Image() {
        self.imageView_trophy.image = UIImage(named: "trophyImg")
        self.imageView_trophy.contentMode = .scaleAspectFill
    }
    
    func configure_button() {
        self.button_backToHome.setTitle(quizScreenString.backToHome_text, for: .normal)
        self.button_backToHome.backgroundColor = .white
        self.button_backToHome.tintColor = .black
        self.button_backToHome.layer.cornerRadius = 10
    }
    
    func configure_label() {
        
        self.label_heyCong.text = "Hey,Congratulations"
        self.label_heyCong.font = UIFont.boldSystemFont(ofSize: 18)
        self.label_heyCong.textAlignment = .center
        self.label_heyCong.textColor = .yellow
        
        self.label_result.text = "Your Score is  \(finalScore) Out Of \(totalQuestions)"
        self.label_result.font = UIFont.boldSystemFont(ofSize: 24)
        self.label_result.textAlignment = .center
        self.label_result.textColor = .yellow
        
    }
}

//MARK: - IBActions
extension ResultViewController {
    
    @IBAction func button_BackToHome_clicked(_ sender: Any) {
        
        print("backToHome Button Clicked")
        navigationController?.popToRootViewController(animated: true)
        
    }
}

