//
//  AddRecipeViewController.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 10/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class AddRecipeViewController: BaseViewController {

    @IBOutlet weak var view_information: UIView!
    @IBOutlet weak var view_ingredients: UIView!
    @IBOutlet weak var view_pictures: UIView!
    @IBOutlet weak var imgView_done_info: UIImageView!
    @IBOutlet weak var imgView_done_instruction: UIImageView!
    @IBOutlet weak var imgView_done_pictures: UIImageView!
    @IBOutlet weak var view_container: UIView!
    @IBOutlet weak var btn_recipeInfo: UIButton!
    @IBOutlet weak var btn_instructions: UIButton!
    @IBOutlet weak var btn_pictures: UIButton!
    
    var infoView : UIView?
    var instructionView : UIView?
    var pictureView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialize()
        
    }

    func initialize()
    {
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Add Recipe")
        
        imgView_done_info.isHidden = true
        imgView_done_instruction.isHidden = true
        imgView_done_pictures.isHidden = true
        
        view_information.layer.cornerRadius = 4.0
        view_information.clipsToBounds = true
        
        view_ingredients.layer.cornerRadius = 4.0
        view_ingredients.clipsToBounds = true
        
        view_pictures.layer.cornerRadius = 4.0
        view_pictures.clipsToBounds = true
        
        addViewsInContainer()
    }
    
    func addViewsInContainer()
    {
        //RecipeInfoViewController
        let recipeInfoVC = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "RecipeInfoViewController") as! RecipeInfoViewController
        recipeInfoVC.customDelegate = self
        addChild(recipeInfoVC)
        infoView = recipeInfoVC.view
        recipeInfoVC.view.translatesAutoresizingMaskIntoConstraints = false
        view_container.addSubview(recipeInfoVC.view)
        
        NSLayoutConstraint.activate([
            recipeInfoVC.view.leadingAnchor.constraint(equalTo: view_container.leadingAnchor, constant: 0),
            recipeInfoVC.view.trailingAnchor.constraint(equalTo: view_container.trailingAnchor, constant: 0),
            recipeInfoVC.view.topAnchor.constraint(equalTo: view_container.topAnchor, constant: 0),
            recipeInfoVC.view.bottomAnchor.constraint(equalTo: view_container.bottomAnchor, constant: 0)
            ])
        
         recipeInfoVC.didMove(toParent: self)
        
        //InstructionsViewController
        let instructionsVC = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "InstructionsViewController") as! InstructionsViewController
        addChild(instructionsVC)
        instructionsVC.customDelegate = self
        instructionView = instructionsVC.view
        instructionsVC.view.translatesAutoresizingMaskIntoConstraints = false
        view_container.addSubview(instructionsVC.view)
        
        NSLayoutConstraint.activate([
            instructionsVC.view.leadingAnchor.constraint(equalTo: view_container.leadingAnchor, constant: 0),
            instructionsVC.view.trailingAnchor.constraint(equalTo: view_container.trailingAnchor, constant: 0),
            instructionsVC.view.topAnchor.constraint(equalTo: view_container.topAnchor, constant: 0),
            instructionsVC.view.bottomAnchor.constraint(equalTo: view_container.bottomAnchor, constant: 0)
            ])
        
        instructionsVC.didMove(toParent: self)
        
        view_container.bringSubviewToFront(infoView!)
        
        //PicturesAndVideoViewController
        let picturesVC = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "PicturesAndVideoViewController") as! PicturesAndVideoViewController
        addChild(picturesVC)
        picturesVC.customDelegate = self
        pictureView = picturesVC.view
        picturesVC.view.translatesAutoresizingMaskIntoConstraints = false
        view_container.addSubview(picturesVC.view)
        
        NSLayoutConstraint.activate([
            picturesVC.view.leadingAnchor.constraint(equalTo: view_container.leadingAnchor, constant: 0),
            picturesVC.view.trailingAnchor.constraint(equalTo: view_container.trailingAnchor, constant: 0),
            picturesVC.view.topAnchor.constraint(equalTo: view_container.topAnchor, constant: 0),
            picturesVC.view.bottomAnchor.constraint(equalTo: view_container.bottomAnchor, constant: 0)
            ])
        
        picturesVC.didMove(toParent: self)
        
        view_container.bringSubviewToFront(infoView!)
    }
    
    @IBAction func onClickChangeTab(_ sender: UIButton) {
    
        if sender == btn_recipeInfo
        {
            view_information.backgroundColor = UIColor.appOrangeColor()
            view_ingredients.backgroundColor = UIColor.init(white: 1.0, alpha: 0.3)
            view_pictures.backgroundColor = UIColor.init(white: 1.0, alpha: 0.3)
            
            UIView.transition(with: view_container, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.view_container.bringSubviewToFront(self.infoView!)
            }, completion: nil)
        }
        else if sender == btn_instructions
        {
            view_ingredients.backgroundColor = UIColor.appOrangeColor()
            view_information.backgroundColor = UIColor.init(white: 1.0, alpha: 0.3)
            view_pictures.backgroundColor = UIColor.init(white: 1.0, alpha: 0.3)
            
            UIView.transition(with: view_container, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.view_container.bringSubviewToFront(self.instructionView!)
            }, completion: nil)
        }
        else if sender == btn_pictures
        {
            view_pictures.backgroundColor = UIColor.appOrangeColor()
            view_information.backgroundColor = UIColor.init(white: 1.0, alpha: 0.3)
            view_ingredients.backgroundColor = UIColor.init(white: 1.0, alpha: 0.3)
            UIView.transition(with: view_container, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.view_container.bringSubviewToFront(self.pictureView!)
            }, completion: nil)
        }
    }
    
}

