//
//  ViewController.m
//  ZipExtractor
//
//  Created by appledeveloper on 12/03/19.
//  Copyright © 2019 Senthilkumar K. All rights reserved.
//

#import "ViewController.h"
#import <SSZipArchive.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self getCacheDirectory];
    
    
    // Copy Zip file and Paste to Cache Directory
    [self extractWithZipFolder:@"PathTraversal" zipfileName:@"PathTraversal"];
}

-(NSString*) getCacheDirectory {
    
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"Cache Directory = %@",cacheDirectory);
    
    return cacheDirectory;
    
}


-(void)extractWithZipFolder:(NSString*)folderName zipfileName:(NSString*)fileName {
    
    // Source Path - Tar File
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *finalName = [NSString stringWithFormat:@"%@.zip",fileName];
    NSString *sourcePath = [cacheDirectory stringByAppendingPathComponent:finalName];
    
    
    
    NSString *destinationPath;
    NSError *error;
    
    // Destination Folder - Own Empty Folder
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    
    NSString *slashStr = [NSString stringWithFormat:@"/"];
    NSString *dirName = [NSString stringWithFormat:@"%@%@",slashStr,folderName];
    destinationPath = [documentsDirectory stringByAppendingPathComponent:dirName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:destinationPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
    
    
    // Unzip
    [SSZipArchive unzipFileAtPath:sourcePath toDestination:destinationPath];
}


@end
