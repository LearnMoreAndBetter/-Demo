//
//  NSString+Sha1.m
//  SHA1_Demo
//
//  Created by 王林 on 2018/3/9.
//  Copyright © 2018年 CETC. All rights reserved.
//

#import "NSString+Sha1.h"
#import <CommonCrypto/CommonDigest.h>
#import "GTMBase64.h"

@implementation NSString (Sha1)

- (NSString*) sha1{
	const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
	NSData *data = [NSData dataWithBytes:cstr length:self.length];
	//使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
	uint8_t digest[CC_SHA1_DIGEST_LENGTH];
	//使用对应的CC_SHA256,CC_SHA384,CC_SHA512
	CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
	
	NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
	
	for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
		[output appendFormat:@"%02x", digest[i]];
	
	return output;
}


- (NSString *) sha1_base64 {
	const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
	NSData *data = [NSData dataWithBytes:cstr length:self.length];
	uint8_t digest[CC_SHA1_DIGEST_LENGTH];
	CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
	
	NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
	base64 = [GTMBase64 encodeData:base64];
	NSString * output = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
	
	return output;
	
	
}




@end
