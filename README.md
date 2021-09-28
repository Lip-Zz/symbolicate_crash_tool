# Symbolicate Crash Tool
![Swift](https://img.shields.io/badge/Swift-5.4.2-green?style=flat-square)   ![MacOS](https://img.shields.io/badge/Platforms-macOS-green?style=flat-square) 

A small tool to symbolize crash files(一个用来符号化crash文件的小工具)
- [Features](#features)
- [FAQ](#faq)

<img src="https://github.com/Zhao-Chuan/symbolicate_crash_tool/blob/develop/thumb/thumb.jpg?raw=true" alt="20210927113906" style="zoom: 30%;" />


## Features
- [x] Symbolic crash file



## FAQ

### How do I generate a crash log?
plcrashreporter:https://github.com/microsoft/plcrashreporter
KSCrash:https://github.com/kstenerud/KSCrash
Or write it yourself.

### How do I get the device support file?
1. When you need to symbolicate a crash report, check the `Code Type` and `OS Version` section. Such as:`Code Type:       ARM-64`
`OS Version:      iOS 10.2 (14C82)`. That means you need `arm64`version symbols of `10.2 (14C82)`system.

2. Find the package in my sharing folder and extract it to `~/Library/Developer/Xcode/iOS DeviceSupport`. (Check the file's name and path, it should be`~/Library/Developer/Xcode/iOS DeviceSupport/10.2 (14C82)/Symbols`).

3. Use Xcode's`symbolicatecrash` tool to symbolicate your crash report. This tool will search system symbols in the`iOS DeviceSupport`path automatically. Read this to learn how to use`symbolicatecrash`: [Symbolicating an iOS Crash Report](https://www.apteligent.com/developer-resources/symbolicating-an-ios-crash-report/?partner_code=GDC_so_symbolicateios).

How to extract symbols from firmware:

1. Download the ipsw firmware (not OTA files), corresponding the system version you need
2. Uncompress the firmware file as zip, find the biggest dmg file(it's the iOS system file image)
3. If the version of the firmare system is higher than iOS 10, the dmg is not encrypted. So just double click to load the image, and go to step `6`
4. If the version is lower than iOS 10, you have to decrypt the dmg file with corresponding firmware key. Find key in [Firmware_Keys](https://www.theiphonewiki.com/wiki/Firmware_Keys)(Under`Root Filesystem`section in the corresponding firmware page)
5. Decrypt dmg file with its key. You can use the `dmg`tool in [tools](https://github.com/Zuikyo/iOS-System-Symbols/tree/master/tools):`./dmg extract encrypted.dmg decrypted.dmg -k <firmware_key>`. Then you get the `decrypted.dmg`, double click to load the image
6. In the image folder, go to `System/Library/Caches/com.apple.dyld/`, you can get `dyld_shared_cache_arm64`, `dyld_shared_cache_armv7s`,`dyld_shared_cache_armv7`, they are the compressed system frameworks
7. Uncompress `dyld_shared_cache_armxxx` with `dsc_extractor` tool in Apple's dyld project. I put it in [tools](https://github.com/Zuikyo/iOS-System-Symbols/tree/master/tools):`./dsc_extractor ./dyld_shared_cache_armxxx ./output`
8. If you need all arm64, armv7s and armv7 of frameworks, you need to extract `dyld_shared_cache_arm64`, `dyld_shared_cache_armv7s`,`dyld_shared_cache_armv7`all. Before Xcode 11, `dsc_extractor`will merge different architectures into same files when extracting to a same directory
9. After Xcode 11 for iOS 13.2, `dsc_extractor` won't merge different architectures files. We need to merge symbols with `lipo` command. Try [merge_symbols.sh](https://github.com/Zuikyo/iOS-System-Symbols/tree/master/tools/merge_symbols.sh) : ` sh merge_symbols.sh <path_to_extracted_arm64e_symbols> <path_to_extracted_arm64_symbols>`
10. Then you get all system frameworks of this firmware in output folder. Put those files into a folder as a symbol file hierarchy, such as `12.0 (16A5288q)/Symbols/`, and you can use this folder to symbolicate crash report now
