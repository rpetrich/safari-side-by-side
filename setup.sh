#!/bin/bash
mkdir -p tmp
pushd tmp
if [ ! -e "$HOME/Desktop/Safari 5.1.7.app" ]; then
	if [ ! \( -e "Safari5.1.7LionManual.dmg" \) ]; then
		curl -O "http://appldnld.apple.com/Safari5/041-5467.20120509.F6PPX/Safari5.1.7LionManual.dmg"
	fi
	hdiutil attach Safari*.dmg -nobrowse
	rm -rf pkg51
	pkgutil --expand /Volumes/Safari*for*/Safari*.pkg pkg51
	diskutil unmount /Volumes/Safari*for*
	rm -rf payload51/*
	mkdir -p payload51
	pushd payload51
	cat ../pkg51/Safari*.pkg/Payload | gzip -d - | cpio -id
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
fi
if [ ! \( -e "$HOME/Desktop/Safari 6.0.5.app" \) ]; then
	if [ ! \( -e "Safari6.0.5Lion.pkg" \) ]; then
		curl -O http://swcdn.apple.com/content/downloads/39/34/041-9890/a9f2rl890332pqy0s9jw9uq4quq9lscu31/Safari6.0.5Lion.pkg
	fi
	rm -rf pkg60
	pkgutil --expand Safari6.0.5Lion.pkg pkg60
	rm -rf payload60/*
	mkdir -p payload60
	pushd payload60
	cat ../pkg60/Payload | gzip -d - | cpio -id
	mkdir -p Applications/Safari.app/Contents/Frameworks
	mv System/Library/{PrivateFrameworks,StagedFrameworks/Safari}/*.framework Applications/Safari.app/Contents/Frameworks
	ln -s ../../../ Applications/Safari.app/Contents/Frameworks/WebKit.framework/WebKitPluginHost.app/Contents/Frameworks
	ln -s ../../../ Applications/Safari.app/Contents/Frameworks/WebKit2.framework/PluginProcess.app/Contents/Frameworks
	ln -s ../../../ Applications/Safari.app/Contents/Frameworks/WebKit2.framework/WebProcess.app/Contents/Frameworks
	binaries=(Frameworks/JavaScriptCore.framework/Versions/A/JavaScriptCore Frameworks/Safari.framework/Versions/A/Safari Frameworks/WebCore.framework/Versions/A/WebCore Frameworks/WebKit.framework/Versions/A/WebKit Frameworks/WebKit.framework/WebKitPluginAgent Frameworks/WebKit.framework/WebKitPluginHost.app/Contents/MacOS/WebKitPluginHost Frameworks/WebKit.framework/WebKitPluginHost.app/Contents/MacOS/WebKitPluginHostShim.dylib Frameworks/WebKit2.framework/PluginProcess.app/Contents/MacOS/PluginProcess Frameworks/WebKit2.framework/PluginProcess.app/Contents/MacOS/PluginProcessShim.dylib Frameworks/WebKit2.framework/Versions/A/WebKit2 Frameworks/WebKit2.framework/WebProcess.app/Contents/MacOS/WebProcess Frameworks/WebKit2.framework/WebProcess.app/Contents/MacOS/WebProcessShim.dylib MacOS/Safari SafariSyncClient.app/Contents/MacOS/SafariSyncClient)
	for binary in "${binaries[@]}"
	do
		install_name_tool \
			-change {/System/Library/Private,@executable_path/../}Frameworks/Safari.framework/Versions/A/Safari \
			-change {/System/Library/Private,@executable_path/../}Frameworks/SyndicationUI.framework/Versions/A/SyndicationUI \
			-change {/System/Library/,@executable_path/../}Frameworks/JavaScriptCore.framework/Versions/A/JavaScriptCore \
			-change {/System/Library/,@executable_path/../}Frameworks/WebKit.framework/Versions/A/WebKit \
			-change {/System/Library/Private,@executable_path/../}Frameworks/WebKit2.framework/Versions/A/WebKit2 \
			-change /System/Library/Frameworks/WebKit.framework/Versions/A/Frameworks/WebCore.framework/Versions/A/WebCore @executable_path/../Frameworks/WebCore.framework/Versions/A/WebCore \
			"Applications/Safari.app/Contents/$binary"
	done
	mv Applications/Safari.app ~/Desktop/Safari\ 6.0.5.app
	popd
fi
popd
echo "Safari 5.1.7 and Safari 6.0.5 are now on your desktop"
