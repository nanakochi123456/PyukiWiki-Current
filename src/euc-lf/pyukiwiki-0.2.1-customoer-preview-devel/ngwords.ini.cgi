######################################################################
# ngwords.ini.cgi - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 09:53:30
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################
use strict;

# fix NG words.

# http://monoroch.net/kinshi/
# http://dic.nicovideo.jp/a/%E3%83%8B%E3%82%B3%E3%83%8B%E3%82%B3%E7%94%9F%E6%94%BE%E9%80%81%3A%E9%81%8B%E5%96%B6ng%E3%83%AF%E3%83%BC%E3%83%89%E4%B8%80%E8%A6%A7
# http://www.vector.co.jp/soft/data/net/se475480.html


# if not use this database, written to info/setup_ngwords.ini.cgi
if(0) {

$::disablewords{ja}="";
$::disablewords="";
$::disablewords_frozenwrite{ja}="";
$::disablewords_frozenwrite="";
$::disablewords_username{ja}="";
$::disablewords_username="";

}

######################################################################
$::disablewords=<<EOM;
007ch.net 00freehost.com 00pro.com 0120 0120-70-2000.jp 05bar.com 072-net.com 0721partner.com 089.jp 0catch.com 0golf.com 0hi.cc 0hi.co.uk 0rz.net 1-800-tell.net 100freemb.com 111ch.net 114090.jp 114788.net 12012.com 13net.biz 14.pro.tok2.com 150m.com 18erosta.net 196.jp 199mb.com 1afm.com 1e1e.com 1g8sr4 1hwy.com 1night-love.com 1st-sf.com 1stclass.jp 1sweethost.com 2-11.net 202.181.108.91 204.jp 20me.com 20six.de 210.153.26.126 216.152.253.16 22ch.biz 246911.net 275mb.com 2ch2.net 3-11.net 39ba5.lp 43786jpg.com 45z.com 4649-ne.com 501megs.com 509.jp 51-navi.net 55114.com 555mb.com 55channel.com 59.158.173.138 64bitstream.com 6ck.net 6te.net 703.jp 741.com 789ad.com 789mb.com 844.jp 87koala.net 899.jp 8e8ae.net 8sb.net 8v6.net 922.jp 946art.com 98.to 99inch.com 99movie.tv 9ak.net 9cy.com 9om.net 9vb.net [/url] [url= a-girl-like-me.com a-linker.net a-million-miles-away.com a-ngelkiss.com a2me.net aaawebpage.com abaoa.net abcp.jp abz.jp/~mkjnf760 acport.com acua acua.mine.nu acua.tv acyclovir adam.ne.jp adchannel19.com adipex adult adult-banking.com adultshop-egoods.com afe4.net afterlove ageru.info ai-100.com ai-navi.jp ai.puririn.jp aiai88.com aibu.jp aic-cashing.com aika.page.ne.jp ail.jp aiux.net aizou.net ajdis.power.ne.jp alacran-722.com alink.uic.to all-about-lifeyou.com allfree.com allway.info alpaci.com alprazolam am69.com amazing-search.info ambien ame-tk.net an-ii.net ana555.com anal angel-pink.net angel-world.net angelcities.com angry.jp aniani.jp anim-uoa.com animaid.jp animore.cx another-cycle.com anywebsearch aport43.blog100.fc2.com apple-blog.net appleinfo1.hp. arbuck.net art-chair.com artemisweb.jp artshost.com asian.elitecities.com asite2006.com asocchi.fc2web.com asokonibu.com asukape.bufsiz.jp asutoraia.com at.lac440.com atataka.com avdogaspace.com avgals.net awakening.cc awg5.net azcafe.net azw.oc.to b-key.net babyurl.com bad.h16.ru badland.com bag-shopping.com baidu-mms.com banana2sin.net banner8.com baros.jp bazuu11.com bb-s.jp bbblog bbrose bbs-avi.com bbs-kanpou bbs.avi.jp bbs.yrrn.net be-card beautycamp.net bebto.com benniek.net bestbag.net bestmovie.cc besutohogo.com betrun.net biglnk.com biglobe.ne.jp/~dolch bijo bikubikubikini bisket.jp bitch bitstreamrs.net bjoyq.net blackberry3.net blacklist.jp blog-station.com blog.3or2.net blog.actingland.com blog.artshost.com blog.club.co.ba blog.home.ph blog.hr blog.ikkinomi.com blog.rantweb.com blog.sleepytimedreams.com blog7.tv blogspot.com blue55.net bokki.tv bomber.321webmaster.com bomm.cn boob boobooking.com booiboo.com book-web.biz booolog.com bootan-r.net branch-road.net brand-google.com brand-sale.com brandcars.us brandscopy.com bravehost.com brb-diet.com brb-pp.com briefurl.com buba.classicbroncos.com business-softwareworks businesswork-assist butt butterfly1117.com buy-rx-usa.com buy-xanax.miwww.net buycheaponlinex.com buyraku.com bvlgari c-cock.com c-melon.net cafe150.com camellia-princess.cx can.pypy.jp canadian.site.ne.jp car-sex caribbean-dx.com caribbeanbb.com caribbeanbom.com carisoprodol cartier casino cawai-douga2.com celeb-time.com celebrex celecele.net cerrie.net chancetourai.bufsiz.jp chaneljp.com channel-no-x.tv chararn.com chartwin.net cherrygirl.net chicappa.jp china-limo.com china-teas.net chinalimousines.com chinko cho-ii.com class-s.cx classicbroncos.com clayfis22fjs.net climax1.net clmag.com clubrose.h.fc2.com clubvanty.gooside.com cnf.co.jp cnlimos.com co.uk/review coano.net colinsfreehost.com com/yi.php come-come.net comeback-anytime.com compress.angelcities.com computed.net comu2.com coocle.info cool-angel.com coolmain.server.ne.jp copcop copcop.net copulation69 copulation69.net coron.cc coy.jp cpxsw.com cranky.jp crap cream-lemon.net credit-card cslim.com cusco cute.eroeronist.com cutey.cc cutie-face.com cutie-honey-jp.com cutie-navi.com cutie7.net cuty.self-nude.com d-enjyo.com d-hos.net d-k. d-kouza.net d-kyuujin.com d-recycle.net d-wanted.net daewoo.co.kr daramo.net darani9pi.net dark-queen.jp darumainfo ddo.jp deai-best.net deai-ciao.net deai-jiten.com deai-maxmax.com deai-star-live deai.com deai.net deaidahoi.com deaifree deaihime.com deaiworld.org deca.jp deci.jp deep-ice.com deep-play deli-db.com denjiha110.com diamondwin.fc2web.com diazepam dick diet.ocnk.net dietnavi.com digitalzones.com diorer.net dip.jp direct.ne.jp disc.server.com discovery-net.jp discovery.kunumunu.com doiop.com doki-net dokidoki-gazou.com dolce.mo-e.net domanq.site.ne.jp donby.net dondake.com doppu.net doraibuhogo.com douga-max.com douga-walker.com doutei-g.net doutei-p.net douteikaimasu.com dp-117 dream-get.net dropdorp.com drug dth.jp dtjapan.net dvd-banana.com dvd-itigo.com dvd-synergy.com dvxvb.net dx-tra.com dykoon dykoon.net dynu.net dzz2.net e-bagshop.net e-berry.com e-brainers e-city.tv e-daikichi e-dash.tv e-excite.jp e-fc.net e-ga-zo.com e-gal.tv e-gets.ath.cx e-liveshot.com e-midnight.com e-pretty.cc e-quicksurvice e-sgk.com e-soho.net e-tira.biz e-woo.jp edcsocp.com edit.dnsalias.com ee357.com egazo.net egke.com ekanpou elfurl.com eluxuryjapan employment enjoy-s.net enkou55.com enlargement ephedra epuron3.main.jp ero-channel.net ero-cute.com ero-grande.com ero-maniac.com ero-ran.com ero2.v37.jp eroecho.net eroero.cc eroero999.com eroerostyle.com eroerox.com erogoo.jp eromes-japan.com erotic erotic-place.org erovip.net escorts esuemu.com ever-blazin.net excite-xx.com exeair.net ez-movies.net/maincore f-step.net f-t-s.com f00.jp f5k.com fa-da-love-of-da-dancehall.com fa59eaf fa59eaf.com facethelove.com/street fam.cx fateback.com fbhosting.com fe7a4.net fe84a.net feticolle.com fiberia.us fibiger.org filmstadeumgallalycollection.com find-grand.info fioricet flashbody.com flier.jp flv-p.net fly-in-ads-japan.com fm7.biz fnfn.jp fore.site.ne.jp foreclosure formzu.jp foxconn.com.tw free-fuckers.com free55.net freehostpro.com freehyperspace.com freeing.name freepe.com freeservers.com freesexyhouse.com freeweb7.com freewebpage.org freewebs.com freewebsites.com freexy.net friend-girls.com friends-blog.tv friends.rank.ne.jp from-yen from-yen.net fry-dragon.com fu-map.net fuck fukastyle.com funpic.de furinsenka.com furni.org fuyuiro.net g-blend.net g-cute.com g-m-o-s.com g3z.com g51.jp gachan55.net gaii.net gajiro.com gal-motion.com gal.com gal2max.com galmie.com gals-archive.com gambling ganbaru.or.tv ganmo.com gazou-bbs.com geki-ura.com genki.tabrays.com genkinka geocities.jp/lllloooo0000 geocities.jp/msjpan geocities.jp/pupubabyblue get7777.gooside.com getbilliom.com gets7.h.fc2.com getthelover.com ggmm52.com gi-san-ba-san.com giga-mix.net gijack.net girl.660011.com girl.com girlfriend girls--club.com girls--collection.com girls-lips.com girls-loves.net girls-production girls-xxxx.com girlschool.client.jp girlsupport.com glay-exile.com glory-vision.net glove.00pro.com god-x.jp golly1.philly1.com good-39.com gooddeli.com goodstegefactory.com gooo55.net goshoukai.sakura.ne.jp goshrink.com gowwwgo.com gratis-webspace.de gravure-s.net green55 greenparadice.com guoxuecn.com gyakuderi.net gyakuen.net h-bank.jp h-diary.com h-tomo.net h-zuki.com h.fc2.com h.galnavi.net h15.ru hachimitsu-lemon.com haikaradou.com hamacco.com hame-hame-haa.com hame-hame-hame.net hame24.net hamedorix.com hamex.tv hamq.jp hanae1616 hanamitu.polty.cc hananoizumi.net hansokuwaza.net hapimamas.ifdef.jp happyhost.org happymail.co.jp happymeeting.mobi hdoga.net head-in-the-zone.net heart-cocktail.net heil hello-brand hentai.play--land.com heteml.jp heven. hevry.net hh-page.com high-time.jp hime-paradise.com hit.bg hitorih.com hitozuma hk365365.com home-java.com homepage2.nifty.com/makonee homomo.net hooly.indiegroup.com host.sk hot-cherry.net hot-gal.net hotel.com hotusa.org house.com hrbkj.com hydrocodone hzax06.net i-bbs.sijex.net i-bbs7.net/300 i-goo.com i-kusuri.jp i-pode.com i.do.ai i8.com icelicks.com id-attack.com id= idiot idolch.net ie.to ifastnet.com ifrance.com ii-ne-kiss iiai.net ikasete.net iketeru.jp iku0228.blog6.fc2.com iku6969.com illustrations.me.uk iloveburando imess.net in-ran.net indies-gogo.tv inf.popon.cn infoest.dnip.net inomate.net insurance into-an.us irokoi-m.com issyou-issyo itbdns.com itm-asp.com izumi-no-ero.com izumi.server.ne.jp jan119bgt2 jap-an.com japan-market.net japaoxox jazzye.net jikohasan.biz jiyuu-r.com jizz jksdhfue.com jm.hyr.jp job.pochat.tv jouho.jp joule.cc jp.bogyotsuru.com jp.rejishufuku.com jp160.com jp911.com jpadv.com jpan.jp jplinux.com jpn.ph jpvjp.com jsitstour.com juice7.com jukuduma.com jukujoweb.com just404.com jyoho_box jyukujo-hitoduma.com k-wife.com kai-masu.net kaitaku.net kaiten.net kakuremino.net kakushidori.com kanemoti.net kanpaku.jp kanpou.com kanpoulife kanpousky kansennashi.com kapipara kapipara.net kat-tun-mixi.com kat.cc kaupau.com kawaii-ne.net kazuboy.jp kenkoninjin kensho-get.com kentakun.net khon-thai.com kihujin.lolipop.jp kirekawa.net kiss-choo.com kiss.com kissy21.seesaa.net klikimi-te-linkut.com koi-away koi.net koicoco.net kon.vivian.jp konsekieraser.com koot.cn kp-good.com kp-pro.com ktai.sh kynavi.com kyoikanshi.com l-date.net l-feels.com ladys-beauty.kir.jp ladysroom.net lan.xl. lavien.cx lbdy.com lemon.v37.jp/confirm levitra life-service77.com life-work.net light.server.ne.jp lily-adolescence.cx lima-city.de linking.sakura.ne.jp linkoo.net linkzip.net little-ag.com live-d.net live-de-love lo-po.com loan lol.to lolipink.net lookingat.us lortab love-box.biz love-da.net love-ex.net love-fast-love.kir.jp love-first.net love-friend love-is-bet.com/ntnt love-medo.net love-shame.net love-thunder.com love.com lovebb.com lovejuice.manpee.cc lovelove69 lovely lovely-max lovely-net lovely-sex loverch.com lovetreasure.net lovetyphoon.com lppulu.net lucky-lady.cx lucky-vv.lxl.jp lucky7.to luv-3.com luv2hi.com lvbrandshop.com lvgood.com lvyahoo.net lxhost.com lxl.jp m-boo.net m-slave.net maclenet.com mad.buttobi.net madagasukaru.com madara28.net magazine-h.com magic-o-mirror.net maidx.net majestick-for.com mallyera.jp mamumamu.com manco manko mannbouland.com many-love.com marin151.fc2web.com market960.com master-rennai master-rennai.net match-navi.co.jp matchjp.com maximalf.com mayumidayo.h.fc2.com mayweekx.com mb.da7878.com mbga.jp mdx-blog.com media-h.tv meetyou.s8.x-beat.com melulu.net menpara mens-z.com menschannel.tv meridia mgf5.com mgoo.net mh2.mp7.jp mic-uni.com mickey.lomo.jp miffy-jp.com mikeneko.kikirara.jp milk-bom.net milky-manpee.com mindnmagick.com mini2.tv/mane miraclemail.jp misakisroom.fc2web.com mistres.cx mix-party.net mkbiew.com mlmsupport.jp mo-e.net mobileseek.web.fc2.com mocomoro.net modelz.tv moe-hakusyo.com moe-samurai.com moe-tsushin.com moe.funnynight.net moe.hm moem.biz moemoe-cute.com moemoe-gals.com mogura99.net mokko-gals.info momohaku.net momoiroheaven.com mon-nai.net mooootant.net moopara.com moppy.jp moroero.net moromoro.info moron moronuki.myvnc.com mortgage motituki.net movie-fine.com movie-max.bz movie.bbs69.net movmain.cc ms-05.net msn001.com msn005.com mumu.8ycn.com musashi-tv.net music-of-the-sun.com muvc.net mx.mierosoft.net my-place.us myblog.lx.ro myhome.cx mykanna.fc2web.com mypop.info n-ch.org namagoe.com nanacos.com nanfangjixie.com nani-buchi.com nappasan.com narod.ru natural-style.loops.jp nazi net-oasis.under.jp net4free.org netfirms.com netmouke.zero-city.com network54.com newsweb.biz nextculture.net nib.crimea.ua nice-peach.com nichecloner.com nigger night-0423.com nigro ninja-mania.jp nip-go.net nip-les.com nneada.com noads.biz noads.de noads.info nobody.jp nonanona.net noneto.com nonphotographyday.com nord-lead.com notlong.com nozoking-fc2.net nozokitai.net nttt.jp nuginuke.com nurel.biz nuru.cc nurunurujp.com nyu-haku.net o-decoron.com o-king.com o-pack.net ocn.ne.jp/~sakura08 odayaka.sunnyday.jp odn.ne.jp/~ckv49620 office-c3.com ok10000 ok3e.com okok57.fc2web.com okusantengok omata.hame-hame.net omega omitshopping omnc.net omo-chachacha.com onani one-night.site.ne.jp onedari-duma.com onnanoco.net op006275-0.viv777.jp openswarm.com opiece.com oppai or.tp ora5ora.net orange-z.net origo. orz.hm osasimi.imess.net oshoo.net otakaraidol.tv otc102.com otoko-juku.net otokomaturi.com otokonomikata otona.co.jp oulianyong.com outlet oxx.jp oxycontin oz-oz-oz.com p-dx.com p-i-ta.com p-place.net page.ne.jp paipan paipanic.com pak3.net panchira.tv paradise-movie.com paripori.net pasokoneiju.com pc-ainavi.com pc-deaimax20xx.com pc.deai.md pc.prepla.com peachlove.client.jp pene69.net penis pepar.jp pepsi-nex.net perfection.cx perfections.cx phentermine phentermine.philly1.com photoup.jp photozou.jp php5.cz pickupizm.com pillbay.net pink-hool.cn pink-scout pink-zone.jp pink.chatcool.net pinkeyes.tv pinkpag.net pinkxxxx.net pinky-girls.com pio2.net pissing pklo.jp plala.or.jp/attoyamaneko plala.or.jp/esaka planettt.com planslife.info pluscome.com plusone-1.com pocket.fm podzone.net pool.starletbabes.com pool.trap17.net pooo3.net poop pop-angel.com pop33.jp popra.zone.ne.jp porno positive-love.net poteto56.net pouton.fc2web.com power.ne.jp pq-h.cc pranetarium.net pre-get.or.tv pretty-cat.com pricemart.jp princess-net.biz prinprin69.com prohosting.com proly.net propecia prun.jp ps69.site.ne.jp puniwai.com pure-movie.com pure-nude.net pure.291295.net puredress.com puregirl24.com pururunn.tv puss pussy putibiji.com pv-youtube.com pwc.jp px.a8.net qq20096.com qrl.jp quick-cash raki-sta.net rakurakuhp.net rakvten.com rara-ra.net real77.net red.drive.ne.jp red.page.ne.jp ref.gs reg2.fc2web.com reimari.jp relax9ma.net ren55.net rental21.jp replica residence-parks residence-parks.com respace.net returner.cc rienoneko.com rikiyasan.com rimrom.net ripway.com rixx.crimea.ua rmt-home.jp rmt987.com ro-cheaper.com ro-mance.net rolex rose.donby.net royal-ska.com rteasddaws rush-x.jp rvjp.com rvschina.com rx-buy.30.pl s-b-c.jp s-collection.net s-friend.fkserver.net s-kaimasu.com s2.excoboard.com s3.artemisweb.jp s8.x-beat.com sabu.tv saddsah.com sakerver.com sale sales.ameranet.com samehada.com sante99 sato-bag.com saturdaynightexpress.com saunas.741.com scandal.purepure.org sea123.com seajp.com second-host.com second-host.net secret-key.net secret-keyhole.com seegle.com seesaa-blog.net sefrie-rich.info sefriend.net sefure.ath.cx sei-go.jp seiryokuzai seiyoku-pet.net self-nude.com sellcopybrand.com semen sereb serebuclub.net server.ne.jp set-place.net seven77.net sex sex-blend.com/anichan sexdvdmovie.net sexy-crazy.com sexyyou.jp sfdfj.com sh.orty.com shard.jp shesys.com shii shirayuki.saiin.net shit shoes shoperer.net shortlinks.co.uk side-h.net sikkaku.com silk-special.com simo01.com simple-c-8000.com simple-price.net sinfree.net sinnsenn sisyobako.net sitaxp.h.fc2.com site.ne.jp site12.bizmode.net sk-ocean.com sky-hart.com sky-hart.net skypeerisland.com slim-lovely sm smaf.jp smile8.net snipurl.com so-net.ws sodenoshita.com sogo-rank.com sohono1.at.infoseek.co.jp sokuhame.nengu.jp sokuman.nengu.jp soorp.com sorewa.net speed-blog.kir.jp sperm sprinterweb.net spyware ss999ss.com sssssa.com stabapop.com star-77.com starletbabes.com step123.main.jp stereo-pank.com store stupid stylish1.net subabag.com subekarazu.com sublimeblog.net suck suera.net sugar-angels.com sugarmixer.net sugu-ao.com sukebe sukechikubi.com sukisuki69 sukisuki69.com sundaybag.net support99.net swap.com sweet-girl.jp sweetrooms.com sweety.jp symy.jp t-t-factory.com t157.jp t35.com t55.jp tao2.sakura.ne.jp tarou55.net tattoo tawara-w7.net tayji.daa.jp tbtb.cn teamaggiespirit.com teen.elitecities.com temperaturee.net tera-mix.net tetty.ana-cafe.com the-last-time.com the-nagasaki.com theguestbook.com theripe.net thrt9.net tinko tinyurl.com titi.cc tits to.pl toda.site.ne.jp todonotsumari.com tohsen.isa-geek.com tokou-888.com tomama.net torotorohoney.com touch-net.net traingirls.com tramadol trap17.net true.betrun.net trump2.main.jp tsumekami.com ttp://alink tubakurame.com tumami.e04.net tw886.to twsgv.net twsunkom.com twtaipei.org tyuuka.com u-blog.net u-las.net u-navi.net u.lele.com ua9oml ugly uic.to ultimate-collection.biz ultram unalamp.h.fc2.com undonet.com unirap.com unko ura.polty.cc urashop url.com url.fibiger.org url4.net urlproxy.com urlsnip.com users.rol.ro valium vasilina.net veapparel.com vebaby.com vebedbath.com vemusic.net venus.cx vertigo.0catch.com vewireless.info viagra vic.rgr.jp vicodin vip-gals.com viral-blog-square.com virusseigyo.jp virusuwadame.com virusvanguard.com vo-ov.org w-flog.net w-master.net w0375.com wagoo2.com wagoo3.com wai-se2.com wakuteka.net waribiki55 wch.jp web-cafe.net web-earn.com web.ma2a.com webjo.e04.net weblike.jp weed wiiwi.net wikipedia.flop willing-to-wait.com win.mierosoft.net winds.server.ne.jp winwinlose.net woman-l.cx woman-line.cx wonder.polty.cc woowoo.com.cn workfordream.net www.roulettebotplus.com www.zip.dk www15.plala.or.jp/chouon www17.ocn.ne.jp/~dona www7.blog.163.com wwwlinks.biz x-area.net x-kanpou x-wisu.com x0.com xanax xenadrine xillist.net xixixi xn--7fr551b9j7a.net xnapster.com xrblog.com xrl.us xxx-www.com xxxdom.net xxxdot.net xxxgazou.net xyevdrom.org y-navi.net y-setu.puchiphoto.org yahoo2008.net yahoo588.com yamituki.net yang-lady.jp yanto.net yardie-yardie.com yasushi.site.ne.jp yattane.net ybb-ssi.com yellow-letter.com yoll.net yorokobi-net.com yosikov.com you-doutei.net ypcnet.com yukika.team-nobu.com yukiton.com yumehiro.com yurel.com yuripuri.h.fc2.com yycola.net yzlin.com z-box.jp z-mode.net za.pl zaitaku.group-japan.com zakmedia.net zaru.jp/nureteru zgzg.jp zippedurl.com zitakude.com zone.ne.jp zoomurl.com zu10.com zu9.net zvf.dk zz84.net バッバ プャネル ベーツ 財布 定番
EOM
$::disablewords_frozenwrite=<<EOM;
#head #html #meta #title
EOM
$::disablewords_username=<<EOM;
admin staff stuff
EOM
$::disablewords{ja}=<<EOM;
baka hentai h･ﾊｻ� jap linkross lsd omega quo･ｫ｡ｼ･ﾉ rolex seoｼｫﾆｰ shine snuff 雫芝 実射 ､｢､ｭ､皃ｯ､� ､｢､ﾊ､�､熙ﾃ､ﾗ ､､､�､ﾝ､ﾆ､�､ﾄ ､､､�､筅ｦ ､ｦ､ﾒ､网ｦ､ﾒ､� ､ｨ､ｿﾈ�ｿﾍ ､ｨ､ﾃ､ﾁ ､ｪ､ﾊ､ﾋ､ｺ､� ､ｪ､ﾞ､ﾈ､皈�｡ｼ･� ､ｪ､ﾞ､�､ｳ ､ｪ､ﾞ､�､ﾁ ､ｪ､皃ｳ ､ｪ､皃ﾁ､遉ｳ ､ｪ､皃ﾃ､ﾁ､� ､ｪ､皃�､ﾁ､� ､ｭ､ﾁ､ｬ､､" ､ｳ､ｸ､ｭ ､ｳ､�､ｹ ､ｻ､爨ｷ ､ｻ､�､ｺ､� ､ﾁ､�､ｫ､ｹ ､ﾁ､�､ﾝ ､ﾄ､�､ﾜ ､ﾎ､ｾ､ｭ ､ﾑ､､､ｺ､� ､ﾖ､ﾃ､ｫ､ｱ ､ﾗ､ﾃ､ｷ｡ｼ ､ﾞ､�､ｰ､�ﾊﾖ､ｷ ､ﾞ､�､ｳ ､ﾞ､�､ﾁ､� ､皃ｯ､� ､�､ｭ､ｬ ･｢･､･ﾉ･� ･｢･､･ﾌ ･｢･､･ﾎ･ｳ ･｢･ｨ･､･ﾇ ･｢･ｪ･ｫ･� ･｢･ｯ･ｻ･ｵ･� ･｢･ｹ･ﾛ｡ｼ･� ･｢･ｽ･ｳ ･｢･ﾀ･�･ﾈ ･｢･ﾊ･� ･｢･ﾋ･� ･｢･ﾋ･�･�･ｰ･ｹ ･｢･ﾌ･ｹ ･｢･ﾕ･｣･�･ｨ･､･ﾈ ･｢･ﾛ ･｢･盧� ･｢･�･ﾐ･､･ﾈ ･｢･�･ﾝ･�･ｿ･� ･､･ｸ･盥篦猴｡ ･､･ﾆ･ﾞ･ｦ･ｾ ･､･鬣ﾍ ･､･鬣ﾞ･ﾁ･ｪ ･､･�･筵ｦ ･ｦ･� ･ｦ･�･ｳ ･ｦ･�･ﾁ ･ｨ･､･ｺ ･ｨ･ｯ･ｵ･ｵ･､･ｺ ･ｨ･ｹ･ｭ･筍ｼ ･ｨ･ｿ ･ｨ･ﾃ･ﾁ ･ｨ･� ･ｨ･�､､ ･ｨ･�･ｹ ･ｨ･�･ﾆ･｣･ﾃ･ｯ ･ｨ･�ﾆｰｲ� ･ｪ｡ｼ･ｯ･ｷ･逾� ･ｪ｡ｼ･鬣�･ｻ･ﾃ･ｯ･ｹ ･ｪ･､･ﾜ･� ･ｪ･ｿ ･ｪ･ｿ･ｯ ･ｪ･ﾁ･�･ﾁ･� ･ｪ･ﾃ･ﾑ･､ ･ｪ･ﾃ･ﾑ･ｪ ･ｪ･ﾊ ･ｪ･ﾊ･ﾋ ･ｪ･ﾊ･ﾋ｡ｼ ･ｪ･ﾊ･ﾋ･ｺ･� ･ｪ･ﾊ･ﾌ ･ｪ･ﾊ･ﾚ･ﾃ･ﾈ ･ｪ･ﾊﾆ� ･ｪ･ﾞ･�･ｳ ･ｪ･皈ｬ ･ｪ･皈ｳ ･ｪ･�･ｴ ･ｪ･�･ｬ･ｹ･� ･ｪｲﾖﾈｪ ･ｪｶ筵ﾏ･ﾀ･ｹ ･ｪﾁｰ･� ･ｫ･ｸ･ﾎ ･ｫ･ｹ ･ｫ･ｿ･�･ｰ ･ｫ･ｿ･� ･ｬ･� ･ｭ･ｰ･�･､ ･ｭ･ｷ･逾､ ･ｭ･ﾁ･ｬ･､ ･ｭ･皈ｧ ･ｭ･皈ｨ ･ｭ･筵､ ･ｭ･罕ﾃ･ｷ ･ｭ･罕ﾃ･ｷ･螂ﾐ･ﾃ･ｯ ･ｭ･罕�･ｻ･鬘ｼ ･ｭ･逾ｦ･ｸ･� ･ｭ･逾ﾋ･蝪ｼ ･ｭ･逾ﾋ･螂ｦ ･ｭ･�･ｿ･ﾞ ･ｭ･�･� ･ｮ･ﾕ･ﾈ ･ｮ･罕�･ﾖ･� ･ｯ｡ｼ･遙ｼ ･ｯ･ｽ ･ｯ･ｿ･ﾐ･� ･ｯ･�･ﾃ･ｯ ･ｯ･�･ﾈ･�･ｹ ･ｯ･�･ﾋ･ﾃ･ｯ ･ｯ･�｡ｼ･ｶ｡ｼ ･ｯ･�･ｦ ･ｯ･�･ｸ･ﾃ･ﾈ･ｫ｡ｼ･ﾉ ･ｯ･�･ﾋ ･ｯ･�･ﾋ･�･�･ｰ･ｹ ･ｰ･ﾃ･ｺ ･ｰ･鬣ﾓ･｢ ･ｰ･鬣ﾕ･｣･ﾃ･ｯ ･ｲ･ｹ ･ｳ･ｹ･� ･ｳ･�･ｵ ･ｳ･�･ｷ ･ｳ･�･ｹ ･ｳ･�･ｻ ･ｳ･�･ｽ ･ｳ･�･ﾉ｡ｼ･� ･ｴ･ｦ･ｫ･� ･ｴ･ﾈ･ｭ･ｬ ･ｵ･､･ﾈﾈ豕ﾓ ･ｵ･ｯ･� ･ｵ･ﾃ･ｫ｡ｼ ･ｵ･ﾄ ･ｵ･ﾉ ･ｵ･ﾗ･� ･ｵ･ﾝ｡ｼ･ﾈ･ｷ･ｿ･､ｰ�ｿｴ･ﾇ ･ｵ･ﾝｴ�ﾋｾ ･ｵ･鮓� ･ｵ･�･ﾗ･� ･ｵ･�･ﾗ･�ﾆｰｲ� ･ｶ｡ｼ･皈� ･ｷ･ｳ･ｷ･ｳ ･ｷ･ｳ･ﾃ･ﾆ ･ｷ･ﾊ ･ｷ･ﾌ ･ｷ･ﾍ ･ｷ･蝪ｼ･ｺ ･ｷ･逾ﾃ･ﾔ･�･ｰ ･ｷ･�･ﾘ･､･ﾟ･� ･ｸ･ﾗ･ｷ｡ｼ ･ｸ･罕ﾃ･ﾗ ･ｹ･ｫ｡ｼ･ﾈ ･ｹ･ｫ･ﾈ･� ･ｹ･ｯ｡ｼ･�･ｬ｡ｼ･� ･ｹ･ｿ｡ｼ･ﾓ｡ｼ･ﾁ ･ｹ･ﾑ･､ ･ｹ･ﾔ･�･ﾁ･螂｢･� ･ｹ･ﾙ･ｿ ･ｹ･ﾚ･�･ﾞ ･ｹ･ﾞ･ｿ ･ｹ･�･� ･ｹ･�･ﾃ･ﾔ･�･ｰ ･ｻ･ﾃ･ｯ･ｹ ･ｻ･ﾕ･� ･ｻ･爭ｷ ･ｻ･�･ｸ･� ･ｻ･�･ｺ･� ･ｽ｡ｼ･ﾗ ･ｿ･ﾒ ･ﾀ･､･ｨ･ﾃ･ﾈ ･ﾀ･ﾃ･ﾁ･ﾕ･｡･ﾃ･ｯ ･ﾀ･ﾃ･ﾁ･�･､･ﾕ ･ﾀ･ﾛ ･ﾁ･ｨ･ｪ･ｯ･� ･ﾁ･ｯ･ﾓ ･ﾁ･ﾓ ･ﾁ･罕�･ｳ･� ･ﾁ･逾ﾃ･ﾑ･� ･ﾁ･逾� ･ﾁ･鬣ｷ ･ﾁ･�･ｫ･ｹ ･ﾁ･�･ｳ ･ﾁ･�･ﾁ･� ･ﾁ･�･ﾝ ･ﾄ･ﾞ･鬣ﾊ･､ ･ﾄ･ﾞ･鬣ﾍ ･ﾄ･ﾞ･�･ﾍ ･ﾄ･�･ﾜ ･ﾆ･､･ﾎ･ｦ ･ﾆ･ｯ･ﾎ･ｹ･ﾈ･�･ｹ ･ﾆ･�･ｦ･ｧ･､･� ･ﾇ｡ｼ･ﾈ ･ﾇ･ﾖ ･ﾇ･�･ﾐ･遙ｼ･ﾜ｡ｼ･､ ･ﾇ･�･ﾘ･� ･ﾈ･�･ｳｾ� ･ﾈ･�･ｳﾉ�ﾏ､ ･ﾉ｡ｼ･ﾆ｡ｼ ･ﾉ･ｦ･ﾆ｡ｼ ･ﾉ･ｦ･ﾆ･､ ･ﾉ･筵� ･ﾉ･鬣ﾞ ･ﾊ･�･ﾑ ･ﾋ･ｬ｡ｼ ･ﾋ･ｰ･� ･ﾋ･ﾀ ･ﾌ｡ｼ･ﾉ ･ﾌ･ｲ ･ﾎ･ｯ･ｻ･ﾋ ･ﾏ･ｯ･ﾁ ･ﾏ･ｲ ･ﾏ･ﾃ･ﾔ｡ｼ･癸ｼ･� ･ﾏ･ﾃ･ﾔ｡ｼ･鬣､･ﾕ ･ﾏ･ﾗ･ﾋ･�･ｰ ･ﾏ･�･ｸ･罕� ･ﾐ｡ｼ･ｫ ･ﾐ･､･ﾖ ･ﾐ･ｫ ･ﾐ･ｮ･ﾊ ･ﾐ･�･ﾓ･ﾔ｡ｼ･ﾁ ･ﾑ･､･ｺ･� ･ﾑ･､･ﾑ･� ･ﾑ･ｳ･ﾑ･ｳ ･ﾑ･ﾁ･ｹ･� ･ﾑ･ﾁ･�･ｳ ･ﾑ･ﾃ･ﾑ･ｫ･ﾃ･｡･｢･�･｢･� ･ﾑ･�･ﾄ ･ﾑ･�･ﾆ･｣ ･ﾒ･ｭ･ｳ･筵� ･ﾒ･ﾋ･� ･ﾒ･�･ﾋ･蝪ｼ ･ﾒ･�･ﾋ･螂ｦ ･ﾓ･ﾃ･ｳ ･ﾓ･ﾃ･ﾁ ･ﾓ･蝪ｼ･ﾆ･｣ ･ﾔ･ﾁ･ﾔ･ﾁ･ﾔ｡ｼ･ﾁ ･ﾔ･�･ｯ･�｡ｼ･ｿ｡ｼ ･ﾕ｡ｼ･ｾ･ｯ ･ﾕ･｡･ｷ･ｹ･ﾈ ･ﾕ･｡･ﾃ･ｭ･� ･ﾕ･｡･ﾃ･ｯ ･ﾕ･｡･ﾃ･ｷ･逾� ･ﾕ･｡･ﾓ･� ･ﾕ･｣･ｹ･ﾈ･ﾕ･｡･ﾃ･ｯ ･ﾕ･｣･�･ｬ｡ｼ･ﾕ･｡･ﾃ･ｯ ･ﾕ･ｦ･ｾ･ｯ ･ﾕ･ｧ･� ･ﾕ･ｧ･鬣ﾁ･ｪ ･ﾕ･�･ｦ･ｷ･� ･ﾖ･ｦ･� ･ﾖ･ｵ･､･ｯ ･ﾖ･ｵ･� ･ﾖ･ｹ ･ﾖ･ｿ ･ﾖ･ｿ･ﾐ･ｳ ･ﾖ･ｿﾈ｢ ･ﾖ･鬣�･ﾉ ･ﾖ･鬣�･ﾉｷ羃ﾂ ･ﾖ･鬣�･ﾉｺ篷ﾛ･ﾐ･ﾃ･ｰ ･ﾖ･�･ｰｽ鯑ｩﾀ� ･ﾗ･ﾃ･ｷ｡ｼ ･ﾗ･�･ｼ･� ･ﾗ･�ｻﾔﾌｱ ･ﾗ･�ﾅﾛﾎ� ･ﾘ･�･ｹ ･ﾚ･ﾋ･ｹ ･ﾛ｡ｼ･爭�･ｹ ･ﾛ･ｦ･ｱ･､ ･ﾛ･ｹ･ﾈ ･ﾛ･ﾃ･ﾈ､ﾊ ･ﾛ･ﾆ･ﾘ･� ･ﾛ･� ･ﾛ･�･筵� ･ﾜ･ｱ ･ﾜ･ﾃ･ｭ ･ﾜ･�･ﾇ｡ｼ･ｸ ･ﾝ｡ｼ･ｫ｡ｼ ･ﾝ･ｳ･ﾁ･� ･ﾝ･�･ﾎ ･ﾝ･�･ﾓ･ｭ ･ﾞ｡ｼ･ﾁ･罕�･ﾈ ･ﾞ･､･ﾟ･ｯ ･ﾞ･ｹ･ｿ｡ｼ･ﾙ｡ｼ･ｷ･逾� ･ﾞ･ｹ･ｿ･ﾙ｡ｼ･ｷ･逾� ･ﾞ･ｽ･ｳ ･ﾞ･ｾ ･ﾞ･ﾃ･ｵ｡ｼ･ｸ ･ﾞ･ﾋ･｢ｸ�･ｭ ･ﾞ･ﾌ･ｱ ･ﾞ･� ･ﾞ･�･ﾕ･｡･ﾊ ･ﾞ･�･ｰ･� ･ﾞ･�･ｳ ･ﾞ･�･ｸ･逾ｳ ･ﾞ･�･ﾁ･� ･ﾞ･�･ﾂ･逾ｳ ･ﾟ･ﾟ･ｺﾀ鯔､ ･皈ｯ･� ･皈�･ｺ ･筵ｭ･� ･筵ﾇ･� ･筵�･ｭ｡ｼ ･茹�･ﾞ･� ･隘�･� ･鬣､･ﾖ･ﾁ･罕ﾃ･ﾈ ･鬣ﾖ･ﾛ ･�･�･ｯ･�･ｹ ･�･､･ﾗ ･�･ｺ ･�｡ｼ･ｷ･逾� ･�｡ｼ･ｿ｡ｼ ･�･�･ﾃ･ｯ･ｹ ･�･ｮ･ﾊ ･�･ｿ･ｯ ･�･｡･ｮ･ﾊ ･�･｡･ｮ･ﾋ･ｹ･爭ｹ ｰ､ﾊ� ｰｦｱﾕ ｰｦｿﾍ ｰﾙﾂﾘ ｰ�ｺ� ｰ� ｰ�ﾇ� ｰ�ﾍ� ｱ｢ｳﾋ ｱ｢ｷﾔ ｱ｢ﾌﾓ ｱｧﾃ� ｱｿｱﾄｻ�ﾌｳｶﾉ ｱﾑｲ�ﾏﾃ ｱ邵� ｱ鄂� ｱ鄂�ｸ�ｺﾝ ｲｫｶ篩� ｲｯﾋ�ﾄｹｼﾔ ｲｼﾃ� ｲｼﾎｮ ｲｿ･ｫ･ﾃ･ﾗ ｲﾈｽﾐ ｲﾈﾅﾅ ｲﾏｸｶ､ｳ､ｸ､ｭ ｲﾐﾉﾂ ｲﾔ､､ ｲﾔ､ｰ ｲﾔ､ｲ ｲﾖﾊｴ ｲﾚｳｨ ｲ盥� ｲ賤�ｽﾁ ｲ�ｰ�ﾊ鄂ｸ ｲ�ｱ｢ ｲ�ｼ� ｳｫｱｿ ｳｫﾈｯﾅﾓｾ蟷� ｳﾊｰﾂ ｳ茹�ﾀﾚ･ﾃ･ｿｴﾘｷｸ ｴｯ ｴｱﾇｽ ｴｶﾀ� ｴｹｶ� ｴﾁﾊ�ﾀｺﾎﾏ ｴﾚｹ� ｴ鮠ﾍ ｴ�ﾃﾏｳｰ ｴ�ﾀｸﾃ� ｵ｢ｲｽｿﾍ ｵ､､ﾁ､ｬ､､ ｵ､ｰ罕､ ｵ､ｶｸ･､ ｵｳｾ隹ﾌ ｵｵｹﾃﾇ�､� ｵｵﾆｬ ｵﾕｱ� ｵﾛｷﾔ ｵﾜｸﾅﾅ� ｵ� ｵ�ﾆ� ｶ･ﾇﾏ ｶｯｴｯ ｶｸ･ｦ ｶｸｿﾍ ｶｺﾀｵ ｶﾃｰﾛ ｶﾌｶ� ｶﾌ醺､� ｶ箜ｿ ｶ筝ﾌ ｶ筝ﾌ", ｶ�ｶﾊｰﾌ ｷﾇｼｨﾈﾇ･ﾋﾅｽ･�ﾉﾕ･ｱ･ﾆ ｷﾈﾂﾓ･ｵ･､･ﾈ ｷﾙｻ｡ ｷﾜ ｷﾝﾇｽ ｷ羃ﾂ ｷ羃ﾂ･ﾖ･鬣�･ﾉ ｷ�ｼ� ｷ�ｹｯ ｷ�ｹｯｴ�ｶ� ｸ､ｻｦ､ｷ ｸ､ｻｦ･ｷ ｸ､ｿｩ･､ ｸｫﾊ�ﾂ� ｸｶｽｻﾌｱ ｸｽ･ﾊ･ﾞ ｸｽｶ� ｸﾂﾄ� ｸﾄｿﾍﾍ｢ﾆ�ﾂ蟷ﾔ ｸﾉｻ�ｱ｡ ｸ莎ﾚ ｸ蠎ﾂｰﾌ ｸ蠢ﾊｹ� ｸ衂ﾘｰﾌ ｸ�ｳﾘ ｸ�ｿｩ ｸ�ｺﾝ ｸ�､ｯ ｹｩｺ�ｰ� ｹｬｱｿ ｹｭｹ� ｹﾃﾅﾄ ｹ箋ﾛ ｹ簀ｷｸｶ ｹ逾､･ﾎｻﾒ ｹ邉ﾊ ｹ醉｡ ｹ�･鬣�･�･ｹ ｹ�ﾂｱ ｹ�･�･ﾜ ｹ�ｿﾍ ｺ､ﾆ� ｺﾗ ｺﾟﾂ� ｺﾟﾆ� ｺ篷ﾛ ｻｦ､ｷ､ﾋ ｻｦ､ｹ ｻｦ･ｹ ｻｰｹ�ｿﾍ ｻｺﾇﾌ ｻﾒｶ｡ ｻﾒｹｻ ｻﾒﾂ� ｻﾘ･ﾞ･� ｻﾙﾆ� ｻ爨ﾋ､ｿ､､ ｻ爨ﾍ ｻ爨ﾎ ｻ爭ﾍ ｻ爭� ｻ皈ﾍ ｻ�ｳﾐｾ羌ｲｼﾔ ｻ�ｲﾊ ｻ�ﾆｸﾍﾜｸ�ｻﾜﾀﾟ ｼ｣ﾎﾅ ｼｫｰﾖ ｼｫﾆｰﾁ�ｸﾟ ｼﾍﾀｺ ｼﾕﾎ� ｼ�･ｳ･ｭ ｼ�･ﾖ･� ｼ�ｰ� ｼ�ﾀ� ｼ�ｸｳ ｼ�ﾆ� ｽﾏｽ� ｽﾐｲﾔ･ｮ ｽﾐｲ� ｽﾐﾈﾇ ｽ霓� ｽ霓�ﾋ� ｽ鯆ﾎｸｳ ｽ�ｻｺｻﾕ ｽ�ｻｺﾉﾘ ｽ�ｱ｢ ｽ�ｻﾒ ｽ�ｻﾒｶ｡ ｽ�ﾀｭｴ� ｽ�ﾍ･ ｾｦｺ� ｾｮｸｯ ｾｮｸｯ･､ｲﾔ･ｮ ｾｮｻ�ﾉﾂ ｾｯｽ� ｾﾃﾈ�ｼﾔｶ簣ｻ ｾﾆﾆ� ｾﾐ､､ ｾﾚｵ�ｶ� ｾ羌ｲ ｾ�ﾊ�ｾｦｺ� ｿ｢ﾊｪｿﾍｴﾖ ｿｫ ｿｴｾ� ｿｷﾊｿﾌｱ ｿﾍｵ､･鬣�･ｭ･�･ｰ ｿﾍｺﾊ ｿ�､ﾎｻﾒﾅｷｰ� ﾀｨ･､ｽ�･ｭｹ�･ﾟ ﾀｭｴｶ ﾀｭｴ� ﾀｭｸ� ﾀｭﾀｸｳ� ﾀｭﾉﾂ ﾀｭﾊﾊ ﾀｰﾂﾎ ﾀｵｾ�ｰﾌ ﾀｵﾉﾊzippo ﾀｺｱﾕ ﾀｺｻﾒ ﾀｺｿﾀ ﾀｺｿﾀｰﾛｾ� ﾀｺｿﾀﾇ�ｼ蟒� ﾀｺｿﾀﾊｬﾎ� ﾀｺﾇ� ﾀｺﾎﾏ ﾀｺﾎﾏｺﾞ ﾀﾂ ﾀﾄ･ｫ･� ﾀﾄｴｯ ﾀﾜｼﾌ ﾀ鮟､､� ﾀ熙､ ﾁｨﾌｱ ﾁｰｵｺ ﾁﾇｸﾔ ﾁﾇｿﾍ ﾁﾏｲﾁ ﾁﾚｺﾚ ﾁ�ｸﾟｼｫｰﾖ ﾂｨｶ� ﾂｮﾊ�ｰ�ﾈﾖ ﾂｿｽﾅｺﾄﾌｳ ﾂﾎｰﾌ ﾂﾔ､ﾁｹ� ﾂ賺ﾑﾀｯﾉﾜ ﾂ邏ﾚﾌｱｹ� ﾂ邯� ﾂ鄙ﾍ､ﾎﾎｹｹﾔ ﾂ醋ﾘ ﾂ醉� ﾃｦ･､･ﾇ ﾃｦ･ｲ ﾃｦﾊｵ ﾃｦﾌﾓ ﾃｫｴﾖ ﾃﾋｺｬ ﾃﾎｾ� ﾃﾑ･ｺ･ｫ･ｷ･､･ｱ･ﾉ ﾃﾑｵﾖ ﾃﾑｹ､ ﾃﾑﾌﾓ ﾃﾓｾﾂ ﾃﾔ ﾃﾔﾊ�ｾﾉ ﾃ螂ｨ･� ﾃ豸ｦ ﾃ貉�ﾅ�ﾋﾌﾉ� ﾃ貎ﾐ､ｷ ﾃ貎ﾐ･ｷ ﾃ貲ﾄｻ� ﾃ貳�ﾉﾂ ﾄｫﾁｯ ﾄｫﾁｯﾀｬﾈｲ ﾄｻ･､･�･ﾕ･� ﾄﾌｿｮﾈﾎﾇ� ﾄﾌﾈﾎ ﾄﾙ･ｻ ﾄ羌ﾘﾎ� ﾄ翩ｽｻ� ﾄ翩ｾ ﾄ�ｷﾈ ﾅﾅﾇﾈ ﾅﾋﾌ� ﾅﾋﾌ�ｾ� ﾅﾋﾌ�ｿﾍ ﾅﾚﾊ� ﾅ�ｻ｣ ﾆｬ･ｪ･ｫ･ｷ･､ ﾆｸﾄ� ﾆﾃｰ｡ ﾆ�ﾁｯ ﾆ�ﾋﾀ ﾆ�ｵ� ﾆ�ﾏﾂｸｫ ﾆ�ｼ� ﾇｧﾃﾎｾﾉ ﾇｨ ﾇﾁ ﾇﾋｻｺ ﾇﾏ ﾇﾏｼｯ ﾇﾐﾍ･ ﾇﾘｸ蟆ﾌ ﾇ羶ﾕ ﾇ荵� ﾇ菴ﾕ ﾇ菴ﾕﾉﾘ ﾇ菴� ﾇ�ﾃﾔ ﾇ�ﾆﾚ ﾇ�ﾆ� ﾈｯﾅｸﾅﾓｾ蟷� ﾈｿｱﾑ ﾈｿｴﾚ ﾈｿﾃ� ﾈｿﾆﾈ ﾈｿﾆ� ﾈｿﾊｩ ﾈｿﾊﾆ ﾈﾈ､ｷ ﾈﾈ･ｷ ﾈ狃� ﾈ�ｿﾍ ﾈ�ｿﾍ ﾈ�ﾍﾆ ﾉﾏﾆ� ﾉﾔｲﾄｿｨﾁｨﾌｱ ﾉﾔｲﾄｿｨﾌｱ ﾉﾔｺﾙｹｩ ﾉﾔﾎﾑ ﾉ�ﾍ� ﾉ�ｿ� ﾉ�ﾂｯ ﾉ�ｶﾈ ﾉ�ｼ�ﾆ� ﾊ｡ﾂﾞ ﾊｩｶｵ ﾊｬｺﾝ ﾊｵ ﾊｵﾇ｢ ﾊｸﾌﾕ ﾊﾑﾂﾖ ﾊﾘﾈ� ﾊ�ｷﾔ ﾊ�､ｯ､ｸ ﾊ�ﾇ｢ ﾋｽｹﾔ ﾋﾌﾁｯ ﾋﾖｵｯ ﾋﾜｵ､ｽﾁ ﾋﾜﾈﾖ ﾋ耄� ﾋ�ｱﾟ ﾋ�ｵﾊ ﾋ�ｽ｣ ﾌ､ｳｫｿﾍ ﾌ､ｳｫﾈｯｹ� ﾌｵｽ､ﾀｵ ﾌｵﾍ�､荀� ﾌｵﾎﾁ ﾌｵﾎﾁﾆｰｲ� ﾌﾀﾌﾕ ﾌﾓﾅ� ﾌﾓﾅ篩ﾍ ﾌﾓﾈｱ ﾌﾕｿﾍ ﾌﾕﾌﾜ ﾌﾙ､ｫ ﾌﾙ､ｱ ﾌﾜ･ﾎﾉﾔｼｫﾍｳ･ﾊｿﾍ ﾌ�ﾇ遉､ ﾌ�ｵ� ﾌ�ｹ� ﾌ�ﾈﾚｿﾍ ﾌ�､｢､� ﾌ�ｾ�ｸﾐ ﾍｧﾃ｣ｾﾒｲ� ﾍﾄｽ� ﾍ� ﾍ�ｸ� ﾍ�ﾋｽ ﾎ｢･�･ｶ ﾎｱﾃﾖｾ� ﾎ�ｴｶ ﾏｪｽﾐ ﾏｷｳｲ ﾒ� ﾓﾃ､ｮ ﾓﾃ･､･ﾇ ﾙ讌ﾞ ﾙ讌� 獎 耡ﾂｿ 跛ﾌ� 跛ﾌ郛ｫｰﾖ ��ｽｭ 邏 醺 魄ｰ蠑ﾔ ��
EOM
$::disablewords_frozenwrite{ja}=<<EOM;

EOM
$::disablewords_username{ja}=<<EOM;
･ｫ･�･�･ｷ･� ･ｫ･�･�･ﾋ･� ｴﾉﾍ�ｼﾔ ｴﾉﾍ�ｿﾍ
EOM
