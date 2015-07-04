# MOAspects

[![Build Status](https://travis-ci.org/MO-AI/MOAspects.svg?branch=master)](https://travis-ci.org/MO-AI/MOAspects)

MOAspects is AOP library for iOS.

## Version

### 1.0.0

Stable version for Objective-C language.

### 2.1.0

Swift language supported and development version.

## How To Get Started

### Podfile

#### Stable version

```
pod 'MOAspects', '~> 1.0.0'
```

#### Development version

```
pod 'MOAspects'
```

## Interface

### MOAspect.h

```objc

#pragma mark - Hook instance method

+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                   aspectsPosition:(MOAspectsPosition)aspectsPosition
                        usingBlock:(id)block;

+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                   aspectsPosition:(MOAspectsPosition)aspectsPosition
                         hookRange:(MOAspectsHookRange)hookRange
                        usingBlock:(id)block;

#pragma mark - Hook class method

+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                aspectsPosition:(MOAspectsPosition)aspectsPosition
                     usingBlock:(id)block;

+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                aspectsPosition:(MOAspectsPosition)aspectsPosition
                      hookRange:(MOAspectsHookRange)hookRange
                     usingBlock:(id)block;
```

## How to use

### Objective-C

#### Hook class method example

```objc
[MOAspects hookClassMethodForClass:[NSNumber class]
                          selector:@selector(numberWithInt:)
                   aspectsPosition:MOAspectsPositionBefore
                        usingBlock:^(id class, int intVar){
                            NSLog(@"hooked %d number!", intVar);
                        }];

[NSNumber numberWithInt:10]; // -> hooked 10 number!
```

#### Hook instance method example

```objc
[MOAspects hookInstanceMethodForClass:[NSString class]
                             selector:@selector(length)
                      aspectsPosition:MOAspectsPositionBefore
                           usingBlock:^(NSString *string){
                               NSLog(@"hooked %@!", string);
                           }];

[@"abcde" length]; // -> hooked abcde!
```

### Swift

#### Hook class method example

```swift
MOAspects.hookClassMethodForClass(UIScreen.self, selector:"mainScreen", position:.Before) {
    NSLog("hooked screen!")
}

UIScreen.mainScreen() // -> hooked screen!
```

#### Hook instance method example

```swift
MOAspects.hookInstanceMethodForClass(ViewController.self, selector:"viewDidLoad", position:.After) {
    NSLog("view did loaded!")
}

// -> view did loaded!
```

## Spec table

| **32bit** | **64bit** | **Can Hook<br>Method Type** | **Class<br>Hierarchy Hook** | **Hook<br>Return Value** | **Natural<br>Swift Method** |
|:---------:|:---------:|:---------------------------:|:---------------------------:|:------------------------:|:---------------------------:|
|     ○     |     ○     |      Instance / Class       |          Supported          |      Not supported       |        Not supported        |