extension AddRecipeViewController : RecipeInfoDelegate
{
    func onClickNextButton() {
        view_ingredients.backgroundColor = UIColor.appOrangeColor()
        view_information.backgroundColor = UIColor.init(white: 1.0, alpha: 0.3)
        view_pictures.backgroundColor = UIColor.init(white: 1.0, alpha: 0.3)
        
        UIView.transition(with: view_container, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.view_container.bringSubviewToFront(self.instructionView!)
        }, completion: nil)
    }
}

extension AddRecipeViewController : InstructionsViewControllerDelegate
{
    func onClickInstructionNextButton() {
        view_pictures.backgroundColor = UIColor.appOrangeColor()
        view_information.backgroundColor = UIColor.init(white: 1.0, alpha: 0.3)
        view_ingredients.backgroundColor = UIColor.init(white: 1.0, alpha: 0.3)
        
        UIView.transition(with: view_container, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.view_container.bringSubviewToFront(self.pictureView!)
        }, completion: nil)
    }
    
    func onClickInstructionBacktButton() {
        view_information.backgroundColor = UIColor.appOrangeColor()
        view_ingredients.backgroundColor = UIColor.init(white: 1.0, alpha: 0.3)
        view_pictures.backgroundColor = UIColor.init(white: 1.0, alpha: 0.3)
        
        UIView.transition(with: view_container, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.view_container.bringSubviewToFront(self.infoView!)
        }, completion: nil)
    }
}

extension AddRecipeViewController : PicturesAndVideoViewControllerDelegate
{
    func onClickCreateButton() {
        
    }
    
    func onClickPicturesBackButton() {
        view_ingredients.backgroundColor = UIColor.appOrangeColor()
        view_information.backgroundColor = UIColor.init(white: 1.0, alpha: 0.3)
        view_pictures.backgroundColor = UIColor.init(white: 1.0, alpha: 0.3)
        
        UIView.transition(with: view_container, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.view_container.bringSubviewToFront(self.instructionView!)
        }, completion: nil)
    }
}
