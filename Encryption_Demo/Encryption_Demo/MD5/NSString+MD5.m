#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>
#import "GTMBase64.h"

@implementation NSString(MD5)


-(NSString *)md5 {
	const char *cStr = [self UTF8String];
	unsigned char digest[CC_MD5_DIGEST_LENGTH];
	CC_MD5( cStr, (CC_LONG)strlen(cStr), digest);
	NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
	for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
		[output appendFormat:@"%02x", digest[i]];
	
	return output;
}


- (NSString *) md5_base64 {
	const char *cStr = [self UTF8String];
	unsigned char digest[CC_MD5_DIGEST_LENGTH];
	CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
	NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
	base64 = [GTMBase64 encodeData:base64];
	NSString * output = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
	
	return output;
}


@end
