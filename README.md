# MOAspects v0.1.0

MOAspects is AOP library for iOS.

## How To Get Started

### Podfile

```
pod 'MOAspects', :git => 'https://github.com/MO-AI/MOAspects.git'
```

## Interface

### MOAspect.h

```objc
// hook instance method 
+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                   aspectsPosition:(MOAspectsPosition)aspectsPosition
                        usingBlock:(id)block;

// hook class method
+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                aspectsPosition:(MOAspectsPosition)aspectsPosition
                     usingBlock:(id)block;
```

## How to use

### Hook class method example

```objc
[MOAspects hookClassMethodInClass:[NSNumber class]
                            selector:@selector(numberWithInt:)
                       aspectsHook:MOAspectsHookBefore
                        usingBlock:^(id class, int intVar){
                            NSLog(@"hooked %d number!", intVar);
                        }];
                          
[NSNumber numberWithInt:10]; // -> hooked 10 number!
```

### Hook instance method example

```objc
[MOAspects hookInstanceMethodInClass:[NSString class]
                            selector:@selector(length)
                         aspectsHook:MOAspectsHookBefore
                          usingBlock:^(NSString *string){
                              NSLog(@"hooked %@!", string);
                          }];
                       
[@"abcde" length]; // -> hooked abcde!
```

## Spec table

|**Version**|**32bit**|**64bit**|**Can Hook<br>Method Type**|**Class<br>Hierarchy Hook**|**Hook<br>Return Value**|
|:---:|:---:|:---:|:---:|:---:|:---:|
|v0.0.1| ⚪︎ | ⚪︎ | Instance / Class | Supported | Not supported |
