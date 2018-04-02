//
//  ViewController.m
//  Encryption_Demo
//
//  Created by 王林 on 2018/4/2.
//  Copyright © 2018年 CETC. All rights reserved.
//

#import "ViewController.h"
#import "JKEncrypt.h"
#import "NSString+AES.h"
#import "LCdes.h"
#import "RSAEncryptor.h"
#import "NSString+Sha1.h"
#import "NSString+MD5.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self Check_3DES_Encrypt];
	[self Check_AES_Encrypt];
	[self Check_DES_Encrypt];
	[self Check_RSA_Encrypt];
	[self md5_check];
	[self sha1_check];
	
	
}

- (void)Check_3DES_Encrypt{
	JKEncrypt * en = [[JKEncrypt alloc]init];
	//加密
	NSString * encryptStr = [en doEncryptStr: @"使用3DES字符串加密测试字符串"];
	
	NSString * encryptHex = [en doEncryptHex: @"使用3DES十六进制加密测试字符串"];
	
	NSLog(@"字符串加密:%@",encryptStr);
	NSLog(@"十六进制加密:%@",encryptHex);
	//解密
	NSString *decEncryptStr = [en doDecEncryptStr:encryptStr];
	
	NSString *decEncryptHex = [en doDecEncryptHex:encryptHex];
	
	NSLog(@"字符串解密:%@",decEncryptStr);
	NSLog(@"十六进制解密:%@",decEncryptHex);
}


- (void)Check_AES_Encrypt{
	NSString *password = @"zy1047539560";
	
	NSString *encryptStr = [password aci_encryptWithAES];
	NSString *decryptStr = [encryptStr aci_decryptWithAES];
	
	NSLog(@"AES加密后密文：%@", encryptStr);
	NSLog(@"AES解密后明文：%@", decryptStr);
}

- (void)Check_DES_Encrypt{
	NSString *origineString=@"lovelyGirl";
	NSLog(@"原始字符串:%@",origineString);
	
	NSString *encryptionString=[LCdes lcEncryUseDES:origineString];
	NSLog(@"加密后的的字符串:%@",encryptionString);
	
	NSString *decryptionString=[LCdes lcDecryUseDES:encryptionString];
	NSLog(@"解密后的字符串:%@",decryptionString);
}

- (void)Check_RSA_Encrypt{
	//原始数据
	NSString *originalString = @"这是一段将要使用'.der'文件加密的字符串!";
	
	//使用.der和.p12中的公钥私钥加密解密
	NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
	NSString *private_key_path = [[NSBundle mainBundle] pathForResource:@"private_key.p12" ofType:nil];
	
	NSString *encryptStr = [RSAEncryptor encryptString:originalString publicKeyWithContentsOfFile:public_key_path];
	NSLog(@"加密前:%@", originalString);
	NSLog(@"加密后:%@", encryptStr);
	NSLog(@"解密后:%@", [RSAEncryptor decryptString:encryptStr privateKeyWithContentsOfFile:private_key_path password:@"123456"]);
	
	NSLog(@"************************************************************");
	
	
	//原始数据
	NSString *originalString2 = @"这是一段将要使用'秘钥字符串'进行加密的字符串!";
	//使用字符串格式的公钥私钥加密解密
	NSString *encryptStr2 = [RSAEncryptor encryptString:originalString2 publicKey:@"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDqlGsxZ9n/DAx0JcUElDaIxNFFtnz3Y0hWcS9ihqo7FvqRS9KIiJ+Z/ngiR4249VZvW673dI0OdE2yw9Zovfv9g2lpnzIqOI1x3oxnzXc0urlRQrhB63tuxAGnYL4gakd4d6P4IFLuU9papXwYP8Zo0877miI81joQcQfi0Emg5wIDAQAB"];
	NSLog(@"加密前:%@", originalString2);
	NSLog(@"加密后:%@", encryptStr2);
	NSLog(@"解密后:%@", [RSAEncryptor decryptString:encryptStr2 privateKey:@"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAOqUazFn2f8MDHQlxQSUNojE0UW2fPdjSFZxL2KGqjsW+pFL0oiIn5n+eCJHjbj1Vm9brvd0jQ50TbLD1mi9+/2DaWmfMio4jXHejGfNdzS6uVFCuEHre27EAadgviBqR3h3o/ggUu5T2lqlfBg/xmjTzvuaIjzWOhBxB+LQSaDnAgMBAAECgYEAsT0UxM6Pwonq+vLyqmQF1E7JQ9//CbglFtMMF2hiRKU3CwL7/pcj5+mCAXyI0z/jX94pE+UnEs3DSxd278rkEhSa0hChPblD3UCQ23rwaHQoW3f63Qp9zEeIy9bjJvHiVbod+9RPHpwWCGXL/ElUFdbRfJpSPipqPxBXrMnmTMECQQD34pVoE5ZUH/JrjU4Tk3lJ+zjmjjj+vgud+swTWBCcfJ/aTlpzxzGlfeO9ha0vVxYsBvjEdujF7STviLDKSLqHAkEA8kJUNdyPlpn/fwAiXbxnBHrTaCGCb+7dZTAEjhB5ZlXQ8fpscGtw2j2GaWE2mRcKQt4VpNW0MK7PcLtqCWueoQJBAM5bxIFV/QmfZtJ+WgcV+BzMlPvqXixDzawAgy9/WqTLYs/79nT32K6qdJLr29bTKtQQIbx8OR+8Yck/A94CWbUCQF9GMrQUD+xcmBysQte2dpVOcMHtG81FlZBr9/6e//99FHV11RvJRVKvC6N59ezzILf3e2+eFAVpWm+tZSBbUMECQQCzo8d0mswbigvXDcJScY8dwSN0wV1GAnKMaYdE1hoz35ffaxPO6TY3oAAcKSzXAgisBpMPkPWMBdQw+HFMZ2uP"]);

}

- (void)md5_check{
	NSString *msg = @"123456789";
	
	NSLog(@"MD5加密:%@",[msg md5]);
	NSLog(@"MD5_base64加密:%@",[msg md5_base64]);
}

- (void)sha1_check{
	NSString *msg = @"123456789";
	
	NSLog(@"SHA1:%@",[msg sha1]);
	NSLog(@"SHA1_base64加密:%@",[msg sha1_base64]);
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
