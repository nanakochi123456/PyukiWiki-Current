/* "PyukiWiki" 0.2.1-customoer-preview $$
 * $Id$
 */

var tu="http://twitter.com/",qs='"',hs=' href="',as="<a",os=' onclick="return ou(';var twitstat={lol:false,jsonp:function(){if(d.all&&d.getElementById("twitstat_badge_call")){d.getElementById("twitstat_badge_call").src=twitstat.updateurl}else{if(d.getElementById("twitstat_badge_call")){var b=d.getElementById("twitstat_badge_call");b.parentNode.removeChild(b)}else{var c=d.createElement("script");if(twitstat.updateurl==""){c.src=twitstat.url}else{c.src=twitstat.updateurl}c.id="twitstat_badge_call";d.body.appendChild(c)}}if(!twitstat.lol&&/reddit/.test(d.referrer)){twitstat.lol=true}},init:function(b){twitstat.props=b;twitstat.url=twitstat.searchurl+"&rpp="+b.max+"&callback=twitstat.construct&q="+encodeURIComponent(b.keywords);if(b.near){twitstat.url+="&near="+b.near}if(b.within&&b.units){twitstat.url+="&within="+b.within+"&units="+b.units}if(typeof w.attachEvent!="undefined"){w.attachEvent("onload",twitstat.jsonp)}else{if(typeof d.addEventListener!=="undefined"){d.addEventListener("DOMContentLoaded",twitstat.jsonp,false)}else{d.write(unescape('%3Cscript src="'+twitstat.url+'" type="text/javascript"%3E%3C/script%3E'))}}},loop:function(f,l){var e=tu,k=qs,g=hs;a=as;o=os;popup=twitter_popup(0);j=twitter_popup(1);var b=[];for(var c=0;c<f.length;c++){var m='<li style="margin: 5px; font: normal 12px/14px helvetica, sans-serif; min-height: 54px; height: auto !important; height: 54px;">';m+='<img src="'+f[c].profile_image_url+'" style="float: left; margin: 0 5px 10px 0; width: 48px; height: 48px;">';m+="<div>";m+=a+popup+g+e+f[c].from_user+'"';m+=o+"'"+e+f[c].from_user+"','"+j+"'";m+=');"  style="color: '+twitstat.props.link_color+'">'+f[c].from_user+"</a>:";m+="<span>"+twitstat.convertUrls(f[c].text)+"</span></div></li>";b[c]=m}return(l&&f.length>0?'<div style="display: none;">'+b.join("")+"</div>":b.join(""))},construct:function(f){var e=d.getElementById(twitstat.props.badge_container),c=twitstat.loop(f.results,false),i=d.createDocumentFragment();e.style.width=twitstat.props.width+"px";twitstat.holder=d.createElement("div");refresh=f.refresh_url;refresh=refresh.replace("?since_id","&since_id");twitstat.updateurl=twitstat.searchurl+refresh+"&callback=twitstat.update";var b='<ul style="list-style-type: none; overflow: hidden; height: '+(twitstat.props.max*60)+"px; padding: 0; margin: 0; color:"+twitstat.props.content_font_color+"; border: 1px solid "+twitstat.props.border_color+"; background-color: "+twitstat.props.content_background_color+';">',h='<div style="font: normal 14px/16px helvetica, sans-serif; -moz-border-radius-topleft: 2px; -moz-border-radius-topright: 2px; -webkit-border-top-left-radius: 2px; -webkit-border-top-right-radius: 2px; color: '+twitstat.props.header_font_color+"; background-color: "+twitstat.props.header_background+'; margin: 0; padding: 4px 4px 2px;">'+twitstat.props.title+"</div>",g='<div style="font: normal 11px/12px helvetica, sans-serif; color: '+twitstat.props.header_font_color+"; -moz-border-radius-bottomright: 2px; -moz-border-radius-bottomleft: 2px; -webkit-border-bottom-left-radius: 2px; -webkit-border-bottom-right-radius: 2px;background-color: "+twitstat.props.header_background+'; margin: 0; padding: 4px; text-align: right;"></div>';c=c.replace(/<img (.+?)>/g,"<img $1 />");twitstat.holder.innerHTML="<div>"+h+b+c+"</ul>"+g+"</div>";i.appendChild(twitstat.holder.firstChild);e.appendChild(i);twitstat.list=e.getElementsByTagName("UL")[0];return false},convertUrls:function(i){var c=tu,f=qs,e=hs,b=as,g=os;popup=twitter_popup(0);j=twitter_popup(1);tc=twitstat.props.link_color;tc=tc.replace(twitstat.linkcolorfromRE,"_C_$1");i=i.replace(twitstat.urlRE,function(h){return twitstat.replaceUrl(h)});i=i.replace(twitstat.twitterHashRE,b+popup+' title="#$1" style="color: '+tc+f+e+c+'search/%23$1"'+g+"'"+c+"search/%23$1','"+j+"');\">#$1</a>");i=i.replace(twitstat.twitterUsernameRE,b+popup+' title="@$1" style="color: '+tc+f+e+c+'$1"'+g+"'"+c+"$1','"+j+"');\">@$1</a>");i=i.replace(twitstat.linkcolortoRE,"#$1");return i},twitterUsernameRE:/@(\w+)/gm,twitterHashRE:/\#([A-Za-z0-9\-\_]+)/gm,urlRE:/((((ht|f){1}(tp:[/][/]){1})|((www.){1}))[-a-zA-Z0-9@:;%_\+.~#?\&//=]+)/gm,linkcolorfromRE:/\#([A-Za-z0-9]+)/gm,linkcolortoRE:/_C_([A-Za-z0-9]+)/gm,replaceUrl:function(c){var f=qs,e=hs,b=as,g=os;p=twitter_popup(0);j=twitter_popup(1);tc=twitstat.props.link_color;tc=tc.replace(twitstat.linkcolorfromRE,"_C_$1");return b+p+e+c+'"'+g+"'"+c+"','"+j+'\');" title="'+c+'" style="color: '+tc+'">'+((c.length>34)?(c.substring(0,20)+"&hellip;"):c)+"</a>"},badge:{init:function(b){twitstat.init(b)}},props:{},url:"",searchurl:"?cmd=twitter",updateurl:"",fxopac:0,list:{},holder:{}};function twitter_popup(b){var c="";if(twitstat.props.popup==1){if(b==1){c="_blank"}else{if(twitstat.props.xhtml==0){c=' target="_blank"'}}}return c};
