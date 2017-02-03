//
//  UAGAppDelegate.m
//  gym
//
//  Created by Artem Ustimov on 11/8/16.
//  Copyright © 2016 Artem Ustimov. All rights reserved.
//

#import <Realm/Realm.h>

#import "UAGAppDelegate.h"
#import "UAGJournalItem.h"

@interface UAGAppDelegate ()

@end

@implementation UAGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    RLMRealmConfiguration * config = [RLMRealmConfiguration defaultConfiguration];
    // Set the new schema version. This must be greater than the previously used
    // version (if you've never set a schema version before, the version is 0).
    config.schemaVersion = 2;
    
    // Set the block which will be called automatically when opening a Realm with a
    // schema version lower than the one set above
    config.migrationBlock = ^(RLMMigration * migration, uint64_t oldSchemaVersion) {
        // We haven’t migrated anything yet, so oldSchemaVersion == 0
        if (oldSchemaVersion < 1) {
            // Nothing to do!
            // Realm will automatically detect new properties and removed properties
            // And will update the schema on disk automatically
        }
        
        if (oldSchemaVersion < 2) {
            [migration enumerateObjects:UAGTraining.className block:^(RLMObject * oldObject, RLMObject * newObject) {
                newObject[@"deleted"] = [NSNumber numberWithBool:NO];
            }];
        }
    };
    
    // Tell Realm to use this new configuration object for the default Realm
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    NSURL * defaultRealmUrl = [RLMRealmConfiguration defaultConfiguration].fileURL;
    
    NSURL * tempRealmUrl = [[defaultRealmUrl URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"temp.realm"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:tempRealmUrl.path]) {
        [[NSFileManager defaultManager] removeItemAtURL:tempRealmUrl error:nil];
    }
    
    // Remove default Realm (for development purposes)
//    if ([[NSFileManager defaultManager] fileExistsAtPath:defaultRealmUrl.path]) {
//        [[NSFileManager defaultManager] removeItemAtURL:defaultRealmUrl error:nil];
//    }
    
    // Deploy bundled Realm after first run
    if (![[NSFileManager defaultManager] fileExistsAtPath:defaultRealmUrl.path]) {
        [self deployDatabaseFromBundle];
    } else {
        [self moveCurrentDatabaseFromURL:defaultRealmUrl toURL:tempRealmUrl];
        
        [self deployDatabaseFromBundle];
        
        RLMRealmConfiguration * oldDbConfig = [RLMRealmConfiguration defaultConfiguration];
        oldDbConfig.fileURL = tempRealmUrl;
        oldDbConfig.readOnly = true;
        
        RLMRealm * oldRealm = [RLMRealm realmWithConfiguration:oldDbConfig error:nil];
        NSLog(@"Old realm url: %@", [oldRealm configuration].fileURL);
        
        RLMRealm * realm = [RLMRealm defaultRealm];
        NSLog(@"Default realm url: %@", [realm configuration].fileURL);
        
        RLMResults * userTrainings = [UAGTraining allObjectsInRealm:oldRealm];
        
        [realm beginWriteTransaction];
        
        for (id training in userTrainings) {
            [UAGTraining createOrUpdateInRealm:realm withValue:training];
        }
        
        [realm commitWriteTransaction];
        
        NSLog(@"\n\nJournal objects: %ld\n\nConfig: %@", (unsigned long)[[UAGJournalItem allObjectsInRealm:realm] count], [realm configuration].fileURL);
        
        RLMResults * journalItems = [UAGJournalItem allObjectsInRealm:oldRealm];
        for (id journalItem in journalItems) {
            
            UAGJournalItem * journalItemCopy = [journalItem copy];
            
            NSLog(@"%@ [%i]", [journalItemCopy name], [[journalItemCopy training] id]);
            
            if (!journalItemCopy.isPhoto) {
                UAGTraining * copyedTraining = [UAGTraining objectForPrimaryKey:[NSNumber numberWithInt:journalItemCopy.training.id]];
                
                NSLog(@"%i", copyedTraining.id);
                
                journalItemCopy.training = copyedTraining;
            }
            
            [realm beginWriteTransaction];
            [UAGJournalItem createInRealm:realm withValue:journalItemCopy];
            [realm commitWriteTransaction];
            
            NSLog(@"\n\nJournal objects: %ld\n\nConfig: %@", (unsigned long)[[UAGJournalItem allObjectsInRealm:realm] count], [realm configuration].fileURL);
        }
    }
    
    return YES;
}

- (void)deployDatabaseFromBundle {
    NSURL * databaseUrl = [[NSBundle mainBundle] URLForResource:@"db" withExtension:@"realm"];
    NSError * error = nil;
    NSURL * deployUrl = [RLMRealmConfiguration defaultConfiguration].fileURL;
    
    [[NSFileManager defaultManager] copyItemAtURL:databaseUrl toURL:deployUrl error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    NSLog(@"DB deployed at url: %@", deployUrl);
}

- (void)moveCurrentDatabaseFromURL:(NSURL *)defaultRealmUrl toURL:(NSURL *)tempRealmUrl  {
    NSError * error = nil;
    
    [[NSFileManager defaultManager] copyItemAtURL:defaultRealmUrl toURL:tempRealmUrl error:&error];
    
    if (error) {
        NSLog(@"%@", error);
    }
    
    [[NSFileManager defaultManager] removeItemAtURL:defaultRealmUrl error:&error];
    
    if (error) {
        NSLog(@"%@", error);
    }
    
    NSLog(@"Current DB %@ moved to temporary url %@", defaultRealmUrl, tempRealmUrl);
}

@end
