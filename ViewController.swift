import UIKit


struct rgb {
    var Average = [CGFloat](count: 24, repeatedValue: 0)
}

class ColorFilter: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var Filterbtn1: UIButton!
    @IBOutlet var Filterbtn2: UIButton!
    @IBOutlet var Filterbtn3: UIButton!
    @IBOutlet var Filterbtn4: UIButton!
    @IBOutlet var Filterbtn5: UIButton!
    @IBOutlet var Filterbtn6: UIButton!
    @IBOutlet var FilterView: UIImageView!
    @IBOutlet var MainView: UIImageView!
    @IBOutlet var Average: UIImageView!
    @IBOutlet var Red: UIImageView!
    @IBOutlet var bright: UIImageView!
    @IBOutlet var Dark: UIImageView!
    @IBOutlet var Green: UIImageView!
    @IBOutlet var Blue: UIImageView!
    var image = UIImage()
    var ciImage: CIImage?
    
    var defaultHue: Float = 205 //default color of blue truck
    var hueRange: Float = 80//hue angle that we want to replace
    
    struct rgb {
        var red : Float
        var blue : Float
        var green : Float
    }
    
    override func viewDidLoad() {
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    @IBAction func Button(sender: AnyObject) {
        image = MainView.image!
        let imageSelected = MainView.image
        var colors = image.dominantColors()
        
        FilterView.backgroundColor = UIColor(red:0 , green: 0, blue: 0, alpha: 0)
        
        ciImage = CIImage(image: image)
        
        //MainView.image = UIImage(imageLiteral: "IMG_8847")
        //image = UIImage(imageLiteral: "IMG_8847")
      
        
        
        colors = image.dominantColors()
        var red = UIColor()
        red = colors[0].CIColor.red
        
        
        Average.hidden = false
        Average.alpha = 1.0
        Average.backgroundColor = colors[0]
        
        Red.hidden = false
        Red.alpha = 1.0
        Red.backgroundColor = colors[1]
        
        Blue.hidden = false
        Blue.alpha = 1.0
        Blue.backgroundColor = colors[2]
        
        Green.hidden = false
        Green.alpha = 1.0
        Green.backgroundColor = colors[3]
       
        Dark.hidden = false
        Dark.alpha = 1.0
        Dark.backgroundColor = colors[4]
        
        bright.hidden = false
        bright.alpha = 1.0
        bright.backgroundColor = colors[5]
        
        
        
        
        
        
    }
    @IBAction func ButtonPhotoLibrary(sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .PhotoLibrary
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        MainView.image = selectedImage
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func Filter1(sender: AnyObject) {
        let colors = image.dominantColors()
        FilterView.hidden = false
        FilterView.alpha = 0.2
        FilterView.backgroundColor = colors[0]
        
        render()
    }
    @IBAction func Filter2(sender: AnyObject) {
        let colors = image.dominantColors()
        FilterView.hidden = false
        FilterView.alpha = 0.2
        FilterView.backgroundColor = colors[1]
    }
    @IBAction func Filter3(sender: AnyObject) {
        let colors = image.dominantColors()
        FilterView.hidden = false
        FilterView.alpha = 0.2
        FilterView.backgroundColor = colors[2]
    }
    @IBAction func Filter4(sender: AnyObject) {
        let colors = image.dominantColors()
        FilterView.hidden = false
        FilterView.alpha = 0.2
        FilterView.backgroundColor = colors[3]
        
    }
    @IBAction func Filter5(sender: AnyObject) {
        let colors = image.dominantColors()
        FilterView.hidden = false
        FilterView.alpha = 0.2
        FilterView.backgroundColor = colors[4]
    }
    @IBAction func Filter6(sender: AnyObject) {
        let colors = image.dominantColors()
        FilterView.hidden = false
        FilterView.alpha = 0.2
        FilterView.backgroundColor = colors[5]
    }
    @IBAction func original(sender: AnyObject) {
        
        FilterView.hidden = false
        FilterView.alpha = 0.2
        FilterView.backgroundColor = UIColor(red:0 , green: 0, blue: 0, alpha: 0)
    }
    
    
    func HSVtoRGB(h : Float, s : Float, v : Float) -> (r : Float, g : Float, b : Float) {
        var r : Float = 0
        var g : Float = 0
        var b : Float = 0
        let C = s * v
        let HS = h * 6.0
        let X = C * (1.0 - fabsf(fmodf(HS, 2.0) - 1.0))
        if (HS >= 0 && HS < 1) {
            r = C
            g = X
            b = 0
        } else if (HS >= 1 && HS < 2) {
            r = X
            g = C
            b = 0
        } else if (HS >= 2 && HS < 3) {
            r = 0
            g = C
            b = X
        } else if (HS >= 3 && HS < 4) {
            r = 0
            g = X
            b = C
        } else if (HS >= 4 && HS < 5) {
            r = X
            g = 0
            b = C
        } else if (HS >= 5 && HS < 6) {
            r = C
            g = 0
            b = X
        }
        let m = v - C
        r += m
        g += m
        b += m
        return (r, g, b)
    }
    
    func RGBtoHSV(r : Float, g : Float, b : Float) -> (h : Float, s : Float, v : Float) {
        var h : CGFloat = 0
        var s : CGFloat = 0
        var v : CGFloat = 0
        let col = UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0)
        col.getHue(&h, saturation: &s, brightness: &v, alpha: nil)
        return (Float(h), Float(s), Float(v))
    }
    
    func render() {
        let centerHueAngle: Float = defaultHue/360.0
        var destCenterHueAngle: Float = 0.35
        let minHueAngle: Float = (defaultHue - hueRange/2.0) / 360
        let maxHueAngle: Float = (defaultHue + hueRange/2.0) / 360
        let hueAdjustment = centerHueAngle - destCenterHueAngle
        let size = 16
        var cubeData = [Float](count: size * size * size * 4, repeatedValue: 0)
        var rgb: [Float] = [0, 0, 0]
        var hsv: (h : Float, s : Float, v : Float)
        var newRGB: (r : Float, g : Float, b : Float)
        var offset = 0
        
        print(centerHueAngle)
        
        for var z = 0; z < size; z++ {
            rgb[2] = Float(z) / Float(size) // blue value
            for var y = 0; y < size; y++ {
                rgb[1] = Float(y) / Float(size) // green value
                for var x = 0; x < size; x++ {
                    rgb[0] = Float(x) / Float(size) // red value
                    hsv = RGBtoHSV(rgb[0], g: rgb[1], b: rgb[2])
                    if hsv.h < minHueAngle || hsv.h > maxHueAngle {
                        newRGB.r = rgb[0]
                        newRGB.g = rgb[1]
                        newRGB.b = rgb[2]
                        print("들어옴")
                    } else {
                        hsv.h = destCenterHueAngle == 1 ? 0 : hsv.h - hueAdjustment //force red if slider angle is 360
                        
                        newRGB = HSVtoRGB(hsv.h, s:hsv.s, v:hsv.v)
                        print("2번들옴")
                    }
                    cubeData[offset] = newRGB.r
                    cubeData[offset+1] = newRGB.g
                    cubeData[offset+2] = newRGB.b
                    cubeData[offset+3] = 1.0
                    offset += 4
                }
            }
        }
        let data = NSData(bytes: cubeData, length: cubeData.count * sizeof(Float))
        let colorCube = CIFilter(name: "CIColorCube")!
        colorCube.setValue(size, forKey: "inputCubeDimension")
        colorCube.setValue(data, forKey: "inputCubeData")
        colorCube.setValue(ciImage, forKey: kCIInputImageKey)
        if let outImage = colorCube.outputImage {
            let context = CIContext(options: nil)
            let outputImageRef = context.createCGImage(outImage, fromRect: outImage.extent)
            MainView.image = UIImage(CGImage: outputImageRef)
        }
    }
    
    
}