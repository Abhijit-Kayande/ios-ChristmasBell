//
//  ViewController.m
//  PanIt
//
//  Created by Abhi on 29/12/14.
//  Copyright (c) 2014 Abhi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{

    BOOL IsChristmas;
    CAEmitterLayer *emitterLayer;

}

@property (strong,nonatomic) UIDynamicAnimator *animator;
@property (strong,nonatomic) UIGravityBehavior *Pangravity;
@property (strong,nonatomic) UIGravityBehavior *Viewgravity;
@property (strong,nonatomic) CAShapeLayer *layer;
@property (strong,nonatomic) UIView *PanView;
@property (strong,nonatomic) UIImageView *BellImageView;;
@property (strong,nonatomic) UIView *MiddleView;
@property (strong,nonatomic) UIView *MiddleTopView;
@property (strong,nonatomic) UIView *MiddleBottomView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _PanView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height/2)];
    
    [_PanView setBackgroundColor:[UIColor cyanColor]];
    
    [_PanView setAlpha:0.5];
    
    [self.view addSubview:_PanView];
    
    [_PanView.layer setShadowOffset:CGSizeMake(-1, 2)];
    
    [_PanView.layer setShadowOpacity:0.5];
    
    [_PanView.layer setShadowRadius:5.0];
    
    [_PanView.layer setShadowColor:[UIColor blackColor].CGColor];
    
    [_PanView.layer setMasksToBounds:NO];
    
    [_PanView.layer setShadowPath:[UIBezierPath bezierPathWithRect:_PanView.bounds].CGPath];
    
    
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(PanTheView:)];
    
    
    [_PanView addGestureRecognizer:pan];
    
    
    
    CAGradientLayer *grd=[[CAGradientLayer alloc] init];
    
    [grd setFrame:_PanView.frame];
    
    grd.colors = [[NSArray alloc] initWithObjects:(__bridge id)([UIColor redColor].CGColor),(__bridge id)([UIColor orangeColor].CGColor), nil];
    
    
    
    [_PanView.layer addSublayer:grd];
    
    
    
    
    
    
    UILabel *DragLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, _PanView.frame.size.height/2, _PanView.frame.size.width-20, 100)];
    
    [DragLabel setText:@"Drag    Up"];
    [DragLabel setTextAlignment:NSTextAlignmentCenter];
    
    [DragLabel setFont:[UIFont systemFontOfSize:70]];
    
    [_PanView addSubview:DragLabel];
    
    
    
    
    
    
    _BellImageView=[[UIImageView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width/2)-64, [[UIScreen mainScreen] bounds].size.height/1.5, 128, 128)];
    
    [_BellImageView setImage:[UIImage imageNamed:@"Christmas-bell.png"]];
    
    [self.view addSubview:_BellImageView];
    
    [_BellImageView.layer setShadowOffset:CGSizeMake(-4, 4)];
    
    [_BellImageView.layer setShadowOpacity:0.5];
    
    [_BellImageView.layer setShadowRadius:5.0];
    
    [_BellImageView.layer setShadowColor:[UIColor blackColor].CGColor];
    
    [_BellImageView.layer setMasksToBounds:NO];

//    [_BellImageView.layer setShadowPath:[UIBezierPath bezierPathWithRect:_BellImageView.bounds].CGPath];
    
    
    
    
    
    
    _MiddleView = [[UIView alloc] initWithFrame:CGRectMake(_BellImageView.center.x-15, 200, 30, 30)];
    
    [_MiddleView setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:_MiddleView];
    
    [_MiddleView setCenter:CGPointMake(_MiddleView.center.x, (_BellImageView.center.y-_PanView.center.y)+15)];
    
    
   
    
    
    //2
    
    _MiddleTopView = [[UIView alloc] initWithFrame:CGRectMake(_BellImageView.center.x-15, 200, 30, 30)];
    
    [_MiddleTopView setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:_MiddleTopView];
    
    [_MiddleTopView setCenter:CGPointMake(_MiddleTopView.center.x, (_MiddleView.center.y-_PanView.center.y)+_PanView.center.y/2)];
    
    
    //3
    
    _MiddleBottomView = [[UIView alloc] initWithFrame:CGRectMake(_BellImageView.center.x-15, 200, 30, 30)];
    
    [_MiddleBottomView setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:_MiddleBottomView];
    
    [_MiddleBottomView setCenter:CGPointMake(_MiddleBottomView.center.x, (_MiddleView.center.y-_PanView.center.y)+_PanView.center.y*1.5)];
    
    
    
    [self AddAnimations];
    
    
    
    
    
}


-(IBAction)MerryChristmas:(id)sender
{

    [self AddEmitterEffect];

}

