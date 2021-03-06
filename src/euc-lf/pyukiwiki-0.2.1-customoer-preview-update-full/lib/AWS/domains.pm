######################################################################
# domains.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:15:38
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2000-2015 - Laurent Destailleur - eldy.sourceforge.net
# http://awstats.sf.net/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# AWSTATS DOMAINS DATABASE
#-------------------------------------------------------
# If you want to add a new domain to extend AWStats database detection capabilities,
# you must add an entry in DomainsHashIDLib.
#-------------------------------------------------------
# Revision: 1.14 - Author: eldy - Date: 2009/09/28 00:00:17
# Edited by papu
#package AWSDOM;
# DomainsHashIDLib
# List of domain with their name ('domain id', 'Domain name')
# Official list can be found at http://www.iana.org/cctld/cctld-whois.htm
# 'Domain id' should be ISO 3166 code + miscelanous domains
#-------------------------------------------------------
%DomainsHashIDLib = (
# JP domains
'ac.jp','Japanese academic domains',
'co.jp','Japanese commercial domains',
'go.jp','Japanese government domains',
'or.jp','Japanese organization domains',
'ad.jp','Japanese administrators domains',
'ne.jp','Japanese network domains',
'gr.jp','Japanese groops domains',
'ed.jp','Japanese education domains',
'lg.jp','Japanese local government domains',
'kek.jp','KEK.JP',
'hokkaido.jp','Japanese hokkaido area domains',
'aomori.jp','Japanese aomori area domains',
'iwate.jp','Japanese iwate area domains',
'miyagi.jp','Japanese miyagi area domains',
'akita.jp','Japanese akita area domains',
'yamagata.jp','Japanese yamagata area domains',
'fukushima.jp','Japanese fukushima area domains',
'ibaraki.jp','Japanese ibaraki area domains',
'tochigi.jp','Japanese tochigi area domains',
'gunma.jp','Japanese gunma area domains',
'saitama.jp','Japanese saitama area domains',
'chiba.jp','Japanese chiba area domains',
'tokyo.jp','Japanese tokyo area domains',
'kanagawa.jp','Japanese kanagawa area domains',
'niigata.jp','Japanese niigata area domains',
'toyama.jp','Japanese toyama area domains',
'ishikawa.jp','Japanese ishikawa area domains',
'fukui.jp','Japanese fukui area domains',
'yamanashi.jp','Japanese yamanashi area domains',
'nagano.jp','Japanese nagano area domains',
'gifu.jp','Japanese gifu area domains',
'shizuoka.jp','Japanese sizuoka area domains',
'aichi.jp','Japanese aichi area domains',
'mie.jp','Japanese mie area domains',
'shiga.jp','Japanese shiga area domains',
'kyoto.jp','Japanese kyoto area domains',
'osaka.jp','Japanese osaka area domains',
'hyogo.jp','Japanese hyogo area domains',
'nara.jp','Japanese nara area domains',
'wakayama.jp','Japanese wakayama area domains',
'tottori.jp','Japanese tottori area domains',
'shimane.jp','Japanese shimane area domains',
'okayama.jp','Japanese okayama area domains',
'hiroshima.jp','Japanese hiroshima area domains',
'yamaguchi.jp','Japanese yamaguchi area domains',
'tokushima.jp','Japanese tokushima area domains',
'kagawa.jp','Japanese kagawa area domains',
'ehime.jp','Japanese ehime area domains',
'kochi.jp','Japanese kochi area domains',
'fukuoka.jp','Japanese fukuoka area domains',
'saga.jp','Japanese saga area domains',
'nagasaki.jp','Japanese nagasaki area domains',
'kumamoto.jp','Japanese kumamoto area domains',
'oita.jp','Japanese oita area domains',
'miyazaki.jp','Japanese miyazaki area domains',
'kagoshima.jp','Japanese kagoshima area domains',
'okinawa.jp','Japanese okinawa area domains',
# JP fake domains
'jp.net','Japanese network fake domains',
'jpn.com','Japanese commercial fake domains',
# Add other top domains
'tel','tel Domains',
'travel','travel Domains',
'localhost','localhost',
'i0','Local network host',
'a2','Satellite access host',
'ac','Ascension Island','ad','Andorra','ae','United Arab Emirates',
'aero','Aero/Travel domains','af','Afghanistan',
'ag','Antigua and Barbuda','ai','Anguilla','al','Albania',
'am','Armenia','an','Netherlands Antilles','ao','Angola',
'aq','Antarctica','ar','Argentina','arpa','Old style Arpanet',
'as','American Samoa','at','Austria','au','Australia','aw','Aruba',
'ax','Aland islands',
'az','Azerbaidjan','ba','Bosnia-Herzegovina','bb','Barbados',
'bd','Bangladesh','be','Belgium','bf','Burkina Faso','bg','Bulgaria',
'bh','Bahrain','bi','Burundi','biz','Biz domains','bj','Benin','bm','Bermuda',
'bn','Brunei Darussalam','bo','Bolivia','br','Brazil','bs','Bahamas',
'bt','Bhutan','bv','Bouvet Island','bw','Botswana','by','Belarus',
'bz','Belize','ca','Canada','cc','Cocos (Keeling) Islands',
'cd','Congo, Democratic Republic of the',
'cf','Central African Republic','cg','Congo','ch','Switzerland',
'ci','Ivory Coast (Cote D\'Ivoire)','ck','Cook Islands','cl','Chile','cm','Cameroon',
'cn','China','co','Colombia','com','Commercial','coop','Coop domains','cr','Costa Rica',
'cs','Former Czechoslovakia','cu','Cuba','cv','Cape Verde',
'cx','Christmas Island','cy','Cyprus','cz','Czech Republic','de','Germany',
'dj','Djibouti','dk','Denmark','dm','Dominica','do','Dominican Republic',
'dz','Algeria','ec','Ecuador','edu','USA Educational','ee','Estonia',
'eg','Egypt','eh','Western Sahara','er','Eritrea','es','Spain','et','Ethiopia',
'eu','European country',
'fi','Finland','fj','Fiji','fk','Falkland Islands','fm','Micronesia','fo','Faroe Islands',
'fr','France','fx','France (European Territory)','ga','Gabon',
'gb','Great Britain','gd','Grenada','ge','Georgia','gf','French Guyana',
'gg','Guernsey','gh','Ghana','gi','Gibraltar',
'gl','Greenland','gm','Gambia','gn','Guinea','gov','USA Government','gp','Guadeloupe (French)',
'gq','Equatorial Guinea','gr','Greece','gs','S. Georgia &amp; S. Sandwich Isls.',
'gt','Guatemala','gu','Guam (USA)','gw','Guinea Bissau','gy','Guyana',
'hk','Hong Kong','hm','Heard and McDonald Islands','hn','Honduras',
'hr','Croatia','ht','Haiti','hu','Hungary','id','Indonesia','ie','Ireland','il','Israel',
'im','Isle of Man','in','India','info','Info domains','int','International','io','British Indian Ocean Territory',
'iq','Iraq','ir','Iran','is','Iceland','it','Italy',
'je','Jersey','jm','Jamaica','jo','Jordan',
'jobs','Jobs domains',
'jp','Japan','ke','Kenya','kg','Kyrgyzstan',
'kh','Cambodia','ki','Kiribati','km','Comoros','kn','Saint Kitts &amp; Nevis Anguilla',
'kp','North Korea','kr','South Korea','kw','Kuwait',
'ky','Cayman Islands','kz','Kazakhstan','la','Laos','lb','Lebanon','lc','Saint Lucia',
'li','Liechtenstein','lk','Sri Lanka','lr','Liberia','ls','Lesotho','lt','Lithuania',
'lu','Luxembourg','lv','Latvia','ly','Libya','ma','Morocco','mc','Monaco',
'md','Moldova','me','Montenegro','mg','Madagascar','mh','Marshall Islands','mil','USA Military',
'mk','Macedonia','ml','Mali','mm','Myanmar','mn','Mongolia','mo','Macau',
'mobi','Mobi domains',
'mp','Northern Mariana Islands','mq','Martinique (French)','mr','Mauritania',
'ms','Montserrat','mt','Malta','mu','Mauritius','museum','Museum domains','mv','Maldives',
'mw','Malawi','mx','Mexico','my','Malaysia','mz','Mozambique','na','Namibia','name','Name domains','nato','NATO',
'nc','New Caledonia (French)','ne','Niger','net','Network','nf','Norfolk Island',
'ng','Nigeria','ni','Nicaragua','nl','Netherlands','no','Norway',
'np','Nepal','nr','Nauru','nt','Neutral Zone','nu','Niue','nz','New Zealand','om','Oman',
'org','Non-Profit Organizations','pa','Panama','pe','Peru','pf','Polynesia (French)',
'pg','Papua New Guinea','ph','Philippines','pk','Pakistan','pl','Poland',
'pm','Saint Pierre and Miquelon','pn','Pitcairn Island','pr','Puerto Rico','pro','Professional domains',
'ps','Palestinian Territories','pt','Portugal','pw','Palau','py','Paraguay','qa','Qatar',
're','Reunion (French)','ro','Romania',
'rs','Republic of Serbia',
'ru','Russian Federation','rw','Rwanda',
'sa','Saudi Arabia','sb','Solomon Islands','sc','Seychelles',
'sd','Sudan','se','Sweden','sg','Singapore','sh','Saint Helena','si','Slovenia',
'sj','Svalbard and Jan Mayen Islands','sk','Slovak Republic','sl','Sierra Leone',
'sm','San Marino','sn','Senegal','so','Somalia','sr','Suriname',
'st','Sao Tome and Principe','su','Former USSR','sv','El Salvador','sy','Syria','sz','Swaziland',
'tc','Turks and Caicos Islands','td','Chad','tf','French Southern Territories','tg','Togo',
'th','Thailand','tj','Tadjikistan','tk','Tokelau','tm','Turkmenistan','tn','Tunisia',
'to','Tonga','tp','East Timor','tr','Turkey','tt','Trinidad and Tobago','tv','Tuvalu',
'tw','Taiwan','tz','Tanzania','ua','Ukraine','ug','Uganda',
'uk','United Kingdom','um','USA Minor Outlying Islands','us','United States',
'uy','Uruguay','uz','Uzbekistan','va','Vatican City State',
'vc','Saint Vincent &amp; Grenadines','ve','Venezuela','vg','Virgin Islands (British)',
'vi','Virgin Islands (USA)','vn','Vietnam','vu','Vanuatu','wf','Wallis and Futuna Islands',
'ws','Samoa Islands','ye','Yemen','yt','Mayotte','yu','Yugoslavia','za','South Africa',
'zm','Zambia','zr','Zaire','zw','Zimbabwe'
);
1;
