#!/bin/bash
mkdir -p tmp
pushd tmp
curl -O "http://appldnld.apple.com/Safari5/041-5467.20120509.F6PPX/Safari5.1.7LionManual.dmg"
hdiutil attach Safari*.dmg -nobrowse
pkgutil --expand /Volumes/Safari*for*/Safari*.pkg dmg
diskutil unmount /Volumes/Safari*for*
mkdir -p payload
pushd payload
cat ../dmg/Safari*.pkg/Payload | gzip -d - | cpio -id
mkdir -p Applications/Safari.app/Contents/Frameworks
mv System/Library/{Frameworks,PrivateFrameworks,StagedFrameworks/Safari}/*.framework Applications/Safari.app/Contents/Frameworks
ln -s ../../../../../ Applications/Safari.app/Contents/Frameworks/PubSub.framework/Versions/A/Resources/PubSubAgent.app/Contents/Frameworks
ln -s ../../../ Applications/Safari.app/Contents/Frameworks/WebKit.framework/WebKitPluginHost.app/Contents/Frameworks
ln -s ../../../ Applications/Safari.app/Contents/Frameworks/WebKit2.framework/PluginProcess.app/Contents/Frameworks
ln -s ../../../ Applications/Safari.app/Contents/Frameworks/WebKit2.framework/WebProcess.app/Contents/Frameworks
binaries=(Frameworks/JavaScriptCore.framework/Versions/A/JavaScriptCore Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc Frameworks/PubSub.framework/Versions/A/PubSub Frameworks/PubSub.framework/Versions/A/Resources/PubSubAgent.app/Contents/MacOS/PubSubAgent Frameworks/Safari.framework/Versions/A/Safari Frameworks/SyndicationUI.framework/Versions/A/SyndicationUI Frameworks/WebCore.framework/Versions/A/WebCore Frameworks/WebKit.framework/Versions/A/WebKit Frameworks/WebKit.framework/WebKitPluginAgent Frameworks/WebKit.framework/WebKitPluginHost.app/Contents/MacOS/WebKitPluginHost Frameworks/WebKit.framework/WebKitPluginHost.app/Contents/MacOS/WebKitPluginHostShim.dylib Frameworks/WebKit2.framework/PluginProcess.app/Contents/MacOS/PluginProcess Frameworks/WebKit2.framework/PluginProcess.app/Contents/MacOS/PluginProcessShim.dylib Frameworks/WebKit2.framework/Versions/A/WebKit2 Frameworks/WebKit2.framework/WebProcess.app/Contents/MacOS/WebProcess Frameworks/WebKit2.framework/WebProcess.app/Contents/MacOS/WebProcessShim.dylib MacOS/Safari "Safari Webpage Preview Fetcher" SafariSyncClient.app/Contents/MacOS/SafariSyncClient)
for binary in "${binaries[@]}"
do
	install_name_tool \
		-change {/System/Library/Private,@executable_path/../}Frameworks/Safari.framework/Versions/A/Safari \
		-change {/System/Library/Private,@executable_path/../}Frameworks/SyndicationUI.framework/Versions/A/SyndicationUI \
		-change {/System/Library/,@executable_path/../}Frameworks/JavaScriptCore.framework/Versions/A/JavaScriptCore \
		-change {/System/Library/,@executable_path/../}Frameworks/PubSub.framework/Versions/A/PubSub \
		-change {/System/Library/,@executable_path/../}Frameworks/WebKit.framework/Versions/A/WebKit \
		-change {/System/Library/Private,@executable_path/../}Frameworks/WebKit2.framework/Versions/A/WebKit2 \
		-change /System/Library/Frameworks/WebKit.framework/Versions/A/Frameworks/WebCore.framework/Versions/A/WebCore @executable_path/../Frameworks/WebCore.framework/Versions/A/WebCore \
		"Applications/Safari.app/Contents/$binary"
done
mv Applications/Safari.app ~/Desktop/Safari\ 5.1.7.app
popd
popd
rm -rf tmp
echo "Safari 5.1.7 is now on your desktop"