-(void)AddEmitterEffect
{

    if (!IsChristmas) {
        
        
        //More Examples
        
        
        
        CAEmitterCell* rocket = [CAEmitterCell emitterCell];
        
        rocket.birthRate        = 1.0;
        rocket.emissionRange    = 0.25 * M_PI;  // some variation in angle
        rocket.velocity         = 380;
        rocket.velocityRange    = 100;
        rocket.yAcceleration    = 75;
        rocket.lifetime         = 1.02; // we cannot set the birthrate < 1.0 for the burst
        
        rocket.contents         = (id) [[UIImage imageNamed:@"WaterDrop.png"] CGImage];
        rocket.scale            = 0.2;
        rocket.color            = [[UIColor redColor] CGColor];
        rocket.greenRange       = 1.0;      // different colors
        rocket.redRange         = 1.0;
        rocket.blueRange        = 1.0;
        rocket.spinRange        = M_PI;     // slow spin
        
        
        
        // the burst object cannot be seen, but will spawn the sparks
        // we change the color here, since the sparks inherit its value
        CAEmitterCell* burst = [CAEmitterCell emitterCell];
        
        burst.birthRate         = 1.0;      // at the end of travel
        burst.velocity          = 0;
        burst.scale             = 2.5;
        burst.redSpeed          =-1.5;      // shifting
        burst.blueSpeed         =+1.5;      // shifting
        burst.greenSpeed        =+1.0;      // shifting
        burst.lifetime          = 0.35;
        burst.contents          = (id) [[UIImage imageNamed:@"WaterDrop.png"] CGImage];
        
        // and finally, the sparks
        
        CAEmitterCell* spark = [CAEmitterCell emitterCell];
        
        spark.birthRate         = 400;
        spark.velocity          = 125;
        spark.emissionRange     = 2* M_PI;  // 360 deg
        spark.yAcceleration     = 75;       // gravity
        spark.lifetime          = 3;
        
        spark.contents          = (id) [[UIImage imageNamed:@"WaterDrop.png"] CGImage];
        spark.scaleSpeed        =-0.2;
        spark.greenSpeed        =-0.1;
        spark.redSpeed          = 0.4;
        spark.blueSpeed         =-0.1;
        spark.alphaSpeed        =-0.25;
        spark.spin              = 2* M_PI;
        spark.spinRange         = 2* M_PI;
        
        
        //Emmitter
        
        emitterLayer = [CAEmitterLayer layer]; // 1
        emitterLayer.emitterPosition = CGPointMake(self.view.bounds.size.width/2, 0); // 2
        emitterLayer.emitterZPosition = 10; // 3
        emitterLayer.emitterSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height); // 4
        emitterLayer.emitterShape = kCAEmitterLayerCuboid; // 5
        
        
        CAEmitterCell *emitterCell = [CAEmitterCell emitterCell]; // 6
        emitterCell.scale = 0.2; // 7
        emitterCell.scaleRange = 0.1; // 8
        emitterCell.emissionRange = (CGFloat)M_PI_2; // 9
        emitterCell.lifetime = 5.0; // 10
        emitterCell.birthRate = 400; // 11
        emitterCell.velocity = 0; // 12
        emitterCell.velocityRange = 50; // 13
        emitterCell.yAcceleration = 250; // 14
        
        
        
        
        emitterCell.contents = (id)[[UIImage imageNamed:@"Snowflake.png"] CGImage]; // 15
        
        
       
        
        
        emitterLayer.emitterCells = [NSArray arrayWithObject:emitterCell]; // 16
        
        
        [self.view.layer addSublayer:emitterLayer]; // 17
        
        
        IsChristmas=YES;
        
    }
    else
    {
    
        [emitterLayer removeFromSuperlayer];
        
        
        IsChristmas=NO;
    
    
    }
    
    
    
    



}


+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


