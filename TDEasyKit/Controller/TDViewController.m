//
//  TDViewController.m
//  TDEasyKit
//
//  Created by Duc Dang on 4/26/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//

#import "TDViewController.h"
#import "TDConfiguration.h"

/**
 Custom NavigationBar
 Contain: LeftContainer, CenterContainer, RightContainer
 AutoLayout
 Default Height: 44
 */
@interface TDNavigationBar()
    {
        /*
         *  Back button with back icon
         *  Default is show
         *  Hidden when @isHidesBackButton = true | @leftViews has some subviews
         *  send event to @delegate(controller)
         */
        UIButton *backButton;

        /*
         *  Contains list of views in the left of navigationBar
         *  Default size (44; 44)
         */
        UIView *leftContainer;

        /*
         *  Contains list of views in the center of navigationBar
         *  Default size = size of view
         *  Center Alignment
         */
        UIView *centerView;

        /*
         *  superview of @centerView
         *  Default size = @leftContainer.maxX to @rightContainer.minX
         */
        UIView *centerContainer;

        /*
         *  Contains list of views in the right of navigationBar
         *  Default size (44; 44)
         */
        UIView *rightContainer;

        UIView *bottomLine;
    }

    /**
     Send Event to controller: back,....
     */
    @property (nonatomic, weak) id<TDNavigationBarDelegate> delegate;

    /**
     Default is NO. If YES, the @backButton will be hidden.
     */
    @property (nonatomic) BOOL hidesBackButton;

    /*
     *  Spacing between views of @centerView
     *  Default is 10px
     */
    @property (nonatomic) CGFloat centerItemsSpacing;

    @end

@implementation TDNavigationBar

- (void)dealloc
{
    _delegate = nil;
    leftContainer = nil;
    centerView = nil;
    centerContainer = nil;
    rightContainer = nil;
    bottomLine = nil;
    backButton = nil;
}

-(id)initWithFrame:(CGRect)frame
    {
        if (self = [super initWithFrame:frame]) {
            [self setupBackButton];
            [self setupLeftContainer];
            [self setupCenterContainer];
            [self setupRightContainer];
            [self setupBottomLine];
        }
        return self;
    }

-(void)setupBackButton
    {
        backButton = [[UIButton alloc] init];
        backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButton];

        TDConfiguration *config = [TDConfiguration defaultConfiguration];
        [backButton setImage:config.navigationBarBackIcon forState: UIControlStateNormal];
        config = nil;
    }

-(void)setupLeftContainer
    {
        leftContainer = [[UIView alloc] init];
        leftContainer.layer.masksToBounds = true;
        [self addSubview:leftContainer];
    }

-(void)setupCenterContainer
    {
        centerContainer = [[UIView alloc] init];
        centerContainer.layer.masksToBounds = true;
        [self addSubview:centerContainer];

        centerView = [[UIView alloc] init];
        [centerContainer addSubview:centerView];
    }

-(void)setupRightContainer
    {
        rightContainer = [[UIView alloc] init];
        rightContainer.layer.masksToBounds = true;
        [self addSubview:rightContainer];
    }

-(void)setupBottomLine
    {
        bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        [self addSubview:bottomLine];
    }

-(void)setHidesBackButton:(BOOL)hidesBackButton
    {
        _hidesBackButton = hidesBackButton;

        [self layoutSubviews];
    }

-(void)setCenterViews:(NSArray<UIView *> *)views
    {
        [centerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

        TDConfiguration *config = [TDConfiguration defaultConfiguration];
        CGFloat navigationBarHeight = config.navigationBarHeight;
        CGFloat width = 0;

        for (UIView *view in views) {
            view.frame = CGRectMake(width, (navigationBarHeight - CGRectGetHeight(view.frame)) / 2, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));

            [centerView addSubview:view];

            width += CGRectGetWidth(view.frame) + _centerItemsSpacing;
        }

        if (views && views.count > 0) {
            width -= _centerItemsSpacing;
        }

        config = nil;

        CGRect rect = centerView.frame;
        rect.size.width = width;
        rect.size.height = navigationBarHeight;
        centerView.frame = rect;

        [self layoutSubviews];
    }

