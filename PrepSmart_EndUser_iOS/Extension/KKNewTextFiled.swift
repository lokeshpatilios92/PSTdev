//
//  KKNewTextFiled.swift
//  SotsTag
//
//  Created by Kaustubh Kulkarni on 08/03/19.
//  Copyright © 2019 Etpl-Mac. All rights reserved.
//
import UIKit
@IBDesignable

@objc open class KKNEWTextFiled: UITextField
{
    fileprivate var bottomLineView : UIView?
    fileprivate var labelPlaceholder : UILabel?
    //    fileprivate var labelErrorPlaceholder : UILabel?
    fileprivate var showingError : Bool = false
    
    fileprivate var bottomLineViewHeight : NSLayoutConstraint?
    fileprivate var placeholderLabelHeight : NSLayoutConstraint?
    //    fileprivate var errorLabelHieght : NSLayoutConstraint?
    
    /// Disable Floating Label when true.
    @IBInspectable open var disableFloatingLabel : Bool = false
    
    /// Shake Bottom line when Showing Error ?
    @IBInspectable open var shakeLineWithError : Bool = true
    
    /// Change Bottom Line Color.
    @IBInspectable open var lineColor : UIColor = UIColor.black {
        didSet{
            self.floatTheLabel()
        }
    }
    
    /// Change line color when Editing in textfield
    @IBInspectable open var selectedLineColor : UIColor = UIColor.placeholderColor(){
        didSet
        {
            self.floatTheLabel()
        }
    }
    
    /// Change placeholder color.
    @IBInspectable open var placeHolderColor : UIColor = UIColor.placeholderColor() {
        didSet
        {
            self.floatTheLabel()
        }
    }
    
    /// Change placeholder color while editing.
    @IBInspectable open var selectedPlaceHolderColor : UIColor = UIColor.placeholderColor() {
        didSet
        {
            self.floatTheLabel()
        }
    }
    
    /// Change Error Text color.
    @IBInspectable open var errorTextColor : UIColor = UIColor.red{
        didSet
        {
            //            self.labelErrorPlaceholder?.textColor = errorTextColor
            self.floatTheLabel()
        }
    }
    
    /// Change Error Line color.
    @IBInspectable open var errorLineColor : UIColor = UIColor.red{
        didSet
        {
            self.floatTheLabel()
        }
    }
    
    //MARK:- Set Text
    override open var text:String?  {
        didSet {
            if showingError
            {
                //                self.hideErrorPlaceHolder()
            }
            floatTheLabel()
        }
    }
    
    override open var placeholder: String? {
        willSet
        {
            if newValue != ""
            {
                self.labelPlaceholder?.text = newValue
            }
        }
    }
    
    open var errorText : String? {
        willSet
        {
            //            self.labelErrorPlaceholder?.text = newValue
        }
    }
    
    //MARK:- UITtextfield Draw Method Override
    override open func draw(_ rect: CGRect)
    {
        super.draw(rect)
        self.upadteTextField(frame: CGRect(x:self.frame.minX, y:self.frame.minY, width:rect.width, height:rect.height));
    }
    
    // MARK:- Loading From NIB
    override open func awakeFromNib()
    {
        super.awakeFromNib()
        self.initialize()
    }
    
    // MARK:- Intialization
    override public init(frame: CGRect)
    {
        super.init(frame: frame)
        self.initialize()
    }
    
    required public init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        self.initialize()
    }
    
    // MARK:- Text Rect Management
    override open func textRect(forBounds bounds: CGRect) -> CGRect
    {
        return CGRect(x:4, y:4, width:bounds.size.width, height:bounds.size.height);
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect
    {
        return CGRect(x:4, y:4, width:bounds.size.width, height:bounds.size.height);
    }
    
    //MARK:- UITextfield Becomes First Responder
    override open func becomeFirstResponder() -> Bool
    {
        let result = super.becomeFirstResponder()
        self.textFieldDidBeginEditing()
        return result
    }
    
    //MARK:- UITextfield Resigns Responder
    override open func resignFirstResponder() -> Bool
    {
        let result =  super.resignFirstResponder()
        self.textFieldDidEndEditing()
        return result
    }
    
    //MARK:- Show Error Label
    public func showError()
    {
        showingError = true;
        self.showErrorPlaceHolder();
    }
    public func hideError()
    {
        showingError = false;
        //        self.hideErrorPlaceHolder();
        floatTheLabel()
    }
    
    public func showErrorWithText(errorText : String)
    {
        self.errorText = errorText;
        //        self.labelErrorPlaceholder?.text = self.errorText
        showingError = true;
        self.showErrorPlaceHolder();
    }
}

