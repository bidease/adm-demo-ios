//  ADMs.m
//  AdMarkupDemo
//

#import "ADMs.h"

static NSString* get_adm_from_OpenRTB_response(NSString* __nonnull openRTB_response)
{
    if (0 == openRTB_response.length)
    {
        return nil;
    }
    
    NSDictionary* response = [NSJSONSerialization JSONObjectWithData:[openRTB_response dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    if (nil == response)
    {
        return nil;
    }
    
    NSString *adm_ = [[[[response[@"seatbid"] firstObject] objectForKey:@"bid"] firstObject]objectForKey:@"adm"];
    
    return adm_;
}

static NSNumber* get_storeId_from_OpenRTB_response(NSString* __nonnull openRTB_response)
{
    if (0 == openRTB_response.length)
    {
        return nil;
    }
    
    NSDictionary* response = [NSJSONSerialization JSONObjectWithData:[openRTB_response dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    if (nil == response)
    {
        return nil;
    }
    
    NSDictionary *bid =
        [[response[@"seatbid"] firstObject][@"bid"] firstObject];
    
    NSString* b = bid[@"bundle"];
    if (nil == b ||
        0 == b.integerValue)
    {
        return nil;
    }
    
    return @(b.integerValue);
}

static NSString* response_mraid2_vungle_sample1 = @"{\
    \"id\": \"6570e22fe062274548a5339e\",\
    \"cur\": \"USD\",\
    \"seatbid\": [\
        {\
            \"bid\": [\
                {\
                    \"id\": \"0x419Hy4AI2bww2s\",\
                    \"adid\": \"364988\",\
                    \"cid\": \"1622633822_ios\",\
                    \"crid\": \"6f29db49ff\",\
                    \"impid\": \"1\",\
                    \"price\": 2.3,\
                    \"adomain\": [\
                        \"5ka.ru\"\
                    ],\
                    \"bundle\": \"1622633822\",\
                    \"cat\": [\
                        \"IAB8\"\
                    ],\
                    \"iurl\":\"https://storage.googleapis.com/s3.be.wtf/sdk/x5club.png\",\
                    \"nurl\": \"https://track-win-us.bidease.com/win?x=0x419Hy4AI2bww2s&win_price=${AUCTION_PRICE}&min_to_win=${AUCTION_MIN_TO_WIN}&min_bid_to_win=${AUCTION_MINIMUM_BID_TO_WIN}\",\
                    \"lurl\": \"https://track-loss-us.bidease.com/loss?x=0x419Hy4AI2bww2s&loss_reason=${AUCTION_LOSS}&win_price=${AUCTION_PRICE}&min_to_win=${AUCTION_MIN_TO_WIN}&min_bid_to_win=${AUCTION_MINIMUM_BID_TO_WIN}&mbr=${AUCTION_MBR}\",\
                    \"burl\": \"https://track-us.bidease.com/imp?x=0x419Hy4AI2bww2s&win_price=${AUCTION_PRICE}\",\
                    \"adm\": \"<!DOCTYPE html>\\n<html>\\n<head>\\n  <meta name='viewport' content='width=device-width,initialscale=1,maximum-scale=1'>\\n  <script src=\\\"mraid.js\\\"></script>\\n  <script src=\\\"https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js\\\"></script>\\n  <style type=\\\"text/css\\\">\\n    body {\\n      margin: 0;\\n      padding: 0;\\n      color: white;\\n      background-color: #000000;\\n    }\\n    .top-right { right: 20px; top: 20px; }\\n    .top-left { left: 20px; top: 20px; }\\n    .bottom-right { right: 20px; bottom: 20px; }\\n    .bottom-left { left: 20px; bottom: 20px; }\\n    .main-banner {\\n      max-height: 100%;\\n      max-width: 100%;\\n      z-index: 0;\\n      padding: 0;\\n      top: 0;\\n      bottom: 0;\\n      left: 0;\\n      right: 0;\\n      margin: auto;\\n      position: absolute;\\n    }\\n    .close-button {\\n      image-resolution: 300dpi;\\n      z-index: 999599;\\n      position: fixed;\\n      display: none;\\n      visibility: hidden;\\n      display: inline-block;\\n      width: 45px;\\n      height: 45px;\\n      background: url(\\\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAMAAAAp4XiDAAAABGdBTUEAALGPC/xhBQAAAAFzUkdCAK7OHOkAAABIUExURQAAAAAAAAAAAAAAAAAAAAAAAAAAAEdwTAAAAMzMzMvLywAAAAAAAAAAAJ6engAAAAAAAAAAAO/v7////wAAAAAAAMzMzP///z7INcwAAAAXdFJOU2YDOyQLSV8AZ8PCZEJWoRMyEef+TlfEzkEE5QAAAVZJREFUSMel1uF2gyAMBeALBIraVk8r8/3fdGo3FRKUsfysfFVICODGgoy2wXWdC1Yb4s+Rjh8eiOIx0Cnp7xDi3mcJiWBFJBPjkA1nBKI0TkOrlCiLi7AqJmrEZYzqSErE9p4P0SgKvRODwjC/hFwpcfRD9gw+Wy8M9O1zy+mH9Lt4Tw03vpnem+lXsmekmSZu/PJru63aQujw9Isbn/wPzWTAmUkFhplE+yM1TCDcQDj5Di/MjmCQN5LwBhpZ48UV1LDIGVnMICBnZDEDqb7W0S9ZIFOQq5EFukzJ+uUdL0nMxP31LU6a/vlcgrDIxxUT9o/lqYzzwo1mBZNmnxmTliWvscR4SopfquTYhGSLsbriZog3slCJzFDcLsT9ERubNKX2usP0Seu77mN31mCvuuXWYCvaeM1hUXgkjep/B1/N8VpziNdcFaouJDXXnqrLVdEV7ht7xyTRi3UAKAAAAABJRU5ErkJggg==\\\") no-repeat;\\n      background-size: 25px;\\n      background-position: center;\\n    }\\n    /* upd */\\n    #bg-exit {\\n      display: block;\\n      position: absolute;\\n      cursor: pointer;\\n      width: 100%;\\n      height: 85%;\\n      z-index: 1;\\n      bottom: 0;\\n    }\\n    .branding {\\n      position: absolute;\\n      bottom: 3px;\\n      left: 3px;\\n      z-index: 999599;\\n      padding: 0px;\\n      max-width: 50px;\\n      height: auto;\\n      -moz-user-select: none;\\n      -webkit-user-select: none;\\n      user-select: none;\\n      pointer-events: none;\\n    }\\n  </style>\\n</head>\\n<body>\\n  <div class=\\\"close-button js-close-button top-right\\\" role=\\\"close\\\" onclick=\\\"clickClose(event)\\\"></div>\\n  <img src=\\\"https://creative-redirect.bidease.com/creative.bidease.com/media/res/2023/12/d48a47cf-3194.jpeg?campaign_id=76379&creative_id=364988&x=0x419Hy4AI2bww2s\\\" role=\\\"image\\\" class=\\\"main-banner js-banner\\\" />\\n  <img class=\\\"branding\\\" src=\\\"https://creative.bidease.com/media/2023/playable/07/playable/bidease/v4.png?campaign_id=76379&creative_id=364988&x=0x419Hy4AI2bww2s\\\">\\n  <script>\\n    var state = {\\n      width: 0,\\n      height: 0,\\n      state: 'loading',\\n      viewable: false\\n    };\\n    var rc = {\\n      adShown: false,\\n      exchange: \\\"vungle\\\",\\n      s2s: !!0,\\n      impcr: \\\"https://track-impcr-us.bidease.com/impcr?x=0x419Hy4AI2bww2s\\\",\\n      click: \\\"https://5ka.ru/?utm_referrer=\\\",\\n      target: \\\"https://5ka.ru/?utm_referrer=\\\",\\n      campaignID: \\\"76379\\\",\\n      bidID: \\\"0x419Hy4AI2bww2s\\\",\\n      event: \\\"https://track-us.bidease.com/event?x=0x419Hy4AI2bww2s&t=\\\",\\n      country: \\\"RUS\\\",\\n      ifa: \\\"\\\",\\n      rewarded: !!1,\\n      interstitial: !!1,\\n      dateLoad: new Date().getTime(),\\n      checkedErrors: {},\\n      clickTracked: false,\\n\\n      closeTimeout: parseInt(\\\"5000\\\"),\\n      closeHeight: parseInt(\\\"33\\\") / 100.0,\\n    };\\n    rc.clickTrackers = /adx/i.test(rc.exchange) ? [\\\"%%CLICK_URL_UNESC%%\\\"] : [];\\n    rc.noCustomClose = /unity|ironsource|bidmachine|chartboost|applovin|vungle|mobilityware/i.test(rc.exchange); /* upd */\\n    rc.useCustomCloseButton = !rc.rewarded && rc.interstitial && !rc.noCustomClose;\\n\\n    window.addEventListener(\\\"touchend\\\", touchEnd, false);\\n\\n    /* upd */\\n    if (/chartboost|unity|adx|mobilityware/i.test(rc.exchange)) {\\n      document.body.innerHTML += '<div id=\\\"bg-exit\\\" onclick=\\\"trackClick(event)\\\"></div>';\\n    }\\n\\n    /* Visual start ==========================================================*/\\n    function showCloseButton() {\\n      logEvent(\\\"show-close\\\");\\n      $(\\\".js-close-button\\\").css({ \\\"display\\\": \\\"block\\\", \\\"visibility\\\": \\\"visible\\\" });\\n    }\\n\\n    /* Helpers start ==========================================================*/\\n    function logEvent(eventName, data) {\\n      var elapsed = Math.round(new Date().getTime() - rc.dateLoad);\\n      var url = rc.event + eventName + \\\"&value=\\\" + elapsed;\\n      trackGetUrl(url);\\n    }\\n\\n    function trackGetUrl(url) {\\n      var eventLink = url;\\n      var hiddenSpan = document.createElement(\\\"span\\\");\\n      hiddenSpan.style.display = \\\"none\\\";\\n      var img = document.createElement(\\\"img\\\");\\n      img.src = eventLink;\\n      hiddenSpan.appendChild(img);\\n      document.body.appendChild(hiddenSpan);\\n    }\\n    function get(o, name, def) { if (!o) return def || \\\"\\\"; return o[name]; }\\n    function isLandscape() { return Math.abs(window.orientation) === 90 ? true : false; }\\n    function isMraid() { return typeof mraid !== 'undefined'; }\\n    /* Helpers end ==========================================================*/\\n\\n    function canShowAd() {\\n      //TODO: log attempt on debug\\n      if (isMraid()) {\\n        return state.width > 0 && state.height > 0 && state.viewable && state.state !== 'loading';\\n      } else {\\n        return $(window).width() > 0 && $(window).height() > 0;\\n      }\\n    }\\n\\n    function openLink(link) {\\n      logEvent(\\\"open-link\\\", { link });\\n      isMraid() ? mraid.open(link) : window.open(link);\\n    }\\n\\n    function clickClose(event) {\\n      if (!!event) event.preventDefault();\\n      if (isMraid()) mraid.close(); //TODO: log\\n    }\\n\\n    function trackClick(x, y, width, height) {\\n      var clickUrl = rc.click + \\\"&cx=\\\" + x + \\\"&cy=\\\" + y + \\\"&cw=\\\" + width + \\\"&ch=\\\" + height;\\n      if (/chartboost|unity|adx|mobilityware/i.test(rc.exchange)) { /* upd */\\n        var event_width = Math.round(window.innerWidth);\\n        var event_height = Math.round(window.innerHeight);\\n        var event_x = Math.round(event.offsetX) || 0;\\n        var event_y = Math.round(event.offsetY) || 0;\\n        clickUrl = rc.click + \\\"&cx=\\\" + event_x + \\\"&cy=\\\" + event_y + \\\"&cw=\\\" + event_width + \\\"&ch=\\\" + event_height;\\n      }\\n      if (rc.s2s) {\\n        trackGetUrl(clickUrl);\\n        openLink(rc.target);\\n      } else {\\n        openLink(clickUrl);\\n      }\\n    }\\n\\n    function tryToShowAdd() {\\n      if (rc.adShown) return;\\n      if (!canShowAd()) return;\\n      rc.adShown = true;\\n      logEvent(\\\"show-ad\\\", { orientation: isLandscape() });\\n      trackGetUrl(rc.impcr);\\n      \\n      if (rc.useCustomCloseButton && isMraid()) {\\n        setTimeout(showCloseButton, rc.closeTimeout);\\n      }\\n      // show ad logic\\n    }\\n    /* Visual end ==========================================================*/\\n    \\n    /* External events start ==========================================================*/\\n    window.onerror = function(msg, url, lineNo, columnNo, error) {\\n      if (!rc.checkedErrors[msg]) {\\n        rc.checkedErrors[msg] = true;\\n        if (!/webviewDidAppear/i.test(msg)) {\\n          logEvent(\\\"global-error\\\");\\n          var debugInfo = {};\\n          $.ajax(\\\"https://track-resource.bidease.com/resource/error?x=\\\" + rc.bidID, {\\n            contentType : \\\"application/json\\\",\\n            type : \\\"POST\\\",\\n            data: JSON.stringify({\\n              requestID: \\\"request_\\\" + rc.exchange + \\\"_\\\" + rc.campaignID + \\\"_\\\" + rc.bidID,\\n              msg,\\n              debugInfo,\\n              lineNo,\\n              columnNo,\\n              url,\\n              error\\n            })\\n          });\\n        }\\n      }\\n      return false;\\n    }\\n\\n    function touchEnd(e) {\\n      var role = e.target.getAttribute(\\\"role\\\");\\n      var coords = e.changedTouches[0];\\n      var width = Math.round($(window).width());\\n      var height = Math.round($(window).height());\\n      var x = Math.round(get(coords, \\\"clientX\\\", -1)) || 0;\\n      var y = Math.round(get(coords, \\\"clientY\\\", -1)) || 0;\\n      logEvent(\\\"click-\\\" + role);\\n      if ((role === \\\"close\\\") || (y < (height * rc.closeHeight))) {\\n        clickClose();\\n        return;\\n      }\\n      if (!rc.clickTracked) {\\n        rc.clickTrackers.forEach(function(tracker) { trackGetUrl(tracker); });\\n        rc.clickTracked = true;\\n      }\\n      trackClick(x, y, width, height);\\n    }    \\n    /* External events end ==========================================================*/\\n\\n    function trackSizeChange(width, height) {\\n      state.width = width;\\n      state.height = height;\\n      logEvent('sizeChange-' + width + '-' + height + '-' + isLandscape());\\n      tryToShowAdd();\\n    }\\n\\n    function trackstateChange(s) {\\n      state.state = s;\\n      logEvent('stateChange-' + s);\\n      tryToShowAdd();\\n    }\\n\\n    function trackViewableChange(viewable) {\\n      state.viewable = viewable;\\n      logEvent('viewableChange-' + viewable);\\n      tryToShowAdd();\\n    }\\n\\n    function trackReady() {\\n      logEvent('ready');\\n      if (rc.useCustomCloseButton && isMraid()) {\\n        mraid.useCustomClose(true);\\n      }\\n      tryToShowAdd();\\n    }\\n\\n    function trackError(message, action) {\\n      var msg = 'error-' + message + '-' + action;\\n      if (!rc.checkedErrors[msg]) {\\n        rc.checkedErrors[msg] = true;\\n        logEvent(msg);\\n      }\\n    }\\n\\n    function loadAd() {\\n      if (isMraid()) {\\n        var sz = mraid.getScreenSize();\\n        state.width = sz.width;\\n        state.height = sz.height;\\n        state.state = mraid.getState();\\n        state.viewable = mraid.isViewable();\\n        logEvent(\\\"load-ad-mraid\\\");\\n        mraid.addEventListener('ready', trackReady);\\n        mraid.addEventListener('sizeChange', trackSizeChange);\\n        mraid.addEventListener('error', trackError);\\n        mraid.addEventListener('stateChange', trackstateChange);\\n        mraid.addEventListener('viewableChange', trackViewableChange);\\n      } else {\\n        logEvent(\\\"load-ad-no-mraid\\\");\\n      }\\n      if (state.state !== 'loading' && rc.useCustomCloseButton && isMraid()) {\\n        mraid.useCustomClose(true);\\n      }\\n      tryToShowAdd();\\n    }\\n    logEvent(\\\"load\\\", { orientation: isLandscape() });\\n    setTimeout(loadAd, 70);\\n  </script>\\n</body>\\n</html>\",\
                    \"w\": 320,\
                    \"h\": 480,\
                    \"ext\": {\
                        \"crtype\": \"MRAID 2.0\",\
                        \"bidease\": {\
                          \"click_target\" : \"https://x5club.ru/#mobile-app\",\
                          \"click_tracking\" : \"https://track-us.bidease.com/click?x=${AUCTION_BID_ID}\"\
                        },\
                        \"skadn\": {\
                            \"version\": \"3.0\",\
                            \"network\": \"s39g8k73mm.skadnetwork\",\
                            \"campaign\": \"80\",\
                            \"source_identifier\": \"80\",\
                            \"sourceidentifier\": \"80\",\
                            \"itunesitem\": \"1622633822\",\
                            \"fidelities\": [\
                                {\
                                    \"fidelity\": 1,\
                                    \"nonce\": \"bda797be-106a-4f4e-8882-2e009a8c82ee\",\
                                    \"timestamp\": \"1701896751083\",\
                                    \"signature\": \"MEYCIQDVA7OpIAvPD+N33pkZhv/TnXwMay6mA8TkIepbmZXcUgIhANLcvwTipPF1KE8ZhR1OUdKxvG6M1+HLqVKgsBXxNKUl\"\
                                },\
                                {\
                                    \"fidelity\": 0,\
                                    \"nonce\": \"cfa84c33-fbfc-42c2-8db4-9db9443f0ec3\",\
                                    \"timestamp\": \"1701896751083\",\
                                    \"signature\": \"MEYCIQDWVL2BfngLILWsfz5qLRMw8BEIUNP+hGnzypFQuw/tOwIhANxwhieSMIUJmBOYBaSKU53P6uc1D9cz4qk8tZgOJZaH\"\
                                }\
                            ],\
                            \"sourceapp\": \"1521483641\",\
                            \"ext\": {\
                                \"skoverlay\": {\
                                    \"show\": 1,\
                                    \"delay\": 5,\
                                    \"pos\": 1\
                                }\
                            }\
                        }\
                    }\
                }\
            ]\
        }\
    ],\
    \"ext\": {}\
}";

static NSString* response_bidease_320x50_banner_mraid = @"{\
  \"id\": \"688f87af180ba7e8ecf7ab9f6b65b5862273acd3\",\
  \"cur\": \"USD\",\
  \"seatbid\": [\
    {\
      \"bid\": [\
        {\
          \"id\": \"UZIvqWJIsVcYM3yK\",\
          \"adid\": \"540683\",\
          \"cid\": \"ru.foodfox.client_android\",\
          \"crid\": \"61f0ff945c\",\
          \"impid\": \"1\",\
          \"price\": 0.01641297851224611,\
          \"adomain\": [\
            \"yandex.ru\"\
          ],\
          \"bundle\": \"ru.foodfox.client\",\
          \"cat\": [\
            \"IAB8\"\
          ],\
          \"nurl\": \"https://track-us.bidease.com/win?x=UZIvqWJIsVcYM3yK&exchange=&win_price=${AUCTION_PRICE}&min_to_win=${AUCTION_MIN_TO_WIN}&auction_min_bid_to_win=${AUCTION_MINIMUM_BID_TO_WIN}&openrtb_min_to_win=${OPENRTB_MIN_TO_WIN}&min_bid_to_win=${MIN_BID_TO_WIN}\",\
          \"lurl\": \"https://track-us.bidease.com/loss?x=UZIvqWJIsVcYM3yK&exchange=&loss_reason=${AUCTION_LOSS}&win_price=${AUCTION_PRICE}&min_to_win=${AUCTION_MIN_TO_WIN}&auction_min_bid_to_win=${AUCTION_MINIMUM_BID_TO_WIN}&openrtb_min_to_win=${OPENRTB_MIN_TO_WIN}&min_bid_to_win=${MIN_BID_TO_WIN}&mbr=${AUCTION_MBR}&csc=${CREATIVE_STATUS_CODE}\",\
          \"burl\": \"https://track-us.bidease.com/imp?x=UZIvqWJIsVcYM3yK&exchange=&win_price=${AUCTION_PRICE}\",\
          \"adm\": \"<!DOCTYPE html>\\n<html>\\n<head>\\n  <meta name='viewport' content='width=device-width,initialscale=1,maximum-scale=1'>\\n  <script src=\\\"mraid.js\\\"></script>\\n  <style>body{margin:0;padding:0;color:#fff;background-color:#000}.top-right{right:20px;top:20px}.top-left{left:20px;top:20px}.bottom-right{right:20px;bottom:20px}.bottom-left{left:20px;bottom:20px}.close-button{image-resolution:300dpi;z-index:999599;position:fixed;display:none;width:45px;height:45px;background:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAMAAAAp4XiDAAAABGdBTUEAALGPC/xhBQAAAAFzUkdCAK7OHOkAAABIUExURQAAAAAAAAAAAAAAAAAAAAAAAAAAAEdwTAAAAMzMzMvLywAAAAAAAAAAAJ6engAAAAAAAAAAAO/v7////wAAAAAAAMzMzP///z7INcwAAAAXdFJOU2YDOyQLSV8AZ8PCZEJWoRMyEef+TlfEzkEE5QAAAVZJREFUSMel1uF2gyAMBeALBIraVk8r8/3fdGo3FRKUsfysfFVICODGgoy2wXWdC1Yb4s+Rjh8eiOIx0Cnp7xDi3mcJiWBFJBPjkA1nBKI0TkOrlCiLi7AqJmrEZYzqSErE9p4P0SgKvRODwjC/hFwpcfRD9gw+Wy8M9O1zy+mH9Lt4Tw03vpnem+lXsmekmSZu/PJru63aQujw9Isbn/wPzWTAmUkFhplE+yM1TCDcQDj5Di/MjmCQN5LwBhpZ48UV1LDIGVnMICBnZDEDqb7W0S9ZIFOQq5EFukzJ+uUdL0nMxP31LU6a/vlcgrDIxxUT9o/lqYzzwo1mBZNmnxmTliWvscR4SopfquTYhGSLsbriZog3slCJzFDcLsT9ERubNKX2usP0Seu77mN31mCvuuXWYCvaeM1hUXgkjep/B1/N8VpziNdcFaouJDXXnqrLVdEV7ht7xyTRi3UAKAAAAABJRU5ErkJggg==)no-repeat;background-size:25px;background-position:center;border:0;box-shadow:none}#bg-exit{position:absolute;cursor:pointer;width:100%;height:85%;z-index:1;bottom:0}.bidease-slider,.branding{position:absolute;padding:0}.branding{bottom:1px;left:1px;z-index:999599;max-width:30px;height:auto;-moz-user-select:none;-webkit-user-select:none;user-select:none;pointer-events:none}.bidease-slider{height:100%;width:100%;display:flex;align-items:center;justify-content:center;scroll-behavior:smooth;list-style:none;margin:0;-ms-overflow-style:none;scrollbar-width:none;touch-action:none;overflow:hidden}.bidease-slider img{max-width:100%;max-height:100%;display:none}#bg-exit,.bidease-slider img.active{display:block}</style>\\n</head>\\n<body data-role=\\\"body\\\">\\n  <button type=\\\"button\\\" class=\\\"close-button js-close-button top-right\\\" data-role=\\\"close\\\" onclick=\\\"clickClose(event)\\\"></button>\\n\\n\\n  <div class=\\\"bidease-slider js-slider\\\" data-role=\\\"image-container\\\">\\n \\n      \\n      <img src=\\\"https://creative-bunny.bidease.com/media/res/2024/08/37338607-4a77.gif?campaign_id=93538&creative_id=540683&x=UZIvqWJIsVcYM3yK\\\" class=\\\"active main-banner\\\" data-role=\\\"image\\\" onerror=\\\"imageOnError(this)\\\" />\\n      \\n    \\n  </div>\\n\\n  <img data-role=\\\"branding\\\" class=\\\"branding\\\" src=\\\"https://creative.bidease.com/media/2023/playable/07/playable/bidease/v4.png?campaign_id=93538&creative_id=540683&x=UZIvqWJIsVcYM3yK\\\" onerror=\\\"imageOnError(this)\\\">\\n<script>!function(){\\\"use strict\\\";var e={width:0,height:0,state:\\\"loading\\\",appRendered:!1,viewable:!1,currentRC:0,sliderInterval:5e3},n=[\\n    \\n      {\\n        exchange: \\\"applovin\\\",\\n        s2s: !!1,\\n        target: \\\"https://apps.apple.com/ru/app/id1078986931\\\",\\n        campaignID: \\\"93538\\\",\\n        bidID: \\\"UZIvqWJIsVcYM3yK\\\",\\n        country: \\\"RUS\\\",\\n        ifa: \\\"6a594e41-b2f7-4266-87b5-bc11fe130bdc\\\",\\n        rewarded: !!0,\\n        interstitial: !!0,\\n        dateLoad: new Date().getTime(),\\n        closeTimeout: 0,\\n        closeHeight: 0,\\n        adShowed: false,\\n        clickTracked: false,\\n        impTracked: false,\\n        impcrTracked: false,\\n      },\\n    \\n  ];function t(){return n[e.currentRC]}var o={isChartUnVung:function(){return-1!==[\\\"chartboost\\\",\\\"unity\\\",\\\"vungle\\\"].indexOf(t().exchange)},isIronUnApp:function(){return-1!==[\\\"ironsource\\\",\\\"unity\\\",\\\"applovin\\\"].indexOf(t().exchange)}},i={requested:[],url:\\\"https://track-us.bidease.com\\\",fetch:function(e,n){fetch(e,{method:\\\"GET\\\"}).then((function(t){return n&&n.onSuccess&&n.onSuccess(e,{status:(null==t?void 0:t.status)||\\\"UNKNOWN\\\"}),t})).catch((function(t){-1===i.requested.indexOf(e)&&0!==e.indexOf(\\\"\\\".concat(i.url,\\\"/resource/error\\\"))&&0!==e.indexOf(\\\"\\\".concat(i.url,\\\"/devent\\\"))&&Math.random()>.8&&(i.err({msg:\\\"fetch error\\\",url:e,err:t}),i.requested.push(e)),n&&n.onError&&n.onError(e,t?{message:null==t?void 0:t.message}:{msg:\\\"err is empty\\\"})}))},time:function(){return Math.round((new Date).getTime()-t().dateLoad)},base64:function(e){return btoa(JSON.stringify(e))},click:function(e){var n,o,r,a,c=\\\"\\\".concat(i.url,\\\"/click?x=\\\").concat(t().bidID,\\\"&cx=\\\").concat(null!==(n=e.x)&&void 0!==n?n:-1,\\\"&cy=\\\").concat(null!==(o=e.y)&&void 0!==o?o:-1,\\\"&cw=\\\").concat(null!==(r=e.width)&&void 0!==r?r:-1,\\\"&ch=\\\").concat(null!==(a=e.height)&&void 0!==a?a:-1,\\\"&time=\\\").concat(i.time());i.fetch(c),t().s2s?p(t().target):p(c)},imprc:function(){var e=document.createElement(\\\"img\\\");e.src=\\\"\\\".concat(i.url,\\\"/impcr?x=\\\").concat(t().bidID,\\\"&time=\\\").concat(i.time()),e.style.opacity=\\\"0\\\",e.style.position=\\\"absolute\\\",e.style.zIndex=\\\"-999\\\",e.onerror=function(n){var t,o;n&&!1===(null===(t=null==n?void 0:n.target)||void 0===t?void 0:t.complete)&&i.debugEvent(\\\"impcr-call\\\",{src:e.src,errorType:n?null==n?void 0:n.type:\\\"\\\",completeState:n?null===(o=null==n?void 0:n.target)||void 0===o?void 0:o.complete:\\\"\\\"})},document.body.appendChild(e);var n=\\\"\\\".concat(i.url,\\\"/cevent?x=\\\").concat(t().bidID,\\\"&time=\\\").concat(i.time()),o=new XMLHttpRequest;o.open(\\\"GET\\\",n,!0),o.onload=function(){i.debugEvent(\\\"impcr-call\\\",{msg:\\\"onload\\\",url:n,statusText:o.statusText,status:o.status})},o.onerror=function(){i.debugEvent(\\\"impcr-call\\\",{msg:\\\"onerror\\\",url:n,error:\\\"have no idea\\\",status:o.status,statusText:o.statusText,responseText:o.responseText})},o.send()},event:function(e,n){i.fetch(\\\"\\\".concat(i.url,\\\"/event?x=\\\").concat(t().bidID,\\\"&t=\\\").concat(e,\\\"&time=\\\").concat(i.time(),\\\"&body=\\\").concat(i.base64(n)))},debugEvent:function(e,n){i.fetch(\\\"\\\".concat(i.url,\\\"/devent?x=\\\").concat(t().bidID,\\\"&t=\\\").concat(e,\\\"&time=\\\").concat(i.time(),\\\"&body=\\\").concat(i.base64(n)))},err:function(e){f()?e.__mraid=Object.keys(mraid):e.__mraid=\\\"mraid not found\\\",i.fetch(\\\"\\\".concat(i.url,\\\"/resource/error?x=\\\").concat(t().bidID,\\\"&time=\\\").concat(i.time(),\\\"&body=\\\").concat(i.base64(e)))}},r=function(n,t){e.width=n,e.height=t,i.debugEvent(\\\"sizeChange\\\",{width:n,height:t,isLandscape:h()}),b()},a=function(n){e.state=n,i.debugEvent(\\\"stateChange\\\",{state:n}),b()},c=function(n){e.viewable=n,i.debugEvent(\\\"viewableChange\\\",{viewable:n}),b()},d=function(){i.debugEvent(\\\"ready\\\",{}),t().useCustomCloseButton&&w(\\\"useCustomClose\\\")&&mraid.useCustomClose(!0),b()},u=function(e,n){i.err({msg:\\\"Mraid error event\\\",message:e,action:n})},s={images:function(){return document.querySelectorAll(\\\".js-slider img\\\")},run:function(){s.images().length>1&&setInterval(s.next,e.sliderInterval)},next:function(){var n=s.images()[e.currentRC];n?(f()?\\\"applovin\\\"===t().exchange?e.width>0&&e.height>0&&e.viewable:e.width>0&&e.height>0&&e.viewable&&\\\"loading\\\"!==e.state:window.innerWidth>0&&window.innerHeight>0)?(n.classList.remove(\\\"active\\\"),e.currentRC=(e.currentRC+1)%s.images().length,s.images()[e.currentRC].classList.add(\\\"active\\\"),v()):i.err({msg:\\\"Cannot show\\\",state:e}):i.err({msg:\\\"Img not found\\\",error:s.images(),current:e.currentRC})}},l={remove:function(){var e=document.getElementById(\\\"bg-exit\\\");e&&e.parentNode&&e.parentNode.removeChild(e)},run:function(){if(l.remove(),o.isChartUnVung()){var e=document.createElement(\\\"div\\\");e.id=\\\"bg-exit\\\",e.dataset.role=\\\"bgexit\\\",e.onclick=function(e){i.click({x:e.offsetX,y:e.offsetY,height:Math.round(window.innerHeight),width:Math.round(window.innerWidth)})},document.body.appendChild(e)}}},m={isShown:function(){return\\\"block\\\"===document.querySelector(\\\".js-close-button\\\").style.display},show:function(){setTimeout((function(){i.event(\\\"show-close\\\",\\\"\\\"),document.querySelector(\\\".js-close-button\\\").style.display=\\\"block\\\"}),t().closeTimeout)},hide:function(){document.querySelector(\\\".js-close-button\\\").style.display=\\\"none\\\"},run:function(){t().useCustomCloseButton&&f()&&(m.isShown()&&m.hide(),m.show())}};function v(){var e=t();e.clickTrackers=\\\"adx\\\"===e.exchange?[\\\"%%CLICK_URL_UNESC%%\\\"]:[],e.noCustomClose=o.isIronUnApp(),e.useCustomCloseButton=!e.rewarded&&e.interstitial&&!e.noCustomClose,l.run(),m.run(),function(){if(!t().adShowed){var e=h();i.event(\\\"show-ad\\\",{orientation:e?\\\"landscape\\\":\\\"portrait\\\"}),t().adShowed=!0}t().impcrTracked||(i.imprc(),t().impcrTracked=!0)}()}function g(e,n,t){return e?Number(e[n]):t}function h(){return screen&&screen.orientation&&screen.orientation.angle?90===screen.orientation.angle:90===Math.abs(window.orientation)}function f(){return\\\"undefined\\\"!=typeof mraid}function w(e){var n=e in mraid&&\\\"function\\\"==typeof mraid[e];return n||i.err({msg:\\\"mraid event not found\\\",method:e}),n}function p(e){i.event(\\\"open-link\\\",e),f()?mraid.open(e):window.open(e)}function b(){e.appRendered||(s.run(),v(),e.appRendered=!0)}window.onerror=function(e,n,t,o,r){(e||r)&&(i.debugEvent(\\\"global-error\\\",{msg:e,mraid:f()?1:0}),\\\"Uncaught ReferenceError: al_onAdViewRendered is not defined\\\"!==e&&i.err({msg:e,error:r}))},i.debugEvent(\\\"load\\\",{orientation:h()?\\\"landscape\\\":\\\"portrait\\\"}),window.addEventListener(\\\"touchend\\\",(function(e){var n=e.changedTouches[0],o=Math.round(window.innerWidth),r=Math.round(window.innerHeight),a=Math.round(g(n,\\\"clientX\\\",-1)),c=Math.round(g(n,\\\"clientY\\\",-1)),d=e.target.dataset.role;if(d||(d=e.target.nodeName),i.event(\\\"click\\\",d),\\\"close\\\"===d||c<r*t().closeHeight)return i.event(\\\"click-close\\\",\\\"\\\"),void(f()&&w(\\\"close\\\")&&mraid.close());!t().clickTracked&&t().clickTrackers&&(t().clickTrackers.forEach((function(e){i.fetch(e)})),t().clickTracked=!0),i.click({x:a,y:c,width:o,height:r})}),!1),\\\"undefined\\\"!=typeof window?window.imageOnError=function(e){var n,t={msg:\\\"Cannot load image\\\",src:null!==(n=null==e?void 0:e.src)&&void 0!==n?n:\\\"src empty\\\",list:[]},o=s.images();o.length&&o.forEach((function(e){t.list.push(e.src)})),i.err(t)}:i.err({msg:\\\"window not found???\\\"}),setTimeout((function(){if(f()){if(w(\\\"getScreenSize\\\")){var n=mraid.getScreenSize();e.width=n.width,e.height=n.height}else e.width=Math.round(window.innerWidth),e.height=Math.round(window.innerHeight);w(\\\"getState\\\")&&(e.state=mraid.getState()),w(\\\"isViewable\\\")&&(e.viewable=mraid.isViewable()),i.debugEvent(\\\"load-ad-mraid\\\",e),w(\\\"addEventListener\\\")&&(mraid.addEventListener(\\\"ready\\\",d),mraid.addEventListener(\\\"sizeChange\\\",r),mraid.addEventListener(\\\"error\\\",u),mraid.addEventListener(\\\"stateChange\\\",a),mraid.addEventListener(\\\"viewableChange\\\",c)),w(\\\"useCustomClose\\\")&&mraid.useCustomClose(\\\"loading\\\"!==e.state&&t().useCustomCloseButton)}else i.debugEvent(\\\"load-ad-no-mraid\\\",e);b()}),70),window.onload=function(){if(window.performance&&\\\"function\\\"==typeof window.performance.getEntriesByType&&Math.random()>.9){var e=[];window.performance.getEntriesByType(\\\"resource\\\").forEach((function(n){var t,o,i;e.push({duration:n.duration,name:n.name,connection:(null===navigator||void 0===navigator?void 0:navigator.connection)?{effectiveType:null===(t=null===navigator||void 0===navigator?void 0:navigator.connection)||void 0===t?void 0:t.effectiveType,rtt:null===(o=null===navigator||void 0===navigator?void 0:navigator.connection)||void 0===o?void 0:o.rtt,downlink:null===(i=null===navigator||void 0===navigator?void 0:navigator.connection)||void 0===i?void 0:i.downlink}:{}})})),e.length&&i.debugEvent(\\\"resource-performance\\\",e)}}}();\\n</script></body>\\n</html>\",\
          \"w\": 320,\
          \"h\": 50,\
          \"exp\": 43200,\
          \"ext\": {\
            \"crtype\": \"HTML\"\
          }\
        }\
      ]\
    }\
  ],\
  \"ext\": {}\
}\
";

NSString* __nonnull adm_mraid2_vungle_sample1(void)
{
    return get_adm_from_OpenRTB_response(response_mraid2_vungle_sample1);
}

NSNumber* storeId_mraid2_vungle_sample1(void)
{
    return get_storeId_from_OpenRTB_response(response_mraid2_vungle_sample1);
}

NSString* __nonnull adm_bidease_320x50_banner_mraid(void)
{
    return get_adm_from_OpenRTB_response(response_bidease_320x50_banner_mraid);
}
