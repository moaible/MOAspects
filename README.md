# MOAspects v0.0.1

MOAspects is AOP library for iOS.

## How To Get Started

### Podfile

```
pod "MOAspects", :git => 'https://github.com/MO-AI/MOAspects.git'
```

## Interface

### MOAspect.h

```objc
// hook instance method
+ (BOOL)hookInstanceMethodInClass:(Class)clazz
                         selector:(SEL)selector
                      aspectsHook:(MOAspectsHook)aspectsHook
                       usingBlock:(id)block;

// hook class method
+ (BOOL)hookClassMethodInClass:(Class)clazz
                      selector:(SEL)selector
                   aspectsHook:(MOAspectsHook)aspectsHook
                    usingBlock:(id)block;
```

## How to use

### Hook is instance method example

```objc
[MOAspects hookInstanceMethodInClass:[NSNumber class]
                            selector:@selector(numberWithInt:)
                         aspectsHook:MOAspectsHookBefore
                          usingBlock:^(id class, int intVar){
                              NSLog(@"hooked %d number!", number);
                          }];
                          
[NSNumber numberWithInt:10]; // -> hooked 10 number!!
```

### Hook is class method example

```objc
[MOAspects hookClassMethodInClass:[NSString class]
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
|0.0.1| ⚪︎ | ⚪︎ | Instance / Class | Supported | Not supported |