//
//  MYViewController.m
//  MYVersion
//
//  Created by chs_net on 14/6/24.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "MYViewController.h"
#import "ZMYVersionNotes.h"
@interface MYViewController ()
{
    NSString *url;
}
@end

@implementation MYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [ZMYVersionNotes isAppVersionUpdatedWithAppIdentifier:@"584296227" updatedInformation:^(NSString *releaseNoteText, NSString *releaseVersionText, NSDictionary *resultDic) {
        
        UIAlertView *createUserResponseAlert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"已更新版本:%@", releaseVersionText] message:releaseNoteText delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        createUserResponseAlert.tag = 1101;
        [createUserResponseAlert show];
        
    } latestVersionInformation:^(NSString *releaseNoteText, NSString *releaseVersionText, NSDictionary *resultDic) {
        UIAlertView *createUserResponseAlert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"有新版本:%@", releaseVersionText] message:releaseNoteText delegate:self cancelButtonTitle:@"忽略" otherButtonTitles: @"进行下载", @"下次再说",nil];
        url = [resultDic objectForKey:@"trackViewUrl"];
        createUserResponseAlert.tag = 1102;
        [createUserResponseAlert show];
    } completionBlockError:^(NSError *error) {
        NSLog(@"An error occurred: %@", [error localizedDescription]);
    }];
}
- (IBAction)playPhoto:(id)sender {
    [ZMYVersionNotes isOrNotTheLatestVersionInformationWithAppIdentifier:@"584296227" isOrNotTheLatestVersionCompletionBlock:^(BOOL isLatestVersion, NSString *releaseNoteText, NSString *releaseVersionText, NSDictionary *resultDic) {
        if (isLatestVersion) {
            UIAlertView *createUserResponseAlert = [[UIAlertView alloc] initWithTitle:@"已是最新版" message:releaseNoteText delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            createUserResponseAlert.tag = 1101;
            [createUserResponseAlert show];
        }else{
            UIAlertView *createUserResponseAlert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"有新版本:%@", releaseVersionText] message:releaseNoteText delegate:self cancelButtonTitle:@"忽略" otherButtonTitles: @"进行下载", @"下次再说",nil];
            url = [resultDic objectForKey:@"trackViewUrl"];
            createUserResponseAlert.tag = 1102;
            [createUserResponseAlert show];
        }
    } completionBlockError:^(NSError *error) {
        NSLog(@"An error occurred: %@", [error localizedDescription]);
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1102) {
        switch (buttonIndex) {
            case 1:
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
                break;
                
            default:
                break;
        }
    }
}



@end
