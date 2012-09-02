attributes = (attr) ->
    ("#{key}=#{value}" for key,value of attr).join(" ")

audio = (url, attr = {autoplay: true}) ->
    "<audio #{attributes(attr)}>
        <source src='#{url}'/> 
    </audio>"

video = (url, attr = {autoplay: true}) ->
    "<video #{attributes(attr)}>
        <source src='#{url}'/> 
    </video>"

iframe = (url, attr = {}) ->
    "<iframe src='#{url}'/>"


page = (url) ->
    text = ""
    $.get('pages/'+url+'.html', (response) -> text = response)
    text
    
sendHTML = (html) ->
    dataRef.set({type: 'html', value: html})

sendJS = (js) ->
    dataRef.set({type: 'js', value: js})


index = -1;
dataRef = new Firebase('http://gamma.firebase.com/broadway/');
fragments = []

fragments = fragments.concat("Presentations are boring. Broadway is not!".split(" "))
fragments.push(audio("http://noproblo.dayjo.org/ZeldaSounds/LOZ/LOZ_Shield.wav") + "Beep.");

reset = () ->
    index = -1;
    sendHTML(null);

setFragment = (idx) ->
    index = idx;
    if index < fragments.length
        frag = fragments[index]
        sendHTML(frag)
    else
        sendHTML("Curtains drop.")

$(document).ready(() ->
    $(document).keyup((event) ->
        console.log(event);
        nextFragment() if event.which == 32
    );
    reset();
);