-(void)AddAnimations
{
    
    _animator=[[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    _Pangravity=[[UIGravityBehavior alloc] initWithItems:@[_PanView]];
    
    [_animator addBehavior:_Pangravity];
    
    
    _Viewgravity=[[UIGravityBehavior alloc] initWithItems:@[_BellImageView,_MiddleTopView,_MiddleBottomView]];
    
    [_animator addBehavior:_Viewgravity];
    
    
    _Viewgravity.action=^{
        
        UIBezierPath *path=[[UIBezierPath alloc] init];
        
        [path moveToPoint:_PanView.center];
        
        
        
        [path addCurveToPoint:_BellImageView.center controlPoint1:_MiddleTopView.center controlPoint2:_MiddleBottomView.center];
        

        
        
        
        
        
        
        
//        if (_layer) {
//            
//            [_layer removeFromSuperlayer];
//        }
        if (!_layer) {
        
        _layer=[[CAShapeLayer alloc] init];
            
            
            
            _layer.fillColor = [UIColor clearColor].CGColor;
            
            _layer.strokeColor = [UIColor colorWithRed:224.0/255.0 green:0.0/255.0 blue:35.0/255.0 alpha:1.0].CGColor;
            
            _layer.lineWidth = 5.0;
            
            
            //Shadow
            
            [_layer setShadowOffset:CGSizeMake(-1, 2)];
            
            [_layer setShadowOpacity:0.5];
            
            [_layer setShadowRadius:5.0];
            
            [_layer setShadowColor:[UIColor blackColor].CGColor];
            
            [_layer setMasksToBounds:NO];
            
            
            [self.view.layer insertSublayer:_layer below:_BellImageView.layer];
        }
        
        _layer.path=path.CGPath;
        
        
       
        
        
        
        
    };
    
    
    
    UICollisionBehavior *Collision=[[UICollisionBehavior alloc] initWithItems:@[_PanView]];
    
    [Collision addBoundaryWithIdentifier:@"Left" fromPoint:CGPointMake(-1, 0) toPoint:CGPointMake(-1, [[UIScreen mainScreen] bounds].size.height)];
    
    [Collision addBoundaryWithIdentifier:@"Right" fromPoint:CGPointMake([[UIScreen mainScreen] bounds].size.width+1,0) toPoint:CGPointMake([[UIScreen mainScreen] bounds].size.width+1, [[UIScreen mainScreen] bounds].size.height)];
    
    [Collision addBoundaryWithIdentifier:@"Middle" fromPoint:CGPointMake(0, [[UIScreen mainScreen] bounds].size.height/2) toPoint:CGPointMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height/2)];
    
    [_animator addBehavior:Collision];
    
    
    UIAttachmentBehavior *attach1=[[UIAttachmentBehavior alloc] initWithItem:_PanView attachedToItem:_MiddleTopView];
    
    
    
   
    attach1.damping=0;
    
    
    
    
    
    [_animator addBehavior:attach1];
    

    
    
    UIAttachmentBehavior *attach2=[[UIAttachmentBehavior alloc] initWithItem:_MiddleTopView attachedToItem:_MiddleBottomView];
    
    
    
   
    attach2.damping=0;
    
    
    
    [_animator addBehavior:attach2];
    
    
    UIAttachmentBehavior *attach3=[[UIAttachmentBehavior alloc] initWithItem:_MiddleBottomView offsetFromCenter:UIOffsetMake(0, 0) attachedToItem:_BellImageView offsetFromCenter:UIOffsetMake(0, -35)];
    
    
    
    
    attach3.damping=0;
    
    
    
    [_animator addBehavior:attach3];
    
    
    
    UIDynamicItemBehavior *PanItem=[[UIDynamicItemBehavior alloc] initWithItems:@[_PanView]];
    
    PanItem.elasticity=0.9;
    
    
    [_animator addBehavior:PanItem];
    
    
    
    
}


-(void)PanTheView:(UIPanGestureRecognizer *)pan
{

    
    CGPoint translation = [pan translationInView:pan.view];
    
    if (!(pan.view.center.y+ translation.y>([[UIScreen mainScreen] bounds].size.height/2)-(pan.view.bounds.size.height/2))) {
        
        pan.view.center=CGPointMake(pan.view.center.x, pan.view.center.y+ translation.y);
        
        [pan setTranslation:CGPointMake(0, 0) inView:pan.view];
        
        
        
        
    }
    
    
    if (pan.state==UIGestureRecognizerStateBegan) {
        
        [_animator removeBehavior:_Pangravity];
        

        
    }
    else if (pan.state==UIGestureRecognizerStateChanged){
    
//        UIBezierPath *path=[[UIBezierPath alloc] init];
//        
//        [path moveToPoint:_PanView.center];
//        
//        [path addQuadCurveToPoint:_MiddleView.center controlPoint:_MiddleTopView.center];
//        
//        [path addQuadCurveToPoint:_MiddleBottomView.center controlPoint:_MiddleView.center];
//        
//        [path addQuadCurveToPoint:CGPointMake(_TextField.center.x, _TextField.center.y-15) controlPoint:_MiddleBottomView.center];
//        
//        
//        
//        
//        if (_layer) {
//            
//            [_layer removeFromSuperlayer];
//        }
//        
//        
//        _layer=[[CAShapeLayer alloc] init];
//        
//        _layer.path=path.CGPath;
//        
//        _layer.fillColor = [UIColor clearColor].CGColor;
//        
//        _layer.strokeColor = [UIColor blueColor].CGColor;
//        
//        _layer.lineWidth = 5.0;
//        
//        
//        //Shadow
//        
//        [_layer setShadowOffset:CGSizeMake(-1, 2)];
//        
//        [_layer setShadowOpacity:0.5];
//        
//        [_layer setShadowRadius:5.0];
//        
//        [_layer setShadowColor:[UIColor blackColor].CGColor];
//        
//        [_layer setMasksToBounds:NO];
//        
//        
//        [self.view.layer addSublayer:_layer];
    
    }
    else if (pan.state==UIGestureRecognizerStateEnded) {
        
        [_animator addBehavior:_Pangravity];
        
    }
    
    
    
    [_animator updateItemUsingCurrentState:pan.view];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
