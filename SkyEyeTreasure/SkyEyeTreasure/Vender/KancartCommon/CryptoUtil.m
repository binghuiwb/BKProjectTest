//
//  CryptoUtil.m
//  CryptoUtil
//
//  Created by Jiawei Chen on 14-9-28.
//  Copyright (c) 2014年 honestwalker.com. All rights reserved.
//

#import "CryptoUtil.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
//#import "NSData-AES.h"

@implementation CryptoUtil

/** 计算md5值
 * @param str   待加密字符串
 * @return NSString 返回字符串的md5值（大写）
 */
+ (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

///** DES方式加密解密
// * @param plainText             待加密字符串
// * @param encryptYESDecryptNO   (true/YES加密)/(false/NO解密)
// * @param key                   待加密字符串
// * @return NSString 加密后的字符串
// */
//+ (NSString*)TripleDES:(NSString*)plainText encryptYESDecryptNO:(BOOL)encryptYESDecryptNO key:(NSString*)key {
//
//    CCOperation encryptOrDecrypt = encryptYESDecryptNO ? kCCEncrypt: kCCDecrypt;
//    const void *vplainText;
//    size_t plainTextBufferSize;
//
//    if (encryptOrDecrypt == kCCDecrypt) {
//        int j = 0;
//        Byte bytes[plainText.length * 8];
//        for (int i = 0; i < plainText.length; i++) {
//
//            unichar hex_char1 = [plainText characterAtIndex:i];
//            int int_ch1;
//            if (hex_char1 >= '0' && hex_char1 <= '9') {
//                int_ch1 = (hex_char1 - 48) * 16;
//            } else if (hex_char1 >= 'A' && hex_char1 <= 'F') {
//                int_ch1 = (hex_char1 - 55) * 16;
//            } else if (hex_char1 >= 'a' && hex_char1 <= 'f') {
//                int_ch1 = (hex_char1 - 87) * 16;
//            }
//            i++;
//
//            unichar hex_char2 = [plainText characterAtIndex:i];
//            int int_ch2;
//            if (hex_char2 >= '0' && hex_char2 <= '9') {
//                int_ch2 = hex_char2 - 48;
//            } else if (hex_char2 >= 'A' && hex_char2 <= 'F') {
//                int_ch2 = hex_char2 - 55;
//            } else if (hex_char2 >= 'a' && hex_char2 <= 'f') {
//                int_ch2 = hex_char2 - 87;
//            }
//            bytes[j] = int_ch1 + int_ch2;
//            j++;
//        }
//
//        NSData *EncryptData = [NSData dataWithBytes:(const void *)bytes length:j];
//        plainTextBufferSize = [EncryptData length];
//        vplainText = [EncryptData bytes];
//
//        //        plainTextBufferSize = [d length];
//        //        vplainText = (const void *)[d bytes];
//    } else {
//        NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];\
//        plainTextBufferSize = [data length];
//        vplainText = (const void *)[data bytes];
//    }
//
//    //CCCryptorStatus ccStatus;
//    uint8_t *bufferPtr = NULL;
//    size_t bufferPtrSize = 0;
//    size_t movedBytes = 0;
//    // uint8_t ivkCCBlockSize3DES;
//
//    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
//    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
//    memset((void *)bufferPtr, 0x0, bufferPtrSize);
//    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
//
//    //    NSString *key = @"123456789012345678901234";
//    //NSString *initVec = @"init Vec";
//    const void *vkey = (const void *) [[key substringToIndex:8] UTF8String];
//    const void *vinitVec = (const void *) [[key substringToIndex:8] UTF8String];
//
//    //ccStatus =
//    CCCrypt(encryptOrDecrypt,
//            kCCAlgorithmDES,
//            kCCOptionPKCS7Padding,
//            vkey, //"123456789012345678901234", //key
//            kCCKeySizeDES,
//            vinitVec, //"init Vec", //iv,
//            vplainText, //"Your Name", //plainText,
//            plainTextBufferSize,
//            (void *)bufferPtr,
//            bufferPtrSize,
//            &movedBytes);
//    //    if (ccStatus == kCCSuccess) DLog(@"SUCCESS");
//    //    else if (ccStatus == kCCParamError) return @"PARAM ERROR";
//    //     else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
//    //     else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
//    //     else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
//    //     else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
//    //     else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED";
//
//    NSString *result;
//
//    if (encryptOrDecrypt == kCCDecrypt) {
//        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
//                                                               length:(NSUInteger)movedBytes]
//                                       encoding:NSUTF8StringEncoding];
//    } else {
//        //        NSData *myData = [NSData dataWithBytes:(const void*)bufferPtr length:(NSUInteger)movedBytes];
//        NSMutableString *buf = [[NSMutableString alloc] initWithCapacity:bufferPtrSize];
//        for (NSUInteger i = 0; i < bufferPtrSize; i++) {
//            [buf appendFormat:@"%02X", bufferPtr[i]];
//        }
//        result = buf;
//    }
//    free(bufferPtr);
//    bufferPtr = NULL;
//    return result;
//}
//#define GETBITS(a) (a < 'A' ? a - '0' : toupper(a) - 'A' + 10)
//
//+ (NSString *)AES_256:(NSString *)plainText encryptYESDecryptNO:(BOOL)encryptYESDecryptNO key:(NSString*)key {
//    NSData *result = nil;
//    if (encryptYESDecryptNO) {
//        result = [[plainText dataUsingEncoding:NSUTF8StringEncoding] AESEncryptWithPassphrase:key];
//        NSMutableString *buf = [[NSMutableString alloc] initWithCapacity:[result length]];
//
//        NSUInteger len = [result length];
//        Byte *byteData = (Byte*)malloc(len);
//        memcpy(byteData, [result bytes], len);
//
//        for (NSUInteger i = 0; i < len; i++) {
//            [buf appendFormat:@"%02X", byteData[i]];
//        }
//        free(byteData);
//        return buf;
//    } else {
//        NSData *plainTextData = [self bytesFromHexString:plainText];
//        result = [plainTextData AESDecryptWithPassphrase:key];
//        NSString *text = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
//        return text;
//    }
//}
//
//+ (NSData*)bytesFromHexString:(NSString *)aString {
//    NSString *theString = [[aString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:nil];
//
//    NSMutableData* data = [NSMutableData data];
//    int idx;
//    for (idx = 0; idx+2 <= theString.length; idx+=2) {
//        NSRange range = NSMakeRange(idx, 2);
//        NSString* hexStr = [theString substringWithRange:range];
//        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
//        unsigned int intValue;
//        if ([scanner scanHexInt:&intValue])
//            [data appendBytes:&intValue length:1];
//    }
//    return data;
//}

@end
