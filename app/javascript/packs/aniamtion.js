$(document).ready(function(){

    // For Main Logo
    var LI_Logo = document.getElementById("main-icon");
    var TLScale = new TimelineMax({paused: true});
    TLScale
        .to(LI_Logo, 0.3, {transformOrigin: "50% 50%", scale: 1.2});

    LI_Logo.onmouseover = function() {
        TLScale.play();
    };

    LI_Logo.onmouseout = function() {
        TLScale.reverse();
    }

});

$(document).ready(function(){

    // For Heart
    var LI_Heart = document.getElementById("LI-Heart");
    var HeartL = document.getElementById("HeartRight");
    var HeartR = document.getElementById("HeartLeft");
    var TLHeart = new TimelineMax({paused: true});
    TLHeart
        .to(HeartL, 0.5, {transformOrigin: "50% 50%", y: "+= 50"})
        .to(HeartR, 0.5, {transformOrigin: "50% 50%", y: "-= 50"}, "-=0.5");

    LI_Heart.onmouseover = function() {
        TLHeart.play();
    };

    LI_Heart.onmouseout = function() {
        TLHeart.reverse();
    }

    LI_Heart.onclick = function() {
        openTab(event, 'Matches');
    }

    // For Message
    var LI_Message = document.getElementById("LI-Message");
    var MessageR = document.getElementById("MessageRight");
    var MessageL = document.getElementById("MessageLeft");
    var TLMessage = new TimelineMax({paused: true});
    TLMessage
        .to(MessageL, 0.5, {transformOrigin: "50% 50%", x: "-= 50"})
        .to(MessageR, 0.5, {transformOrigin: "50% 50%", x: "+= 50"}, "-=0.5");

    LI_Message.onmouseover = function() {
        TLMessage.play();
    };

    LI_Message.onmouseout = function() {
        TLMessage.reverse();
    };

    LI_Message.onclick = function() {
        openTab(event, 'Messages');
    }

    // For Events
    var LI_Event = document.getElementById("LI-Event");
    var eventCubeArr = document.getElementsByClassName("event-1");
    var TLEvent = new TimelineMax({paused: true});

    TweenMax.set(eventCubeArr, {transformOrigin: "50% 50%", scale: 0});

    TLEvent
        .to(eventCubeArr, 0.01, {autoAlpha: 1})
        .staggerTo(eventCubeArr, 0.3, {transformOrigin: "50% 50%", scale: 1}, 0.15);

    LI_Event.onmouseover = function() {
        TLEvent.play();
    };

    LI_Event.onmouseout = function() {
        TLEvent.reverse();
    };

    LI_Event.onclick = function() {
        openTab(event, 'Events');
    }
});