//
//  SKBMyScene.m
//  SKBreakout
//
//  Created by Mark Sobkowicz on 11/12/13.
//  Copyright (c) 2013 27Walnut. All rights reserved.
//

#import "SKBMyScene.h"

@interface SKBMyScene()
@property (nonatomic) BOOL movingLeft;
@property (nonatomic) BOOL movingRight;


@end

@implementation SKBMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor colorWithRed:0.55 green:0.65 blue:0.75 alpha:1.0];
        SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball"];
        ball.position = CGPointMake(50,200);
        ball.name = @"ball";
        ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:10.0];
        ball.physicsBody.friction = 0;
        ball.physicsBody.linearDamping = 0;
        ball.physicsBody.dynamic = YES;
        ball.physicsBody.restitution = 1.0;
        ball.physicsBody.velocity = CGVectorMake(250, -250);
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        
        
        [self addChild:ball];
        
        SKSpriteNode *paddle = [SKSpriteNode spriteNodeWithImageNamed:@"paddle"];
        paddle.position = CGPointMake(200, 30);
        paddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50, 15)];
        paddle.physicsBody.dynamic = NO;
        paddle.name = @"paddle";
        
        
        [self addChild:paddle];
        
        for (int row = 0; row < 5; row++){
            for (int col = 0; col < 8; col++){
                SKSpriteNode *brick = [SKSpriteNode spriteNodeWithImageNamed:@"brick"];
                brick.position = CGPointMake(col*40 + 20, row * 20 + 400);
                brick.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(30, 10)];
                brick.physicsBody.dynamic = NO;
                [self addChild:brick];
                
            }
        }
        
        SKSpriteNode *rmove = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(100,100)];
        rmove.position = CGPointMake(270,50);
        rmove.name = @"rmove";
        
        
        [self addChild:rmove];
        
        SKSpriteNode *lmove = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(100,100)];
        lmove.position = CGPointMake(50, 50);
        lmove.name = @"lmove";
        
        [self addChild:lmove];
        
        SKSpriteNode *edge = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:self.size];
        SKPhysicsBody *worldEdge = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, self.size.width, self.size.height)];
        edge.physicsBody = worldEdge;
        edge.name = @"edge";
        [self addChild:edge];
        
        
            }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    SKSpriteNode *lmove = (SKSpriteNode *)[self childNodeWithName:@"lmove"];
    SKSpriteNode *rmove = (SKSpriteNode *)[self childNodeWithName:@"rmove"];
    for (UITouch *touch in touches) {
        CGPoint touchPoint = [touch locationInNode:self];
        if ([lmove containsPoint:touchPoint]){
            self.movingLeft = YES;
            
        }
        if ([rmove containsPoint:touchPoint]){
            self.movingRight = YES;
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    SKSpriteNode *lmove = (SKSpriteNode *)[self childNodeWithName:@"lmove"];
    SKSpriteNode *rmove = (SKSpriteNode *)[self childNodeWithName:@"rmove"];
    for (UITouch *touch in touches) {
        CGPoint touchPoint = [touch locationInNode:self];
        if ([lmove containsPoint:touchPoint]){
            self.movingLeft = NO;
            
        }
        if ([rmove containsPoint:touchPoint]){
            self.movingRight = NO;
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    SKSpriteNode *paddle = (SKSpriteNode *)[self childNodeWithName:@"paddle"];
 
    
    /* Called before each frame is rendered */
    if (self.movingRight && paddle.position.x < 300) {
        paddle.position = CGPointMake(paddle.position.x + 5,paddle.position.y);
    }
    if (self.movingLeft && paddle.position.x > 20) {
        paddle.position = CGPointMake(paddle.position.x - 5, paddle.position.y);
    }
}

@end
