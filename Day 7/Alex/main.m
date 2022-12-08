#import <Foundation/Foundation.h>

struct Dir {
    NSString* name;
    NSMutableArray* files;
    NSMutableArray* dirs;
};

struct File{
    NSString* name;
    int size;
};

void custom_print(NSString* str){
    [[NSFileHandle fileHandleWithStandardOutput] writeData: [[str stringByAppendingString: @"\n"] dataUsingEncoding: NSUTF8StringEncoding]];
}

void print_dir(struct Dir dir){
    for (NSValue *fileValue in dir.files) {
        struct File file;
        [fileValue getValue: &file];
        custom_print([NSString stringWithFormat: @"%d %@", file.size, file.name]);
    }
    for (NSString *dirName in dir.dirs) {
        custom_print([NSString stringWithFormat: @"dir %@", dirName]);
    }
}

NSMutableArray* sortDirectories(NSArray *dirNames){
    NSMutableArray* sortedDirs = [dirNames mutableCopy];
    for (int i = 0; i < [sortedDirs count]; i++) {
        for (int j = i+1; j < [sortedDirs count]; j++) {
            if ([[sortedDirs objectAtIndex: j] length] > [[sortedDirs objectAtIndex: i] length]){
                [sortedDirs exchangeObjectAtIndex: i withObjectAtIndex: j];
            }
        }
    }
    return sortedDirs;
}

void print_du(NSMutableDictionary *fileTree, NSMutableDictionary *duDict){
    NSMutableArray* sortedDirs = sortDirectories([fileTree allKeys]);
    // Remove the root directory from the end of the array
    [sortedDirs removeLastObject];
    // Add it to the beginning of the array
    [sortedDirs insertObject: @"" atIndex: 0];
    // Print the directory tree with the total size of each directory
    for (NSString *key in sortedDirs) {
        struct Dir dir;
        [[fileTree objectForKey: key] getValue: &dir];
        custom_print([NSString stringWithFormat: @"%@: %d", key, [[duDict objectForKey: key] intValue]]);       
    }
}

NSMutableArray* cd (NSMutableArray *dirStack, NSString *path) {
    if ([path hasPrefix: @"/"]){
        dirStack = [[NSMutableArray alloc] init];
        [dirStack addObject: @""];
    }else{
        NSArray *pathComponents = [path componentsSeparatedByString: @"/"];
        for (NSString *component in pathComponents) {
            if ([component isEqualToString: @".."]){
                if ([dirStack count] > 1)
                    [dirStack removeLastObject];
            }else if ([component isEqualToString: @"."]){
                // Do nothing
            }else{
                [dirStack addObject: component];
            }
        }
    }
    return dirStack;
}

int ls(NSString *currentDir, NSMutableDictionary *fileTree, int i, NSArray *lines){
    struct Dir currentDirStruct;
    currentDirStruct.name = currentDir;
    currentDirStruct.files = [[NSMutableArray alloc] init];
    currentDirStruct.dirs = [[NSMutableArray alloc] init];

    // While the next line doesn't start with $
    while (i < [lines count] && ![[lines objectAtIndex: i] hasPrefix: @"$"]){
        NSString* file = [lines objectAtIndex: i];
        if ([file hasPrefix: @"d"]){
            NSString* dir = [file substringFromIndex: 4];
            // Decode the dir struct stored at currentDir in fileTree
            [currentDirStruct.dirs addObject: dir];
        }else{
            // Split string by " "
            NSArray *fileComponents = [file componentsSeparatedByString: @" "];
            struct File currentFile;
            currentFile.name = [fileComponents objectAtIndex: 1];
            currentFile.size = [[fileComponents objectAtIndex: 0] intValue];
            [currentDirStruct.files addObject: [NSValue valueWithBytes: &currentFile objCType: @encode(struct File)]];
        }
        i++;
    }

    // Encode the dir struct and store it at currentDir in fileTree
    [fileTree setObject: [NSValue valueWithBytes: &currentDirStruct objCType: @encode(struct Dir)] forKey: currentDir];

    return i-1;
}