-(void)setLeftViews:(NSArray<UIView *> *)leftViews
    {
        if (leftViews && leftViews.count > 0) {
            _hidesBackButton = true;
        }

        [self setViews:leftViews forContainer:leftContainer];
    }

-(void)setRightViews:(NSArray<UIView *> *)rightViews
    {
        [self setViews:rightViews forContainer:rightContainer];
    }

-(void)setViews:(NSArray<UIView *> *)views forContainer:(UIView*)container
    {
        [container.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

        TDConfiguration *config = [TDConfiguration defaultConfiguration];
        CGFloat navigationBarHeight = config.navigationBarHeight;
        CGFloat width = 0;
        
        for (UIView *view in views) {
            view.frame = CGRectMake(width, 0, navigationBarHeight, navigationBarHeight);

            [container addSubview:view];

            width += navigationBarHeight;
        }

        config = nil;

        CGRect rect = container.frame;
        rect.size.width = width;
        rect.size.height = navigationBarHeight;
        rect.origin.y = 0;
        container.frame = rect;

        [self layoutSubviews];
    }

    @end

@implementation TDNavigationBar (Layout)

-(void)layoutSubviews
    {
        [super layoutSubviews];

        TDConfiguration *config = [TDConfiguration defaultConfiguration];
        CGFloat navigationBarHeight = config.navigationBarHeight;

        backButton.frame = CGRectMake(0, 0, _hidesBackButton ? 0 : config.navigationBarHeight, navigationBarHeight);
        leftContainer.frame = CGRectMake(CGRectGetMaxX(backButton.frame), 0, CGRectGetWidth(leftContainer.frame), navigationBarHeight);
        rightContainer.frame = CGRectMake(CGRectGetWidth(self.frame) - CGRectGetWidth(rightContainer.frame), 0, CGRectGetWidth(rightContainer.frame), navigationBarHeight);

        centerContainer.frame = CGRectMake(CGRectGetMaxX(leftContainer.frame), 0, CGRectGetMinX(rightContainer.frame) - CGRectGetMaxX(leftContainer.frame), navigationBarHeight);

        [self layoutCenterContainer];

        bottomLine.frame = CGRectMake(0, navigationBarHeight - 1, CGRectGetWidth(self.frame), 1);

        config = nil;
    }

-(void)layoutCenterContainer
    {
        CGRect rect = centerView.frame;
        rect.origin.x = (CGRectGetWidth(self.frame) - rect.size.width) / 2;
        rect = [self convertRect:rect toView:centerContainer];

        rect.origin.y = 0;
        if (rect.origin.x < 0) {
            rect.origin.x = 0;
        }
        if (CGRectGetMaxX(rect) > CGRectGetWidth(centerContainer.frame)) {
            rect.origin.x = CGRectGetWidth(centerContainer.frame) - CGRectGetWidth(rect);
        }

        centerView.frame = rect;
    }

    @end

@implementation TDNavigationBar (Actions)

-(void)back:(UIButton*)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(pressedBack:)]) {
        [_delegate pressedBack:self];
    }
}

    @end

//-------------------------------------------------------------
@interface TDViewController () <TDNavigationBarDelegate>
    {
        UILabel *titleLabel;
    }

    @end

@implementation TDViewController

