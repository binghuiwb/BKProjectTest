//
//  CryptoUtil.h
//  CryptoUtil
//
//  Created by Jiawei Chen on 14-9-28.
//  Copyright (c) 2014年 honestwalker.com. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "EncryptMethod.h"

@interface CryptoUtil : NSObject

/** 计算md5值
 * @param str   待加密字符串
 * @return NSString 返回字符串的md5值（大写）
 */
+ (NSString *)md5:(NSString *)str;


/** DES方式加密解密
 * @param plainText             待加密字符串
 * @param encryptYESDecryptNO   (true/YES加密)/(false/NO解密)
 * @param key                   待加密字符串
 * @return NSString 加密后的字符串
 */
//+ (NSString*)TripleDES:(NSString*)plainText
//   encryptYESDecryptNO:(BOOL)encryptYESDecryptNO
//                   key:(NSString*)key;
//
//+ (NSString *)AES_256:(NSString *)plainText
//  encryptYESDecryptNO:(BOOL)encryptYESDecryptNO
//                  key:(NSString*)key;

@end
