# iosct

iOS call trap cordova plugin

## Install

    cordova plugin add https://github.com/creox-cz/iosct.git

## Use

```js
cordova.plugins.IOSCT.registerListener((s) => {
    console.log('IOSCT - Listener registered')
    window.addEventListener('IOSCT.callStatusChanged.incoming', function(event) {
        console.log('Someone calls you')
    })
    window.addEventListener('IOSCT.callStatusChanged.ended', function(event) {
        console.log('Call is ended')
    })
    window.addEventListener('IOSCT.callStatusChanged.connected', function(event) {
        console.log('Call is active')
    })
    window.addEventListener('IOSCT.callStatusChanged.dialing', function(event) {
        console.log('You call someone')
    })
}, (e) => {
    console.log('IOSCT - Listener NOT registered')
})
```