/**
 * Returns a dictionary with the total size of each directory
 */
NSMutableDictionary* du(NSMutableDictionary *fileTree){
    NSMutableDictionary *duDict = [[NSMutableDictionary alloc] init];

    // Order dict keys by length (longest first)
    NSMutableArray *sortedKeys = sortDirectories([fileTree allKeys]);

    // Iterate over the keys
    for (NSString *key in sortedKeys) {
        struct Dir dir;
        [[fileTree objectForKey: key] getValue: &dir];
        int totalSize = 0;
        for (NSValue *fileValue in dir.files) {
            struct File file;
            [fileValue getValue: &file];
            totalSize += file.size;
        }
        for (NSString *dirName in dir.dirs) {
            totalSize += [[duDict objectForKey: [NSString stringWithFormat: @"%@/%@", key, dirName]] intValue];
        }
        [duDict setObject: [NSNumber numberWithInt: totalSize] forKey: key];
    }

    return duDict;
}

int sumFiles(NSMutableDictionary *duDict, int size_limit){
    int totalSize = 0;
    for (NSString *key in [duDict allKeys]) {
        if ([[duDict objectForKey: key] intValue] < size_limit){
            totalSize += [[duDict objectForKey: key] intValue];
        }
    }
    return totalSize;
}

int freeForUpdate(NSMutableDictionary *duDict, int totalSpace, int desiredFreeSpace){
    // Get the size of the smallest directory that would leave the desired free space after being deleted
    int minSize = 0;
    int occupiedSpace = [[duDict objectForKey: @""] intValue];
    int actualFreeSpace = totalSpace - occupiedSpace;
    for (NSString *key in [duDict allKeys]) {
        if (actualFreeSpace + [[duDict objectForKey: key] intValue] >= desiredFreeSpace){
            if (minSize == 0 || [[duDict objectForKey: key] intValue] < minSize){
                minSize = [[duDict objectForKey: key] intValue];
            }
        }
    }

    return minSize;
}

int main(void){
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

    // Problem setup
    NSMutableArray* dirStack = [[NSMutableArray alloc] init];
    NSMutableDictionary* fileTree = [[NSMutableDictionary alloc] init];

    // Read whole input
    NSString *allInput;
    NSFileHandle *kbd = [NSFileHandle fileHandleWithStandardInput];
    NSData *inputData = [kbd availableData];
    allInput= [[NSString alloc] initWithData:inputData encoding:NSUTF8StringEncoding];

    // Input loop
    NSArray *lines = [allInput componentsSeparatedByString: @"\n"];

    int i = 0;
    while (i < [lines count]) {
        NSString* input = [lines objectAtIndex: i];
        if ([input hasPrefix: @"$"]){
            NSString* command = [input substringFromIndex: 2];
            custom_print(input);
            if ([command hasPrefix: @"cd"]){
                NSString* path = [command substringFromIndex: 3];
                dirStack = cd(dirStack, path);
                if ([dirStack count] == 1)
                    custom_print(@"/");
                else{
                    custom_print([dirStack componentsJoinedByString: @"/"]);
                }
            }else if ([command hasPrefix: @"ls"]){
                NSString* currentDir = [dirStack componentsJoinedByString: @"/"];
                i = ls(currentDir, fileTree, i+1, lines);
                struct Dir currentDirStruct;
                [[fileTree objectForKey: currentDir] getValue: &currentDirStruct];
                print_dir(currentDirStruct);
            }else if ([command hasPrefix: @"du"]){
                NSMutableDictionary *duDict = du(fileTree);
                //print_du(fileTree,duDict);
                custom_print([@"The total sum of files not greater than 100000 is:" stringByAppendingFormat: @" %d", sumFiles(duDict, 100000)]);
                custom_print([@"The minimum size of a directory that frees 30000000 is:" stringByAppendingFormat: @" %d", freeForUpdate(duDict, 70000000, 30000000)]);
            }else
                custom_print(@"Unknown command");
        }else{
            //custom_print(input);
        }
        i++;
    }

    [pool release];
    return 0;
}