-(void)viewWillAppear:(BOOL)animated
    {
        [super viewWillAppear:animated];
        [self.navigationController setNavigationBarHidden:true];

        if (self.hidesBackButton == false && [self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
        }
    }

-(void)viewDidLoad
    {
        [super viewDidLoad];

        [self setupBar];

        [self setup];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }

-(void)setupBar {
    TDConfiguration *config = [TDConfiguration defaultConfiguration];

    _statusBar = [[UIView alloc] init];
    _statusBar.backgroundColor = config.navigationBarColor;
    _statusBar.layer.zPosition = 100;

    _navigationBar = [[TDNavigationBar alloc] init];
    _navigationBar.backgroundColor = config.navigationBarColor;
    _navigationBar.layer.zPosition = 100;
    _navigationBar.delegate = self;

    [self.view addSubview:_navigationBar];
    [self.view addSubview:_statusBar];

    config = nil;

    [self viewWillLayoutSubviews];
}

-(void)setup {
    self.shouldLayoutDependOnKeyboard = true;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

-(void)setNavigationBarHidden:(BOOL)isHidden
{
    _navigationBar.hidden = isHidden;
    _statusBar.hidden = isHidden;
}

-(void)setHidesBackButton:(BOOL)hidesBackButton
    {
        _hidesBackButton = hidesBackButton;

        if (_navigationBar) {
            _navigationBar.hidesBackButton = hidesBackButton;
        }
    }

-(void)setTitleViews:(NSArray<UIView *> *)titleViews spacing:(CGFloat)spacing
    {
        _titleViews = titleViews;

        if (_navigationBar) {
            _navigationBar.centerItemsSpacing = spacing;
            [_navigationBar setCenterViews:titleViews];
        }
    }

-(void)setLeftViews:(NSArray<UIView *> *)leftViews
    {
        _leftViews = leftViews;

        if (_navigationBar) {
            [_navigationBar setLeftViews:leftViews];
        }
    }

-(void)setTitleViews:(NSArray<UIView *> *)titleViews
    {
        [self setTitleViews:titleViews spacing:0];
    }

-(void)setRightViews:(NSArray<UIView *> *)rightViews
    {
        _rightViews = rightViews;

        if (_navigationBar) {
            [_navigationBar setRightViews:rightViews];
        }
    }

-(void)setTitle:(NSString *)title
    {
        [self setTitle:title font:[UIFont systemFontOfSize:16]];
    }

-(void)setTitle:(NSString *)title font:(UIFont *)font
    {
        if (_titleViews && _titleViews.count > 0) {
            if (![_titleViews.firstObject isEqual:titleLabel]) {
                return;
            }
        }

        if (!titleLabel) {
            titleLabel = [[UILabel alloc] init];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.textColor = [TDConfiguration defaultConfiguration].navigationBarTintColor;
        }

        titleLabel.text = title;
        titleLabel.font = font;

        [titleLabel sizeToFit];

        [self setTitleViews:@[titleLabel]];
    }

-(void)keyboardWillShow:(NSNotification*)noti
    {
        CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        self.keyboardHeight = rect.size.height;
        if (self.shouldLayoutDependOnKeyboard) {
            [self viewWillLayoutSubviews];
        }
    }
-(void)keyboardWillHide:(NSNotification*)noti
    {
        self.keyboardHeight = 0;
        if (self.shouldLayoutDependOnKeyboard) {
            [self viewWillLayoutSubviews];
        }
    }
    
-(void)dealloc
    {
        _navigationBar = nil;
        _statusBar = nil;
        _leftViews = nil;
        _titleViews = nil;
        _rightViews = nil;
        titleLabel = nil;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
    @end

@implementation TDViewController (Layout)
    
-(void)viewWillLayoutSubviews
    {
        [super viewWillLayoutSubviews];
        
        TDConfiguration *config = [TDConfiguration defaultConfiguration];
        CGFloat statusBarHeight = 20;
        if (@available(iOS 11.0, *)) {
            statusBarHeight = self.view.safeAreaInsets.top;
        }
        
        _statusBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), [UIApplication sharedApplication].statusBarHidden ? 0 : statusBarHeight);
        _navigationBar.frame = CGRectMake(0, CGRectGetMaxY(_statusBar.frame), CGRectGetWidth(self.view.frame), config.navigationBarHeight);
        
        config = nil;
    }
    
    @end

@implementation TDViewController (Actions)
    
-(void)pressedBack:(TDNavigationBar *)navigationBar
    {
        UINavigationController *navi = self.navigationController;
        
        if (navi) {
            if ([navi.topViewController isEqual:self] && [navigationBar isEqual:_navigationBar]) {
                [navi popViewControllerAnimated:YES];
            }
        }
        navi = nil;
    }
    
    @end
