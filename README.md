# AndroidLibV2rayLite

## Build requirements
* JDK
* Android SDK
* Go
* gomobile

## Build instructions
1. `git clone [repo] && cd AndroidLibV2rayLite`
2. `bash gen_assets.sh download` (to download required GeoIP/GeoSite data)
3. `gomobile init`
4. `go mod tidy -v`
5. `gomobile bind -v -androidapi 21 -ldflags='-s -w' ./`