fileprivate extension KKNEWTextFiled
{
    
    //MARK:- ACFLoating Initialzation.
    func initialize() -> Void {
        
        //        self.clearButtonMode = .always
        self.clipsToBounds = true
        /// Adding Bottom Line
        addBottomLine()
        
        /// Placeholder Label Configuration.
        addFloatingLabel()
        
        /// Error Placeholder Label Configuration.
        //        addErrorPlaceholderLabel()
        /// Checking Floatibility
        if self.text != nil && self.text != "" {
            self.floatTheLabel()
        }
        
        //        self.initializeSideImage("", rightImageName: "")
    }
    
    //MARK:- ADD Bottom Line
    func addBottomLine(){
        
        if bottomLineView?.superview != nil {
            return
        }
        
        //Bottom Line UIView Configuration.
        bottomLineView = UIView()
        bottomLineView?.backgroundColor = lineColor
        bottomLineView?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomLineView!)
        
        let leadingConstraint = NSLayoutConstraint.init(item: bottomLineView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint.init(item: bottomLineView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint.init(item: bottomLineView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        bottomLineViewHeight = NSLayoutConstraint.init(item: bottomLineView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)
        
        self.addConstraints([leadingConstraint,trailingConstraint,bottomConstraint])
        bottomLineView?.addConstraint(bottomLineViewHeight!)
        
        self.addTarget(self, action: #selector(self.textfieldEditingChanged), for: .editingChanged)
    }
    
    @objc func textfieldEditingChanged(){
        if showingError {
            hideError()
        }
    }
    
    //MARK:- ADD Floating Label
    func addFloatingLabel(){
        
        if labelPlaceholder?.superview != nil {
            return
        }
        
        var placeholderText : String? = labelPlaceholder?.text
        if self.placeholder != nil && self.placeholder != "" {
            placeholderText = self.placeholder!
        }
        labelPlaceholder = UILabel()
        labelPlaceholder?.text = placeholderText
        labelPlaceholder?.textAlignment = self.textAlignment
        labelPlaceholder?.textColor = placeHolderColor
        labelPlaceholder?.font = UIFont.init(name: (self.font?.fontName ?? "helvetica")!, size: 12)
        labelPlaceholder?.isHidden = true
        labelPlaceholder?.sizeToFit()
        labelPlaceholder?.translatesAutoresizingMaskIntoConstraints = false
        self.setValue(placeHolderColor, forKeyPath: "placeholderLabel.textColor")
        if labelPlaceholder != nil {
            self.addSubview(labelPlaceholder!)
        }
        let leadingConstraint = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 4)
        let trailingConstraint = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 5)
        let topConstraint = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        //let bottomConstraint = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 5)
        placeholderLabelHeight = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        
        self.addConstraints([leadingConstraint,trailingConstraint,topConstraint])//,bottomConstraint])
        labelPlaceholder?.addConstraint(placeholderLabelHeight!)
        
    }

    func showErrorPlaceHolder() {
        
        bottomLineViewHeight?.constant = 2;
        
        if self.errorText != nil && self.errorText != "" {
            //            errorLabelHieght?.constant = 15;
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.bottomLineView?.backgroundColor = self.errorLineColor;
                self.layoutIfNeeded()
            }, completion: nil)
        }else{
            //            errorLabelHieght?.constant = 0;
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.bottomLineView?.backgroundColor = self.errorLineColor;
                self.layoutIfNeeded()
            }, completion: nil)
        }
        
        if shakeLineWithError {
            bottomLineView?.shake()
        }
        
    }
    
    func hideErrorPlaceHolder(){
        showingError = false;
        
        if errorText == nil || errorText == "" {
            return
        }
        
        //        errorLabelHieght?.constant = 0;
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    //MARK:- Float & Resign
    func floatTheLabel() -> Void {
        DispatchQueue.main.async {
            if self.text == "" && self.isFirstResponder {
                self.floatPlaceHolder(selected: true)
            }else if self.text == "" && !self.isFirstResponder {
                self.resignPlaceholder()
            }else if self.text != "" && !self.isFirstResponder  {
                self.floatPlaceHolder(selected: false)
            }else if self.text != "" && self.isFirstResponder {
                self.floatPlaceHolder(selected: true)
            }
        }
    }
    
    //MARK:- Upadate and Manage Subviews
    func upadteTextField(frame:CGRect) -> Void {
        self.frame = frame;
        self.initialize()
    }
    
    //MARK:- Float UITextfield Placeholder Label
    func floatPlaceHolder(selected:Bool) -> Void {
        
        labelPlaceholder?.isHidden = false
        if selected {
            
            bottomLineView?.backgroundColor = showingError ? self.errorLineColor : self.selectedLineColor;
            labelPlaceholder?.textColor = self.selectedPlaceHolderColor;
            bottomLineViewHeight?.constant = 2;
            self.setValue(self.selectedPlaceHolderColor, forKeyPath: "placeholderLabel.textColor")
            
        } else {
            bottomLineView?.backgroundColor = showingError ? self.errorLineColor : self.lineColor;
            bottomLineViewHeight?.constant = 1;
            self.labelPlaceholder?.textColor = self.placeHolderColor
            self.setValue(placeHolderColor, forKeyPath: "placeholderLabel.textColor")
        }
        
        if disableFloatingLabel == true {
            labelPlaceholder?.isHidden = true
            return
        }
        
        if placeholderLabelHeight?.constant == 15 {
            return
        }
        
        placeholderLabelHeight?.constant = 15;
        labelPlaceholder?.font = UIFont(name: (self.font?.fontName)!, size: 12)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.layoutIfNeeded()
        })
        
    }
    
    //MARK:- Resign the Placeholder
    func resignPlaceholder() -> Void {
        
        self.setValue(self.placeHolderColor, forKeyPath: "placeholderLabel.textColor")
        
        bottomLineView?.backgroundColor = showingError ? self.errorLineColor : self.lineColor;
        bottomLineViewHeight?.constant = 1;
        
        if disableFloatingLabel {
            
            labelPlaceholder?.isHidden = true
            self.labelPlaceholder?.textColor = self.placeHolderColor;
            UIView.animate(withDuration: 0.2, animations: {
                self.layoutIfNeeded()
            })
            return
        }
        
        placeholderLabelHeight?.constant = self.frame.height
        
        UIView.animate(withDuration: 0.3, animations: {
            self.labelPlaceholder?.font = self.font
            self.labelPlaceholder?.textColor = self.placeHolderColor
            self.layoutIfNeeded()
        }) { (finished) in
            self.labelPlaceholder?.isHidden = true
            self.placeholder = self.labelPlaceholder?.text
        }
    }
    
    //MARK:- UITextField Begin Editing.
    func textFieldDidBeginEditing() -> Void {
        if showingError {
            //            self.hideErrorPlaceHolder()
        }
        if !self.disableFloatingLabel {
            self.placeholder = ""
        }
        self.floatTheLabel()
        self.layoutSubviews()
    }
    
    //MARK:- UITextField Begin Editing.
    func textFieldDidEndEditing() -> Void {
        self.floatTheLabel()
    }
    
    public func setLeftImageView(_ imageName:String)
    {
        let leftView:UIImageView = UIImageView(frame: CGRect(x: 0, y: self.frame.size.height - Constants.LEFT_VIEW_WIDTH , width: Constants.LEFT_VIEW_WIDTH , height: Constants.LEFT_VIEW_WIDTH))
        leftView.image = UIImage(named:imageName)
        leftView.contentMode = .scaleAspectFit //Center//
        
        self.leftViewMode = .always
        self.leftView = leftView
    }
    
    public func setRightImageView(_ imageName:String)
    {
        let leftView:UIImageView = UIImageView(frame: CGRect(x: 0, y: self.frame.size.height - Constants.LEFT_VIEW_WIDTH , width: Constants.LEFT_VIEW_WIDTH , height: Constants.LEFT_VIEW_WIDTH))
        leftView.image = UIImage(named:imageName)
        leftView.contentMode = .scaleAspectFit //Center//
        
        self.rightViewMode = .always
        self.rightView = leftView
    }
}
