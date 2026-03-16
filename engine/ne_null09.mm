//
//  ne_null09.m
//  ITS1
//
//  Created by Saud Aljaloud on 29/04/2023.
//

#import "ne_null09.h"
#include "obfuscate.h"
#include <iostream>
#include <cstring>
//NSString *Stack_01 = @"ADD_STACK_NULL01";
//NSString *Reg_0x2B = @"_stack_args1_Null_Null_args2_sum";
NSString *Stack_01 = [NSString stringWithCString:OBFUSCATE("ADD_STACK_NULL01") encoding:[NSString defaultCStringEncoding]];
NSString *Reg_0x2B = [NSString stringWithCString:OBFUSCATE("_stack_args1_Null_Null_args2_sum") encoding:[NSString defaultCStringEncoding]];
//[NSString stringWithCString:OBFUSCATE("ADD_STACK_NULL01") encoding:[NSString defaultCStringEncoding]];
int var_344 = 15;
@implementation nil_02
+ (NSString*)ne_null01:(NSString*)String {
    NSMutableString *encrptedString = [[NSMutableString alloc] init];
    for (int i = 0; i < String.length; i++) {
        unichar character = [String characterAtIndex:i];
        character += var_344;
        [encrptedString appendFormat:@"%C",character];
    }
    return encrptedString;
}

+ (NSString*)ed_null03:(NSString*)String {
    NSMutableString *decrptedString = [[NSMutableString alloc] init];
    for (int i = 0; i < String.length; i++) {
        unichar character = [String characterAtIndex:i];
        character -= var_344;
        [decrptedString appendFormat:@"%C",character];
    }
    return decrptedString;
}
@end

@implementation ne_null09

+ (NSString *)Ne_Stack_1:(NSString *)plainText {
    NSMutableData *result =  [ne_null09 doAES:[plainText dataUsingEncoding:NSUTF8StringEncoding] context: kCCEncrypt error:nil];
    return [result base64EncodedStringWithOptions:0];
}

+ (NSString *)ed_stack_05:(NSString *)encryptedBase64String {
    NSData *dataToDecrypt = [[NSData alloc] initWithBase64EncodedString:encryptedBase64String options:0];
    NSMutableData *result = [ne_null09 doAES:dataToDecrypt context: kCCDecrypt error:nil];
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}

+ (NSMutableData *)doAES:(NSData *)dataIn context:(CCOperation)kCCEncrypt_or_kCCDecrypt error:(NSError **)error {
    CCCryptorStatus ccStatus = kCCSuccess;
    size_t          cryptBytes = 0;
    NSMutableData  *dataOut    = [NSMutableData dataWithLength:dataIn.length + kCCKeySizeAES256];
    NSString *const Stack_011 = [nil_02 ed_null03:Stack_01];
    NSString *const Reg_0x6B =  [nil_02 ed_null03:Reg_0x2B];
    NSData *key = [Reg_0x6B dataUsingEncoding:NSUTF8StringEncoding];
    NSData *iv = [Stack_011 dataUsingEncoding:NSUTF8StringEncoding];
    
    ccStatus = CCCrypt( kCCEncrypt_or_kCCDecrypt,
                       kCCAlgorithmAES,
                       kCCOptionPKCS7Padding,
                       key.bytes,
                       kCCKeySizeAES256,
                       iv.bytes,
                       dataIn.bytes,
                       dataIn.length,
                       dataOut.mutableBytes,
                       dataOut.length,
                       &cryptBytes);
    
    if (ccStatus == kCCSuccess) {
        dataOut.length = cryptBytes;
    } else {
        dataOut = nil;
    }
    return dataOut;
}
@end

