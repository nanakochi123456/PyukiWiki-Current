PyukiWiki - 自由にページを追加・削除・編集できるWebページ構築CGI

        "PyukiWiki" ver 0.2.1-customoer-preview $$
        Copyright (C) 2005-2015 PukiWiki Developers Team
        Copyright (C) 2004-2015 Nekyo (Based on PukiWiki, YukiWiki)
        License: GPL version 3 or (at your option) any later version
        and/or Artistic version 1 or later version.
        Based on YukiWiki http://www.hyuki.com/yukiwiki/
        and PukiWiki http://pukiwiki.sfjp.jp/
        URL:
        http://pyukiwiki.info/

        MAIL:
        <nanami (at) daiba (dot) cx> (注：バーチャル女の子です)

        $Id$
        This text file written UTF-8 Codeset

目次

 ・ PyukiWiki - 自由にページを追加・削除・編集できるWebページ構築CGI
     □ 目次
     □ 最新情報
     □ 概要
     □ ライセンス
     □ 寄付のお願い
     □ 動作環境
     □ パッケージについて
     □ はじめに
         ☆ index.cgiの一行目をあなたのサーバに合わせて修正します。
         ☆ pyukiwiki.ini.cgi の変数の値を修正します。
         ☆ 「ファイル一覧」にあるファイルをサーバに転送します。
         ☆ ブラウザでサーバ上の index.cgiのURLにアクセスします。
     □ ファイル一覧
         ☆ 説明文
         ☆ CGI群
         ☆ 参照ファイル
         ☆ 外部公開ファイルファイル
         ☆ パーミッション設定のTIPS
         ☆ パーミッション設定のTIPS
     □ CSSを編集したければ？
     □ JavaScriptを編集したければ？
     □ もし動かなければ？
         ☆ パーミッションが正しいかどうか確認して下さい。
         ☆ それでもだめなら.htaccessをまず削除してみて下さい。
         ☆ Apache 2.4を利用されている場合
         ☆ 一部のプロバイダーでは、設定に工夫が必要です。
         ☆ CGI.pmが導入されてないサーバーでは
         ☆ UTF8にしたら文字化けする？PukiWiki宛てのInterWikiが正常ではない？
         ☆ 一部の無料サーバーにおきまして
         ☆ 管理者ページに入れなくなった。凍結できなくなった。
     □ アップデート版においての追記
     □ データベースエンジンを利用する場合
         ☆ SQLiteの使用方法
         ☆ GDBMの使用方法（評価版）
     □ 簡単なFAQ
     □ PukiWikiからの移行について
         ☆ PukiWikiとPyukiWikiの違いは？
         ☆ PukiWikiのプラグインは動作するの？
         ☆ PukiWikiより劣っているのは
         ☆ PukiWikiより優れているのは
         ☆ PukiWikiから移行するには？
     □ 主な更新履歴
         ☆ 0.2.1-beta12での変更
         ☆ 0.2.1-beta11での変更
         ☆ 0.2.1-beta10での変更
         ☆ 0.2.1-beta9での変更
         ☆ 0.2.1-beta8での変更点
         ☆ 0.2.1-beta7での変更点
         ☆ 0.2.1-customoer-previewでの変更点
         ☆ 0.2.1-beta6での変更点
         ☆ 0.2.1-beta5での変更点
         ☆ 0.2.1-beta4での変更点
         ☆ 0.2.1-beta5で動かない、またはおかしい既知機能
         ☆ 0.2.1-beta2からの変更点
     □ TODO
         ☆ 0.2.0-p3からの主な変更点
         ☆ 0.2.0-p2からの主な変更点
         ☆ 0.2.0-p1からの主な変更点
         ☆ 0.2.0からの主な変更点
         ☆ 0.1.9からの主な変更点
         ☆ 0.1.8からの主な変更点
         ☆ 0.1.7からの主な変更点
         ☆ 0.1.5からの主な変更点
         ☆ ライブラリ
     □ 使用しているライブラリ等
         ☆ perl
         ☆ JavaScript
     □ スパム禁止ワード
     □ 使用している画像
     □ 謝辞
     □ 作者

最新情報

以下のURLで最新情報を入手してください。
http://pyukiwiki.info/

概要

PyukiWiki（ぴゅきうぃき）はハイパーテキストを素早く容易に追加・編集・削除できる
Webアプリケーション(WikiWikiWeb)です。テキストデータからHTMLを生成することがで
き、Webブラウザーから何度でも修正することができます。

PyukiWikiはperl言語で書かれたスクリプトなので、多くのCGI動作可能なWebサーバー（
無料含む）に容易に設置でき、軽快に動作します。

なお、更に軽快に動作をさせたいのであれば、かなり最適化されたNekyo氏のバージョン
をご利用下さい。

http://sfjp.jp/projects/pyukiwiki/releases/?package_id=4436

ライセンス

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

このプログラムはフリーソフトウェアです。それを再配布し、かつ、またはPerl自体と
同じ条件の下でそれを修正することができます。

PyukiWikiは、GPL3もしくはArtisticライセンスの元で配布されます。自由に利用し、自
由に配布し、自由に改造し、それを再配布して構いません。

ただし、原版と同名のパッケージとして名乗ることを禁止します。詳しくは、下記のURL
，または、インストール済のPyukiWikiのwiki文からご確認下さい。

（原版と異なれば、PyukiWiki TurboR 等のような原版の名称を含む命名であれば構いま
せん）

同梱しているライブラリには、一部MITライセンスの物が含まれますがこちらは適用しま
せん。

 ・ PyukiWiki:ライセンスについて
    http://pyukiwiki.info/PyukiWiki/Install/License/
 ・ GNU GPL
    http://www.gnu.org/licenses/gpl.html
 ・ GNU GPLの日本語版
    http://sfjp.jp/magazine/07/09/02/130237
 ・ GPL3情報ページ
    http://sfjp.jp/projects/opensource/wiki/GPLv3_Info
 ・ 参考　GPL2（[旧バージョン）
    http://www.opensource.jp/gpl/gpl.ja.html
 ・ The Artistic License 1.0
    http://dev.perl.org/licenses/artistic.html
 ・ The Artistic License 日本語訳
    http://www.opensource.jp/artistic/ja/Artistic-ja.html
 ・ 参考　Perl6's License Should be (GPL Artistic-2.0)
    http://dev.perl.org/perl6/rfc/346.html

寄付のお願い

開発環境強化、継続的な開発の為に、寄付をお願いしています。
vector シェアレジ、銀行振り込みに対応しています。

Paypal
    http://pyukiwiki.info/Paypal/

Vector シェアレジ (1,155円)
    http://www.vector.co.jp/soft/unix/net/se496490.html

Vector シェアレジ (3,255円)
    http://www.vector.co.jp/soft/unix/net/se496491.html

銀行振り込み、その他
    銀行振り込み等は以下のお振込に対応しています。
    住信SBIネット銀行　ミカン支店　普通　2786854
    三菱東京UFJ銀行　大久保支店　普通　3980703
    三井住友銀行　柏支店　普通　7638195
    りそな銀行　北小金支店　普通　1167353
    楽天銀行　メルマネ (<papu (at) users (dot) sourceforge (dot) jp> または <o
    (at) daiba (dot) cx>) ゆうちょ銀行　10540-54047051

寄付をしたくないが、安いものを買い物したい
    [激安問屋！かいもの.jp] http://shop.daiba.cx/

真似をして、VPSを使ってみたい
    [VPS比較] http://vpsinfo.jp/

-パソコンのパーツを買いたい
    [自作PC最新情報] http://jisaku-pc.info/

vectorのPCソフトのダウンロード
    [サテライトサイトですみません http://down.jp.net/]

VPS、または専用サーバーの導入相談を受け付けています
    [VPSサーバー・専用サーバーの導入相談（個人向け）] http://www.abilie.com/
    tickets/1585

ネタかもしれませんが、これでもセキュリティーを守れます。
    [できる限りタダでインターネットを安全に] （初心者〜中級者向けオンラインPDF
    書籍） http://www.abilie.com/tickets/1595

バナー＆テキスト広告をもっとクリックして！
    こちらのチケットより、同様に作成された ad プラグインの拡張部分がダウンロー
    ド可能です。
    http://www.abilie.com/tickets/2050

CGIスクリプトをインストールします。
    http://www.abilie.com/tickets/8828

誰でも必ずあり得る！介護を受けずに一人で車いすを活用する方法完全版
    http://www.abilie.com/tickets/8827

amazonから寄付をする
    http://www.amazon.co.jp/registry/wishlist/1HJXA69R6EYZZ

有料着メロのダウンロード
    １曲ダウンロードに付、１円相当　大した曲はありませんが
    http://j-ken.com/creator/4730/

その他、寄付に関しまして
    寄付に関してのURLは、以下となります。
    http://www.daiba.cx/
    %3a%e5%af%84%e4%bb%98%e3%81%8a%e6%8c%af%e8%be%bc%e5%85%88/

動作環境

PyukiWikiの動作環境は以下のとおりです。

 ・ サーバー
    LinuxまたはFreeBSD、Solaris等 *NIX環境、MacOS X (未検証)、Windows （一部制
    限があります）

 ・ CGIの動作し、Perl5.8.1（なるだけ）以降が動作するWebサーバー
    Apache等Webサーバー、perlも存在するLAMP等環境
    なお、Perl 5.6以前に関しては現バージョンでは未サポートです。
    最新のPerl5.10系及び5.12系、5.14系、5.16系でも動作確認済みです。
 ・ インストール容量
    full版はインストール時に3Mバイト、compact版はインストール時に2Mバイト必要で
    す。
 ・ 必要なモジュール
    最低でも、CGI.pmがサーバーサイドでインストールされている必要がありますが、
    ユーザーサイドでも導入可能です。
 ・ compact版の必須条件
    Jcode.pm、Time::Localがインストールされている必要があります。
 ・ あると良いかもしれないperlモジュール
    --GD
     □ SORP::Lite
     □ Digest::MD5
     □ MeCabまたはText::MeCab
     □ Compress::Zlib
 ・ あると良いかもしれないプログラム
    --sendmail
     □ gzipまたはpigz

パッケージについて

 ・ -full
    通常はこちらをインストールします。
 ・ -compact
    サーバーの容量が少ない場合、こちらを導入してみて下さい。

    以下の制限があります。
     □ あいまい検索,sitemap,showrss,bugtrack,perlpod,settingがない
     □ 管理プラグイン(listfrozen,server,servererror,versionlist)がない
     □ PukiWiki互換ダミープラグインがない
     □ Explugin lang, setting, urlhack, punyurl等多数ない
     □ 添付ファイルは一部の圧縮ファイル、画像以外できません。
     □ 英語関係ファイルがない
     □ バックアップができない
     □ Jcode.pm、Time::Localがサーバーにインストールされている必要がある
     □ その他、多くの制限事項がある
 ・ -update-full, -update-compact
    アップデート用のファイルです。
    初期wiki、及び .htaccess ファイルがありません。
    - -devel
    PyukiWikiプラグイン、及びコア開発に必要なツールが揃っています。ドキュメント
    のpodが付属しています。
    インストール時に約7Mバイトを使用します。
 ・ ???-utf8
    UTF8版です。他のコードセットは使用できません。
    また、UTF8版ではないバージョンとは互換性がありません。
    ただし、従来のwikiページを移行する為の管理者向けプラグイン　convertutf8 が
    全バージョンに付属しています。

はじめに

index.cgiの一行目をあなたのサーバに合わせて修正します。

　

#!/usr/local/bin/perl
#!/usr/bin/perl
#!/opt/bin/perl
等

　

Windows サーバーでは、
#!c:/perl/bin/perl.exe
#!c:=Y=perl=Y=bin=Y=perl.exe
#!c:=Y=perl64=Y=bin=Y=perl.exe
を設定しても良いでしょう。

pyukiwiki.ini.cgi の変数の値を修正します。

「ファイル一覧」にあるファイルをサーバに転送します。

転送モードやパーミッションを適切に設定します。

通常は、お使いのFTPソフトの自動認識で構いませんので、index.cgi だけパーミッショ
ンを設定すれば、すぐに動作可能な場合もあります。

ブラウザでサーバ上の index.cgiのURLにアクセスします。

アクセスをしたら、AdminPage (?cmd=admin) へ行き、すぐに、管理者パスワードを変更
して下さい。

ファイル一覧

ここでのファイル一覧は、最新の一覧が反映されていない可能性があります

説明文

以下のファイルは、Webサーバに転送する必要はありません。

+-- README.txt                  解説文書（このファイル）
+-- COPYRIGHT.txt               GNU GENERAL PUBLIC LICENSE(原文）
+-- COPYRIGHT.ja.txt    GNU GENERAL PUBLIC LICENSE(日本語訳）

CGI群

以下のファイルはCGIが実行できるディレクトリにFTPします。

* と記載されているファイルは、コンパクト版にはありません。

                       転送モード パーミッション   説明
+-- index.cgi               TEXT  755 (rwxr-xr-x)  CGIwrapper
+-- pyukiwiki.ini.cgi       TEXT  644 (rw-r--r--)  定義ファイル
+-- lib                           755 (rwxr-xr-x)  使用モジュール群
    +-- wiki.cgi            TEXT  644 (rw-r--r--)  CGI本体
    +-- aguse.inc.pl*       TEXT  644 (rw-r--r--)  Exプラグイン
    +-- antispam.inc.pl     TEXT  644 (rw-r--r--)  Exプラグイン
    +-- antispamwiki.inc..  TEXT  644 (rw-r--r--)  Exプラグイン
    +-- authadmin_..inc.pl  TEXT  644 (rw-r--r--)  Exプラグイン
    +-- autometa....inc.pl  TEXT  644 (rw-r--r--)  Exプラグイン
    +-- google_an...inc.pl* TEXT  644 (rw-r--r--)  Exプラグイン
    +-- iecompati...inc.pl  TEXT  644 (rw-r--r--)  Exプラグイン
    +-- lang.inc.pl*        TEXT  644 (rw-r--r--)  Exプラグイン
    +-- linktrack.inc.pl*   TEXT  644 (rw-r--r--)  Exプラグイン
    +-- logs.inc.pl*        TEXT  644 (rw-r--r--)  Exプラグイン
    +-- punyurl.inc.pl*     TEXT  644 (rw-r--r--)  Exプラグイン
    +-- setting.inc.pl*     TEXT  644 (rw-r--r--)  Exプラグイン
    +-- slashpage.inc.pl*   TEXT  644 (rw-r--r--)  Exプラグイン
    +-- urlhack.inc.pl*     TEXT  644 (rw-r--r--)  Exプラグイン
    +-- Algorithm                 755 (rwxr-xr-x)  ディレクトリ
    |   +-- Diff.pm         TEXT  644 (rw-r--r--)  差分用
    |   AWS *                     755 (rwxr-xr-x)  ディレクトリ
    |   |-- browsers.pm*    TEXT  644 (rw-r--r--)  アクセス解析定義ファイル
    |   |-- domains.pm*     TEXT  644 (rw-r--r--)  （リリース版のみ）
    |   |-- operating_...*  TEXT  644 (rw-r--r--)
    |   |-- robots.pm*      TEXT  644 (rw-r--r--)
    |   +-- search_eng...*  TEXT  644 (rw-r--r--)
    +-- Digest*                   755 (rwxr-xr-x)  ディレクトリ
    |   +-- Perl*                 755 (rwxr-xr-x)  ディレクトリ
    |       +-- MD5.pm*     TEXT  644 (rw-r--r--)  md5 計算用
    +-- File                      755 (rwxr-xr-x)  ディレクトリ
    |   |-- MMagic.pm       TEXT  644 (rw-r--r--)  ファイル種別監査用
    |   |-- magic.txt*      TEXT  644 (rw-r--r--)  Magicファイル（リリース版のみ）
    |   +-- magic_compa..**TEXT  644 (rw-r--r--)  Magicファイル（コンパクト版のみ）
    +-- HTTP                      755 (rwxr-wr-x)  ディレクトリ
    |   +-- Lite.pm         TEXT  644 (rw-r--r--)  HTTPクライアント
    +-- IDNA*                     755 (rwxr-wr-x)  ディレクトリ
    |   +-- Punycode.pm*    TEXT  644 (rw-r--r--)  recent.inc.plで使用
    +-- Jcode*                    755 (rwxr-wr-x)  ディレクトリ
    |   +-- Unicode*              755 (rwxr-wr-x)  ディレクトリ
    |   |   +-- Contants.pm*TEXT  644 (rw-r--r--)  Jcode.pm で使用
    |   |   +-- NoXS.pm*    TEXT  644 (rw-r--r--)  Jcode.pm で使用
    |   |-- _Classic.pm*    TEXT  644 (rw-r--r--)  Jcode.pm で使用
    |   |-- Contants.pm*    TEXT  644 (rw-r--r--)  Jcode.pm で使用
    |   |-- H2Z.pm*         TEXT  644 (rw-r--r--)  Jcode.pm で使用
    |   |-- Tr.pm*          TEXT  644 (rw-r--r--)  Jcode.pm で使用
    |   +-- Unicode.pm*     TEXT  644 (rw-r--r--)  Jcode.pm で使用
    +-- Nana                      755 (rwxr-xr-x)  ディレクトリ
    |   |-- Cache.pm        TEXT  644 (rw-r--r--)  キャッシュモジュール
    |   |-- Carp.pm         TEXT  644 (rw-r--r--)  エラーキャプチャーモジュール
    |   |-- Code.pm         TEXT  644 (rw-r--r--)  コード変換
    |   |-- Cookie.pm       TEXT  644 (rw-r--r--)  HTTPクッキー
    |   |-- Crypt.pm        TEXT  644 (rw-r--r--)  ハッシュ暗号化モジュール (wrapper)
    |   |-- Date.pm         TEXT  644 (rw-r--r--)  日付モジュール
    |   |-- Enc.pm          TEXT  644 (rw-r--r--)  暗号化モジュール
    |   |-- File.pm         TEXT  644 (rw-r--r--)  ファイルアクセスモジュール
    |   |-- GDBM.pm*        TEXT  644 (rw-r--r--)  GDBMモジュール
    |   |-- GZIP.pm*        TEXT  644 (rw-r--r--)  gzip圧縮モジュール
    |   |-- HTTP.pm         TEXT  644 (rw-r--r--)  HTTPクライアント
    |   |-- ImageSize.pm    TEXT  644 (rw-r--r--)  画像サイズモジュール
    |   |-- Kana.pm         TEXT  644 (rw-r--r--)  かな変換モジュール
    |   |-- Lock.pm         TEXT  644 (rw-r--r--)  ファイルロック用
    |   |-- Logs.pm*        TEXT  644 (rw-r--r--)  アクセスログ解析用
    |   |-- Mail.pm         TEXT  644 (rw-r--r--)  メール送信用
    |   |-- MD5.pm          TEXT  644 (rw-r--r--)  MD5 wrapper
    |   |-- OPML.pm         TEXT  644 (rw-r--r--)  OPML
    |   |-- Pod2Wiki.pm*    TEXT  644 (rw-r--r--)  pod?wiki変換モジュール
    |   |-- RemoteHost.pm*  TEXT  644 (rw-r--r--)  リモートホスト
    |   |-- RSS.pm          TEXT  644 (rw-r--r--)  RSS1.0/2.0、ATOM
    |   |-- Search.pm*      TEXT  644 (rw-r--r--)  あいまい検索用
    |   |-- Sitemaps.pm*    TEXT  644 (rw-r--r--)  SEO対策向けsitemaps
    |   |-- SQLite.pm*      TEXT  644 (rw-r--r--)  SQLiteモジュール
    |   |-- Temp.pm         TEXT  644 (rw-r--r--)  テンポラリモジュール
    |   |-- YukiWikiDB.pm   TEXT  644 (rw-r--r--)  YukiWikiDB
    |   +-- YukiWikiDB_G..* TEXT  644 (rw-r--r--)  gzip圧縮版YukiWikiDB
    +-- Time                      755 (rwxr-wr-x)  ディレクトリ
    |   +-- Local.pm        TEXT  644 (rw-r--r--)  recent.inc.plで使用
    +-- Yuki                      755 (rwxr-xr-x)  ディレクトリ
        |-- DiffText.pm     TEXT  644 (rw-r--r--)  差分用
        |-- RSS.pm          TEXT  644 (rw-r--r--)  RSS用
        +-- YukiWikiDB.pm   TEXT  644 (rw-r--r--)  オリジナルのYukiWikiDB

参照ファイル

以下のファイルは、pyukiwiki.ini.cgi 内の変数 $::data_homeで指定するディレクトリ
に転送します。

詳しくは pyukiwiki.ini.cgi を参照して下さい。

+-- backup                        777 (rwxrwxrwx)  バックアップ保存用ディレクトリ
|   +-- index.html          TEXT  755 (rwxr-xr-x)  一覧表示防止用
+-- counter                       777 (rwxrwxrwx)  カウンタ値保存用ディレクトリ
|   +-- index.html          TEXT  755 (rwxr-xr-x)  一覧表示防止用
+-- diff                          777 (rwxrwxrwx)  差分保存用ディレクトリ
|   +-- index.html          TEXT  755 (rwxr-xr-x)  一覧表示防止用
+-- info                          777 (rwxrwxrwx)  情報保存用ディレクトリ
|   +-- index.html          TEXT  755 (rwxr-xr-x)  一覧表示防止用
+-- plugin                        777 (rwxrwxrwx)  プラグイン用ディレクトリ
|   +-- index.html          TEXT  755 (rwxr-xr-x)  一覧表示防止用
+-- resource                      755 (rwxr-xr-x)  リソース用ディレクトリ
|   +-- index.html          TEXT  755 (rwxr-xr-x)  一覧表示防止用
|   +-- すべてのファイル    TEXT  644 (rw-r--r--)  リソースファイル
|   +-- conflict.ja.txt     TEXT  644 (rw-r--r--)  更新の衝突時のテキスト
+-- wiki                          777 (rwxrwxrwx)  ページデータ保存用ディレクトリ
    +-- index.html          TEXT  755 (rwxr-xr-x)  一覧表示防止用

?バックアップ保持用ディレクトリは compactバージョンにはありません。

外部公開ファイルファイル

以下のファイルは、pyukiwiki.ini.cgi 内の変数 $::data_pubで指定するディレクトリ
に転送します。

詳しくは pyukiwiki.ini.cgi を参照して下さい。

                       転送モード パーミッション   説明
+-- attach                        777 (rwxrwxrwx)  添付保存用ディレクトリ
|   +-- index.html          TEXT  755 (rwxr-xr-x)  一覧表示防止用
+-- cache                         777 (rwxrwxrwx)  一時ディレクトリ
|   +-- index.html          TEXT  755 (rwxr-xr-x)  一覧表示防止用
+-- image                         755 (rwxr-xr-x)  画像保存用ディレクトリ
|   +-- index.html          TEXT  755 (rwxr-xr-x)  一覧表示防止用
+-- skin                          755 (rwxr-xr-x)  スキン用ディレクトリ
    +-- pyukiwiki.skin.ja.cgi     644 (rw-r--r--)  スキンファイル
    +-- default.ja.css            644 (rw-r--r--)  表示用 css
    +-- print.ja.css              644 (rw-r--r--)  印刷用 css
    +-- blosxom.css               644 (rw-r--r--)  blosxom 用 css
    +-- instag.js                 644 (rw-r--r--)  拡張編集用 JavaScript
    +-- common.ja.js              644 (rw-r--r--)  共通使用JavaScript
    +-- index.html                644 (rw-r--r--)  一覧表示防止用

パーミッション設定のTIPS

一部ユーザー権限で動作するWebサーバーの場合、「とりあえず」index.cgiのパーミッ
ションを 701 (rwx-----x) にすることで動作します。

その他、セキュリティーを強化したい場合は、各ディレクトリを以下のように設定しま
す。

+-- attach                        701 (rwx-----x)  添付保存用ディレクトリ
+-- backup                        700 (rwx------)  バックアップ保存用ディレクトリ
+-- cache                         701 (rwx-----x)  一時ディレクトリ
+-- counter                       700 (rwx------)  カウンタ値保存用ディレクトリ
+-- diff                          700 (rwx------)  差分保存用ディレクトリ
+-- image                         701 (rwx-----x)  画像保存用ディレクトリ
+-- info                          700 (rwx------)  情報保存用ディレクトリ
+-- lib                           700 (rwx------)  使用モジュール群
+-- plugin                        700 (rwx------)  プラグイン用ディレクトリ
+-- resource                      700 (rwx------)  リソース用ディレクトリ
+-- skin                          701 (rwx-----x)  スキン用ディレクトリ
+-- wiki                          700 (rwx------)  ページデータ保存用ディレクトリ

パーミッション設定のTIPS

一部ユーザー権限で動作するWebサーバーの場合、「とりあえず」index.cgiのパーミッ
ションを 701 (rwx-----x) にすることで動作します。

その他、セキュリティーを強化したい場合は、各ディレクトリを以下のように設定しま
す。

+-- attach                        701 (rwx-----x)  添付保存用ディレクトリ
+-- backup                        700 (rwx------)  バックアップ保存用ディレクトリ
+-- cache                         701 (rwx-----x)  一時ディレクトリ
+-- counter                       700 (rwx------)  カウンタ値保存用ディレクトリ
+-- diff                          700 (rwx------)  差分保存用ディレクトリ
+-- image                         701 (rwx-----x)  画像保存用ディレクトリ
+-- info                          700 (rwx------)  情報保存用ディレクトリ
+-- lib                           700 (rwx------)  使用モジュール群
+-- plugin                        700 (rwx------)  プラグイン用ディレクトリ
+-- resource                      700 (rwx------)  リソース用ディレクトリ
+-- skin                          701 (rwx-----x)  スキン用ディレクトリ
+-- wiki                          700 (rwx------)  ページデータ保存用ディレクトリ

CSSを編集したければ？

CSSはyuicompressorで圧縮されています。その為、編集しずらいと思いますので、　編
集をするのであれば、*.css.orgを参照して下さい。

再圧縮するには、こちら（英語）をご覧下さい。

http://developer.yahoo.com/yui/compressor/

JavaScriptを編集したければ？

JavaScriptは、yuicompressor、または、Packer Javascript で圧縮されています。

その為、編集しずらいと思いますので、-devel 版をダウンロードの上 *.js.srcを参照
して下さい。

再圧縮に関しましては、DEVEL版の説明書をご覧下さい。

もし動かなければ？

パーミッションが正しいかどうか確認して下さい。

サーバー提供会社、プロバイダ奨励のパーミッションをなるだけ優先して下さい。

それでもだめなら.htaccessをまず削除してみて下さい。

特に、attach/.htaccess, image/.htaccess, skin/.htaccessの削除を忘れないで下さい
。

Apache 2.4を利用されている場合

ErrorDocumentを設定されている場合、不要な設定が存在するサンプルを配布していた為
、有効にすると 500 Server Error となります。 ErrorDocumentの419番以降、及び、
509番を削除して下さい。

一部のプロバイダーでは、設定に工夫が必要です。

もしかしたら、OSがWindows系の場合がありますので、適切な設定をして下さい。

CGI.pmが導入されてないサーバーでは

CGI.pmが導入されていないサーバーでは、別途配布されているCGI.pm.zipを解凍して、
lib 以下に置いて下さい。

http://pyukiwiki.info/PyukiWiki/Download からダウンロードできます。

UTF8にしたら文字化けする？PukiWiki宛てのInterWikiが正常ではない？

perl5.8.0以前のバージョンでかつサーバー上にJcodeがインストールされていません。

代替のJcode.pm 0.88をインストールして下さい。

@@BASEURL/PyukiWiki/Download からダウンロードできます。

一部の無料サーバーにおきまして

一部の無料サーバーでは、EUC版、UTF8版、もしくは双方とも文字化けする可能性があり
ます。サーバーに仕様とも考えられますので、新たに別の無料サーバーをご利用される
ことをお勧めします。

管理者ページに入れなくなった。凍結できなくなった。

パスワードを、以下の方法で初期化できます。

info/setup.ini.cgi をダウンロードします。

末尾に、以下を追加します。

$::adminpass = crypt("pass", "AA");
1;

アップロードします。

info/setup.ini.cgi が存在しなければ、新規作成をして、そのままアップロードして下
さい。

アップデート版においての追記

アップデート版でも、ルートフォルダ（ディレクトリの）「pyukiwiki.ini.cgi」が上書
きされるため、アップデート前に必ずリネームして下さい。

また、こちらがお勧めですが、info/setup.ini.cgi にpyukiwiki.ini.cgi の変更部分を
記述すれば、スムーズにアップデートできるかと思います。

?cmd=setupeditorからも、編集することができます。

データベースエンジンを利用する場合

PyukiWiki 0.2.1より、SQLite、及び GDBMに（仮）正式対応をしました。

正しくSQLiteが導入されている環境において、動作を致しますが、現状では全ての動作
確認を行なえていません。

SQLiteの使用方法

正しく動作するSQLiteを準備します。
現状の実装では、SQLite 3 より動作が確認されています。

全てのwikiページを手動でバックアップを取得してから、info/setup.ini.cgiに

$::modifier_dbtype = 'Nana::SQLite';

を記述して下さい。

その後、何もないwikiページになりますので、手動でバックアップをしたページを復元
して下さい。

特にテーブルを新規作成をする必要はありません。自動的に作成されます。

内部でテーブルを自動生成しているSQLは以下の通りです。

create table $self->{name} (
name blob not null unique,
$self->{ext} blob,
createtime integer not null,
updatetime integer not null
);

$self->{name} は、ディレクトリ名と同一です。
$self->{ext} は通常 txt になります。
レコード名、データは、16進数文字列に変換して格納されます。

GDBMの使用方法（評価版）

正しく動作するGDBMを準備します。

全てのwikiページを手動でバックアップを取得してから、info/setup.ini.cgiに

$::modifier_dbtype = 'Nana::GDBM';

を記述して下さい。

その後、何もないwikiページになりますので、手動でバックアップをしたページを復元
して下さい。

GDBMでは、少しでも負荷がかかると、ページが空白になる現象が確認されています。

簡単なFAQ

PyukiWikiの作者が変ったのですか？
    ??いいえ、変ったのではなく追加です。
    現状におきましては、原作者のNekyo氏は、PyukiWikiとしては残念ながら音信普通
    となり、開発を停止しています。
PyukiWikiの動作が重いのですが
    compact版にすると多少は軽くなりますが、更に軽くする場合、Nekyo氏のオリジナ
    ル版をご利用になるとよいでしょう。ただし、多くの機能が制限されます。

    最新バグFix対応版は、こちらから
    http://sfjp.jp/projects/pyukiwiki/releases/?package_id=4436
既存のプラグインが動かなくなってしまったのですが？
    可能な限り、過去バージョン向けのプラグインを動作できるよう変更はしています
    が、実質、0.1.6にて大幅に仕様が変更になり動作しなくなったものもあります。
    (popular, rename等は、既存バージョン用のプラグインが「まともに」（＝ちょっ
    としたことでも）動作しないので、新しいバージョンを添付しています）
バージョンアップが激しい？
    個人的に、あくまでも、「自分の為に」更新をしている為に、特に内部的なバージ
    ョンアップが激しい場合があります。
    １日に１０回や２０回も更新していることもありますが、そのほとんどがいたって
    普通の転送であったりすることもあります。
インストールしてみて、動かない？
    正常にパーミッション設定、及び、ファイルの適切な編集が完了したにも関わらず
    、動作しない場合は、gzip圧縮を無効にしてみて下さい。 pyukiwiki.ini.cgi で

$::gzip_path = 'nouse';
を設定するか、
info/setup.cgi で（こちらが奨励）
$::gzip_path = 'nouse';
を設定してみて下さい。

mod_perl、speedy_cgiで動かないのですが？
    mod_perlには対応確認済みです。speedy_cgiは未確認です。
    ただし、現状では、動作しなかったものを動作させるようにしただけのものであり
    、高速化の恩恵は現状では受けていません。
wiki.cgiが醜い(本来の変換は見にくい）のですが・・・
    full版、compact版は、実際に動作する環境の為に、余計なコメント等を大幅に削除
    しています。
    また、過去にベンチマークを取得して、ある程度サブルーチンの順番も考慮してい
    ます。
    wiki.cgiのサブルーチンのコメントが必要な方は、-devel版をダウンロードして下
    さい。
    同一のバージョンであれば、-full版と-devel版であれば、混在しても動作します。
ライセンスがかわったのですか？
    「you can redistribute it and/or modify it under the same terms as Perl
    itself.」
    「＝Perlと同じライセンスで再配布できます。」
    の文面を明確にすると、GPL3とArtisticライセンスが適用されることになります。

    SourceForge.jpプロジェクト登録のため、ライセンスをはっきりさせるために明記
    したのであり、基本的にはYukiWikiからのライセンスを継承しているものと考えて
    います。
PyukiWiki0.1.5のwikiをそのまま移行すると文面がおかしくなるのですが？
    多くのPukiWiki文法を取り入れると同時に、多くの文法不具合も修正されています
    。
    仕様外の文法で記述されている場合、不具合が生じることがあります。
    また、インラインプラグイン(&amp;plugin(...);)において、「;」で終了していな
    いと、不具合が起きます。ネスト可能にする為に厳格に文法チェックを行なってい
    ますので、閉じていない場合は、「；」で閉じるようにして下さい。
プラグインを作成してみたい？
    sample/ ディレクトリの、stationary.inc.pl、及び、stationary_explugin.inc.pl
    を参考にして下さい。
    ExPluginは、本来プログラミングではあってはならない、関数の重複を逆に利用し
    て実現している機能ですので、重複させる関数を設定する時には、十分注意して下
    さい。

PukiWikiからの移行について

PyukiWikiは、PukiWikiの代替になるものではありませんが、多くの互換性を持ったもの
であります。

現状におきまして、PukiWikiが php 5.4 になって動作しなくなったことにより、移行を
されている方が見られますが、あくまで、ほとんどが代替になるだけであって、完全に
動作保障をすることができません。

PukiWikiとPyukiWikiの違いは？

全く違う言語、及びエンジンで、似たようなものを表示させようとしていることが、根
本的に異なります。

PukiWikiのプラグインは動作するの？

php言語でできている為、動作しません。ただし、移植をすれば、動作するかもしれませ
ん。

PukiWikiより劣っているのは

 ・ wiki文が完全互換になっていない
 ・ （現状において）HTML Validではない（ただし、XHTMLヘッダで動作はします）
 ・ （現状において）重い
 ・ 気が向いたら開発であること。

PukiWikiより優れているのは

 ・ wikiエンジン全体に対するプラグインシステム Expluginが搭載されている。その為
    、PukiWikiよりも拡張性が高い
 ・ 現状で、作者が、気になったら or 気が向いたら、すぐにプラグインを作り始める
    。
 ・ まだ完成してはいないものの、CMSツールとして、使いやすさを重点に開発している
    。
 ・ その他、tdiary スキンも代用できます。（ただし、現状未公開）

PukiWikiから移行するには？

 ・ 一度サイトをメンテナンス等で閉鎖を行なった後に、新しい場所に一度PyukiWikiを
    インストールを行ないます。
 ・ その後、wiki ディレクトリのみ PukiWikiからPyukiWiki にコピーすることで、多
    くの場合最も移行が成功しやすい状態となります。
 ・ 文法上のある程度の互換性がある程度のみですので、PukiWiki独自文法やPukiWiki
    Plus!独自文法（言語拡張も含む）を利用されている場合は、反映されませんので、
    手動で書き換える必要があります。
 ・ EUCからUTF-8へ変換を行なう場合、convertutf8ツールが一応付属していますが、あ
    てにならないツールとお考え下さい。最も確実なのは、それぞれのページをコピー
    ＆ペーストすることです。
 ・ wiki ディレクトリ以外のアクセスカウンター、バックアップ、差分や、スキン等は
    （ファイルの種類が見た目同じでも）互換性がないとお考え下さい。

主な更新履歴

0.2.1-beta12での変更

IE11に仮対応

0.2.1-beta11での変更

 ・ Plugin
     □ attachプラグインの改修
     □ ls2プラグインの改修

0.2.1-beta10での変更

 ・ 全体
     □ <form タグを生成する makeform 関数の新設
 ・ Plugin
     □ attachプラグインの大幅改修

0.2.1-beta9での変更

 ・ 全体
     □ アクセスカウンターをモジュール化した
     □ expluginを導入していない場合の、$::FrontPageのリンク先を変更した。
 ・ pyukiwiki.ini.cgi
     □ デフォルトのパスワードが通らないのを修正した

 ・ Plugin
     □ attach.inc.pl 検索エンジンがクロールした時、添付ファイルの詳細のMD5を毎
        回計算することにより、サーバーが過剰に重くなるのを解消
     □ counter.inc.pl をモジュール化
     □ download.inc.pl 新規作成

0.2.1-beta8での変更点

 ・ 全体
     □ JavaScriptをページ表示高速化のためにページ最後に読み込みできるようにし
        た（デフォルト）
     □ 同上の理由で、スキンの仕様変更

 ・ Plugin
     □ twitter.inc.pl Twitter API1.1に対応

0.2.1-beta7での変更点

 ・ 全体
     □ JavaScriptローダーを非同期タイプに変更した
     □ JavaScriptローダーに伴う、内部変更
 ・ ExPlugin
     □ antispam.inc.pl グローバル変数で直接やりとりするのを終了した。

0.2.1-customoer-previewでの変更点

 ・ 全体
     □ スキンファイルが正常に読み込みできない時にPyukiWikiが暴走するのを修正し
        た。
     □ 初期wiki文面を削除を行ない、代わりにrecovery.inc.plを起動するようにした
        。
 ・ プラグイン
     □ mailform.inc.pl 送信メールに送信元の情報を付記するよう修正
     □ multimailform.inc.pl 送信メールに送信元の情報を付記するよう修正
     □ multimailform.inc.pl 送信者にも控えを送信できるように修正
     □ recovery.inc.pl 新規作成

0.2.1-beta6での変更点

 ・ 全体
     □ 画像ファイルをまとめて、CSSで表示するようにした。
     □ 日本語のみ =Y= を &yen; に変換表示するようにした。（任意設定可）
 ・ ExPlugin
     □ login.inc.plを追加
 ・ Plugin
     □ login.inc.plを追加
 ・ インストーラ

0.2.1-beta5での変更点

 ・ 全体
     □ 正式に、Internet Explorer 6 のサポートを外した
 ・ ExPlugin
     □ ignoreoldbrowser.inc.plを追加
 ・ Plugin
     □ popup.inc.plを追加

0.2.1-beta4での変更点

 ・ 内部モジュール
     □ 任意でセキュリティー上実行できないプラグインを指定できるようにした。
 ・ ExPlugin
     □ ping.inc.pl - XMLの内容が返ってこないpingのステータスを有効とみなすよう
        に変更した。

0.2.1-beta5で動かない、またはおかしい既知機能

 ・ IE7,8で編集画面のボタンが表示されない
 ・ IEでのみ、編集画面のボタンが遅く表示される（まだ未解消）
 ・ 編集画面から画面遷移した時に、編集をしていないにも関わらず確認画面が出るこ
    とがある。
 ・ フォームバックアップ機能はJavaScript側が変更あるものの、サーバー側での受け
    取り（厳密には、restore機能）がまだありません。

0.2.1-beta2からの変更点

 ・ 内部モジュール
     □ パスワードの内部記録方式を変更した。自動的にSHA512、SHA384、SHA256、
        SHA1、MD5、テキストが利用できます。従来のcryptも設定を行なうことで利用
        可能です。（環境の移行が必要な場合、MD5にして下さい）
     □ GDBMへの仮対応（多分このまま？）
     □ SQLiteへの対応（ほとんど動作しています）
        データベースファイル、またはテーブルが存在しない場合、初回ページを作成
        時に、何度か tie でエラーが出ますが、エラーがなくなるまでリロードを行な
        って下さい。
     □ get_subjectlineをきれいに出力できるように修正した（再修正予定）
     □ メール通知をPGP暗号化に対応した。現在、telnet/ssh シェルの利用できるgpg
        のインストールされたサーバーと、対応メールソフトが必要です。
     □ 変更通知メールのうち、プラグインからの書き込みとメールフォームのメール
        ヘッダーを変更した。
     □ 日付関連のサブルーチンをモジュール化した
     □ 画像サイズ取得のサブルーチンをモジュール化した
     □ ページアンカーの出力方法を変更した
     □ ページフッターのバージョン表記、表示時間の表記を変更した。
     □ 表示時間の計測方法を変更した。動かない場合、index.cgi の use
        Time::HiRes; をコメントして下さい。
     □ 複数行あるリソースファイルを読み込めるようにした。
     □ リンクのフォローを設定できるようにした。hoge または hoge
 ・ 設定ファイル
     □ 書込み禁止キーワードの大幅追加及び別ファイル化。
        書き込み禁止キーワードの為に、書き込めなくなった場合には、info/
        setup_ngwords.ini.cgi を以下のように記載して下さい。

            $::disablewords{ja}="";

            $::disablewords="";

            $::disablewords_frozenwrite{ja}="";

            $::disablewords_frozenwrite="";

 ・ XSモジュール
     □ devel版のみ一部に仮実装をしました。make installxs ですぐに使えます。
 ・ プラグイン
     □ bugtrack.inc.pl 新調（PukiWikiと「ほぼ」同じように動きますが違う実装で
        す）
     □ bugtrack_list.inc.pl 新規追加（PukiWikiと「ほぼ」同じように動きますが違
        う実装です）
     □ links.inc.pl 新規追加
     □ location.inc.plのバグ修正、及び、JavaScriptで遷移するオプション追加
     □ sitemaps.inc.plを正式再追加
     □ skin.inc.pl 新規追加
     □ include.inc.plのオプション追加
     □ rss10.inc.plの廃止（転送を行ないます）
     □ rss.inc.plの追加、及びRSS2.0、ATOMのサポート（及び動作しなかったのを修
        正）
     □ rss10page.inc.plの廃止（転送を行ないます）
     □ rsspage.inc.plの追加、及びRSS2.0、ATOMのサポート（及び動作しなかったの
        を修正）
     □ opml.inc.plの再サポート
     □ twitter.inc.pl - １ページに最大１０個まで表示できるようにした。ただし、
        実用上５つが限界のようです。
     □ smedia.inc.pl - Facebook用掲示板を仮に搭載
     □ showrss.inc.pl - 複数行表示できなかった不具合を解消
     □ stdin.inc.pl / stdin.inc.pl (Explugin) - 作成　（通常は利用しません）
     □ setupeditor.inc.pl - ngwords.ini.cgi追加対応、perl簡易文法チェックを搭
        載

TODO

     □ smedia.inc.pl - 再び全面書き換え
     □ データベース移行ツールの作成
     □ フォームバックアップ機能の受け取り部分の作成
     □ 以前のブラウザーへの再対応の検討及び対応(目安としてIE5.01またはIE6、
        FireFox 3あたりより）
     □ mecabとSQLiteを利用した、ページ検索の高速化

0.2.0-p3からの主な変更点

 ・ JavaScript
     □ 特にJavaScript関係の内部仕様が大きく変更されています。
     □ JavaScriptの圧縮方法の変更（packer解凍ルーチンの高速化）
     □ JavaScriptファイルの日本語テキストの扱いの変更（エンコードしたUTF16に統
        一）
        ＃devel版のみ旧来のファイルを残します
     □ CSS、JavaScriptのgzip圧縮化（スクリプトではなく、.htaccessで処理）
     □ Javascriptのローダー作成
 ・ ドキュメント
     □ ドキュメントをwikiフォーマットに変更し、そこから生成するようにした。
 ・ 本体
     □ wikiモジュールの分割化 captcha、canonical、ogp expluginの追加
     □ HTMLのgzip圧縮を、pigzプログラムも利用できるようにすることで、マルチス
        レッド化できるようにした。
     □ 現在バックアッププラグインのみで使用しているgzip圧縮、解凍を、gzipプロ
        グラム、pigzプログラムも利用できるようにして、軽量化した。
     □ Nana::YukiWikiDBでも、gzip圧縮済の読み込みに対応した。
     □ バージョン番号制の導入
 ・ プラグイン
     □ backline.inc.pl 新規追加
     □ ck.inc.pl Locationではない画面遷移をデフォルトとした
     □ metarobots.inc.pl descriptionの設定をできるようにした。
     □ ls2.inc.pl 多くのオプションを追加
     □ popular.inc.pl ページ数が多いとき、キャッシュの再生成に時間がかかるため
        、マルチタスクで行なうようにした。
     □ tb.inc.pl Linux環境下で動作しない場合があったのを修正した。
     □ linktrack.inc.cgi JavaScriptを使用しない場合に利用できるオプションを追
        加
     □ ogp.inc.cgi バグ修正
     □ editプラグインでtextareaフォーム上でESCキーを押した時の挙動を、IEだけで
        はなく、ほとんどのブラウザーで動作するようにした。
     □ editプラグインにブラウザーのJavaScriptで動作するフォームバックアップ機
        能を搭載
        （ただし、現時点では、サーバー側での受け取り後の処理が出来ていません）
     □ edit_extendの仕様強化（ほとんどをJavaScriptに移動しました）
     □ list.inc.pl ページ数が多くなった時、ページ遷移をできるようにした。
     □ list.inc.plで、mecabがインストールされている時、日本語のひらがなもイン
        デックスできるようにした。
     □ twitter.inc.pl - JavaScriptを強化 ($から始まるハッシュに対応、URLを生
        URLで表示するようにした)
     □ logs.inc.cgi デフォルトで圧縮されるのを解除した。設定を行なうことで圧縮
        されます。
 ・ その他
     □ インストーラCGIの更新
     □ お試し版で、tdiary wrapperを同梱 (devel版のみ)
     □ デバッグ機能の部分強化
     □ debug.inc.cgi シェルから直接デバッグできるようにした
     □ （ビルドツールの変更）
     □ pngファイルを更に無劣化圧縮した
     □ 各作者の不通Webページのリンク削除

?その他、ビルドツールを用いて生成しています為、旧来のEUC版等もサポートをしてい
ますが、チェックが完全にできない為に、何らかの不具合が発生する可能性があります
。ただし、生成元のソースは、EUCコードです。

0.2.0-p2からの主な変更点

 ・ セキュリティーホールFix
 ・ ping Exプラグイン (weblog更新ping)作成（まだテスト版）
 ・ trackback Exプラグイン、tb.inc.pl プラグイン (トラックバック）作成（受信の
    み）
 ・ extend edit の改良（IEでは一応動作しますが、まだ正常に動作しません）
 ・ jquery.jsをcompact版以外同封
 ・ PukiWiki Plusの顔文字を追加
 ・ JavaScriptの圧縮方法の変更
 ・ linktrack.inc.cgiのHTML出力量を削減

0.2.0-p1からの主な変更点

 ・ compact版できちんとビルドできていなかったのを修正
 ・ index.cgi wrapperの変更（重要）
 ・ スキンファイルの存在の確認方法の変更
 ・ JavaScriptの見直し
 ・ CSSの見直し
 ・ 正規表現の見直し
 ・ ページ名/MenuBar 等、階層下専用のMenuBar等を設定できるようにするプラグイン
    pathmenu.inc.cgiを追加
 ・ pyukiwiki.skin.cgiの変更
 ・ sub encodeが規則通り動作していなかったのを修正
 ・ UTF8メールを送信できるようにした。ただし、MIME::Base64が必要
 ・ 検索をすると、検索キーワードをハイライトするように修正
 ・ Nana::Search.pm の追加
 ・ search.inc.pl、search_fuzzy.inc.pl の変更
 ・ title.inc.plの変更
 ・ attach.inc.pl、ref.inc.plの変更 - ファイルサイズ、登録日を読みやすくした。
    また、マウスをリンクに合わせなくても表示するオプションを追記
 ・ server.inc.plの変更　?　ベンチマーク時間を短縮し、更に短い時間でベンチマー
    クを取得できるようにした。
 ・ location.inc.plの変更
 ・ adminchangepasswordinc.plの変更
 ・ agent.inc.plの追加
 ・ ls2.inc.plのオプション追加
 ・ topicpath.inc.plの変更
 ・ edit.inc.plの変更
 ・ rss10page.inc.plの変更
 ・ rss10.inc.plの変更
 ・ vote.inc.plの仕様変更（従来通り動くモードもあります）
 ・ spam_filterの挙動の追加及び変更（pyukiwiki.ini.cgiに変更があります）
 ・ Digest::MD5、Digest::Perl::MD5を切り替える必要のないように、Nana:MD5を作成
    した。
 ・ urlhack.inc.cgi 短縮アドレスのwikiページに対応
 ・ twitter.jsの不具合修正
 ・ ごく軽度のXSS脆弱性を修正（凍結ページでのみ起きます）
 ・ インストーラの変更点 (0.2)
     □ update のものを、アップデータの名乗るように変更した。
     □ インストーラ内で、全ページを凍結できる設定を追加した。
     □ 外部CSS参照していたのを取り込んだ。

0.2.0からの主な変更点

 ・ ライセンスの変更（GPL2からGPL3にバージョンアップ）、Artsticは変更なし
 ・ 自分でも把握しきれないぐらいの、多くのバグフィックス
 ・ 評価用に、CGIインストーラの作成
 ・ smedia.inc.pl
    ページによって、リンクはきちんとされるものの、リンクが異なることを修正した
    。
    -Nana/Logs/Logs.pm
    負荷が重すぎる為、一時的に、１か月おきだけでなく、１日おきの一覧を出力でき
    るようにした。
    アクセスログのキャッシュ化をした。

0.1.9からの主な変更点

 ・ XHTML 1.1 時に、Content-type: application/xhtml+xml で出力するようにした。
 ・ UTF8版を追加した。変換する為の管理者用プラグインも作成しましたが、非常に重
    い物となっています。
 ・ 管理者向けパスワードを簡易暗号化するようにした。
    ただし、ごくまれに（約1000分の1の確率)で正常に認証できないバグがあります。
 ・ ビルド時に、DEVEL版以外のコメントを削除できるようにした。
 ・ ビルド時に、compact版の不要な行を削除できるようにした。
 ・ バックアップ機能を追記した。
 ・ backupプラグインの追加
 ・ titleプラグインの追加
 ・ 暫定的にIPV6に対応した。
 ・ PukiWiki互換の凍結方法にした。ただし、info/ ディレクトリは今まで通り必要で
    す。
 ・ カウンターファイルをPukiWiki互換にした。
     □ DEVEL版以外を可能な限りコンパクトにしてみた。
 ・ wiki文法に [ [(url...(gif|png|jpe?g)) > link url,説明文] ]を加えた
 ・ IEにおいて、ESCキーを押してしまったことにより、入力内容が元に戻ってしまうの
    を阻止した。
 ・ #imgプラグインにおいて、jpg,png,gif以外の画像を表示できるようにした。
 ・ #imgプラグインにおいて、height、widthを指定できるようにした。

0.1.8からの主な変更点

 ・ いくらかのバグフィックス
 ・ #twitterプラグインを追加した。
 ・ Nana::HTTPのHTTPクライアントがまともに動作しない場合があるので、別途
    HTTP::Lite を用意した。
 ・ 表示軽量化、及びほんのごくわずかな節電対策の為のgzip圧縮標準化、及び、
    JavaScript、CSSの圧縮化

0.1.7からの主な変更点

 ・ スパム対策
    #article、#comment、#pcommentの本文に日本語文面がなければ拒否されるようにな
    りました。
    また、URL文字列が10個以上含まれるものも拒否されるようになりました。(両者と
    もpyukiwiki.ini.cgiで設定可）
 ・ rss10以外の廃止
 ・ jcode.plの廃止（Jcode.pmのみの対応になります）
 ・ InterWikiNameに検索エンジンを追加した
 ・ 一部のバグの修正等
 ・ 一部のURLリンク切れの修正

0.1.5からの主な変更点

 ・ 多くのPukiWiki文法を取り入れました。
 ・ PukiWikiとの互換性がいっそう高くなり、表現力が高くなります。
 ・ wiki.cgi起動と同時に動的に読み込む expluginを搭載しました。
 ・ 内部の関数をハック（乗っ取り）し、別の動作をさせることができます。
    (overloadモジュールを使用していません）
 ・ システムメッセージ対応
    スキン(sub skin)に渡されるページ名($page)に、以下のような仕様変更があります
    。
     □ ページ名は、タブ区切りで、以下のような内容となります。
     □ "ページ名(空白のこともあり)" =Y=t "システムメッセージ" =Y=t "エラーメッ
        セージ"
 ・ スキンで、printをせず、変数に格納することとなりました。
    そのため、既存のスキンはそのままではご利用になれません。
    $htmlbody 等の変数に一括して格納し、最後に return する必要があります。
 ・ 半角スペースを含むページが作成可能になりました
    ただし、先頭・最後に半角スペースがあるページは作れません
 ・ [うぃき?] のようなブラケットをしたときに出たバグを修正しました。
 ・ 部分編集に対応しました。
    巨大なページでも、編集しやすくなりました。
 ・ SEO対策をしました。 URLから「?」等を省く、urlhack.inc.cgiプラグインの追加
    編集画面等では、ロボットがクロールしないようにMETAタグを設定した

（ただし、現状において、自動でのSEO対策機能は、そのままでは対策になりません）

 ・ nph CGIに対応しました。ファイル名の先頭を nph- にすると、直接HTTP/1.1 200
    OK から出力します。
 ・ $::IN_HEAD、$::HTTP_HEADER変数に代入すると、それぞれ、<head>タグ内、HTTPヘ
    ッダに代入されるようになった。
 ・ xhtmlに対応しました。デフォルトでは HTML 4.01 Transitionalで出力されますが
    、以下を選択することができます。
     □ XHTML 1.1
     □ XHTML 1.0 Strict (非正式対応)
     □ XHTML 1.0 Transitional (非正式対応)
     □ XHTML Basic 1.0 (非正式対応)
 ・ _action のリターン値に以下を追加

http_header
header
ispage（予約）
notviewmenu（予約）

 ・ WikiNameを廃止することができるようになりました。
 ・ スキンで表示せず、内部でバッファリングするようにした。
 ・ スキンの最も下のCopyrightのフッタをwiki文法に変更した
 ・ htmlディレクトリとcgi-binディレクトリが異なるシステムで、従来より設置しやす
    くしました。
 ・ リソースを分割して、プラグイン実行時に動的に読み込むようにした
 ・ pagenavi.inc.pl
    PyukiWIki/Download>0.1.6 をそれぞれに、リンクしたい時に便利なプラグインです
    。
    , 区切りで、Wiki文法で入力しますが、 / を含む場合はページ名だけを入力します
    。

#pagenavi(*,PyukiWIki/Download>0.1.6,''ダウンロード'') 等

 ・ server.inc.pl
    サーバー情報を詳細に表示するプラグインです。
    実行は、?cmd=server のみで、凍結パスワードが必要になります。
    Nekyo氏のPyukiWikiに同名のプラグインがありますが、互換性はありません。

（wikiで使うようなものではないのですが・・・）

 ・ servererror.inc.pl
    .htaccessでの、ErrorDocumentから呼び出すサーバーエラー表示するプラグインで
    す。
 ・ sitemap.inc.pl
    以前公開していたものを、バグフィックスして標準化しました
 ・ deletecache.inc.pl
    管理者用プラグインで、キャッシュディレクトリの中身をすべて削除します。
 ・ article.inc.pl
    改行自動変換を実装（変数フラグのみあった）
    名前なし、サブジェクトなし投稿を禁じるフラグをつけた
    ページが凍結されていても投稿できるようにもなった。
 ・ attach.inc.pl
    多くの既存バグを修正
    nph CGIに対応
    アップロードは自由だが、削除はパスワードが必要なモードを加えた
 ・ comment.inc.pl
    ページが凍結されていても投稿できるようにもなった。
 ・ counter.inc.pl
    新形式のカウンターに対応（1年分保存可能です。設定が必要です）
    旧形式のカウンターのバグを自動修正する機能をもたせた
    昨日以前を昨日と認識するバグを修正
    MenuBar等にカウンターを置いた時の処理変更
 ・ edit.inc.pl
    PukiWikiライクな編集画面になるようになった。
    既存ページから、雛形として読み込む機能を追加
 ・ lookup.inc.pl
    InterWikiName正規化に伴い変更
    $::usepopup変数に対応
    nph CGIに対応
 ・ newpage.inc.pl
    ページのprefixを選択できるようになった。
 ・ recent.inc.pl
    半角スペースを含むページに対応
 ・ rss10.inc.pl
    半角スペースを含むページに対応
    nph CGIに対応
 ・ search.inc.pl
    search_fuzzy.inc.pl追加に伴う変更
 ・ search_fuzzy.inc.pl
    日本語あいまい検索用です。
    モジュールをuseしているので別のモジュールになっています。直接呼出しはできま
    せん
 ・ showrss.inc.pl
    PyukiWikiのRSSが正しく取得できなかったのを修正
 ・ ref.inc.pl
    いくつかのバグを修正
    $::usepopup変数に対応
 ・ その他プラグインいくつかの、PukiWiki内部制御用のコマンドを、ダミープラグイ
    ンとして実装しています。
 ・ サンプル
    CGIを外部から呼び出せない等の理由で、外部からInterWikiできないwikiのために
    、PHPやHTML+JavaScriptのwrapperをサンプルとして添付しました。

ライブラリ

 ・ @sushat4692さんのJavaScriptローダーを非常に参考にさせていただきました。
    http://blog.sus-happy.net/201201/javascript-parallel-loader/

使用しているライブラリ等

perl

 ・ YukiWikiDB関連　結城浩氏、極悪氏 http://www.hyuki.com/yukiwiki/wiki.cgi?
    YukiWikiDB2
    http://www.hyuki.com/yukiwiki/wiki.cgi?
    YukiWikiDB%a4%ce%a5%ed%a5%c3%a5%af%b5%a1%c7%bd
    http://www.hyuki.com/yukiwiki/wiki.cgi?YukiWikiLock

 ・ RSS.pm、Difftext.pm
    http://www.hyuki.com/yukiwiki/

 ・ Algorithm::Diff
    http://search.cpan.org/~tyemq/

 ・ File::MMagic
    http://search.cpan.org/~knok/
    なお、MMagic.pm内臓のmagicデータは、データ判別においての材料が不足している
    為、削除してあります。

 ・ Time::Local
    http://search.cpan.org/~drolsky/

 ・ Digest::Perl::MD5
    http://search.cpan.org/~delta/

 ・ Jcode.pm
    http://openlab.jp/Jcode/index-j.html http://search.cpan.org/~dankogai/

 ・ IDNA::Punycode
    http://search.cpan.org/~roburban/

 ・ 迷惑メール収集業者対策＠Toshi (NINJA104)
    http://ninja.index.ne.jp/~toshi/soft/untispam.shtml (obsolete)

 ・ Perlメモより＠大崎博基氏
    http://www.din.or.jp/~ohzaki/perl.htm
    http://www.din.or.jp/~ohzaki/regex.htm
     □ URL及びメールアドレスの正規表現
     □ 年月日から曜日を取得する
     □ 年月から末日を取得する
     □ 第Ｎ　Ｗ曜日ｎ日付を求める
     □ EUC文字関係の処理
     □ リネームロック
     □ 改行コードを統一する
     □ その他

 ・ AWStats（アクセスログ解析）
    http://awstats.sf.net/
    http://www.starplatinum.jp/awstats/awstats70/
    特に、テーブル定義は、そのまま使用させて頂きました。

JavaScript

 ・ jquery、jquery-migrate
    http://jquery.com/

 ・ jqModal
    http://dev.iceburg.net/jquery/jqModal/

 ・ Farbtastic Color Picker
    http://acko.net/blog/farbtastic-jquery-color-picker-plug-in/

 ・ ppblog
    http://p2b.jp/
    多くの有用なJavaScriptを利用させて頂いています。

     □ FireFoxのツールチップ改造＠martin
        http://martin.p2b.jp/index.php?date=20050201

     □ ブラウザ内での画像ポップアップ
        http://martin.p2b.jp/index.php?UID=1115484023

 ・ twitter取得用JavaScript
    http://twitstat.us/
    オリジナルソースは http://twitstat.us/twitstat.js
    (現在、オプションとして利用できるのみです）

 ・ 高度な JavaScript 技集 by 出雲氏
    http://www.onicos.com/staff/iz/amuse/javascript/expert/
    http://www.onicos.com/staff/iz/
    http://www.onicos.co.jp/c_profile/page06_003.html

 ・ niceTime
    http://james.padolsey.com/javascript/recursive-pretty-date/

 ・ http同期/非同期クライアント
    http://blog.livedoor.jp/aki_mana/archives/5440501.html

 ・ replaceall
    http://www.syboos.jp/webjs/doc/string-replace-and-replaceall.html

 ・ sprintf
    http://d.hatena.ne.jp/uupaa/20091214/1260737607

スパム禁止ワード

http://www.vector.co.jp/soft/data/net/se475480.html

使用している画像

 ・ フリー画像等に感謝します。
    --2500 Flag icon Set
     □ NIXUS Icon Pack
     □ Yahoo! Japan Ymark.gif btnXSLogin.gif
     □ Twitter bird
     □ mixi ballon icon
     □ はてなロゴ f_logo.png
     □ Facebook 「f」ロゴ
     □ Google Apps アイコン
     □ OpenID ロゴ

謝辞

 ・ 本家のWikiを作ったWard Cunninghamに感謝します。 http://c2.com/cgi/wiki

 ・ PyukiWikiを楽しんで使ってくださるみなさんに感謝します。

 ・ PukiWiki、YukiWiki等多くのWikiクローンの作者さんたちに感謝します。

 ・ YukiWiki
    http://www.hyuki.com/yukiwiki/
    PyukiWikiのベースとして、YukiWikiはなくてはならないものでした。

 ・ PukiWiki (PHP)
    http://pukiwiki.sfjp.jp/
    デザインをはじめ、多くの書式等を参考にしました。

 ・ PukiWiki Plus! (PHP)
    http://pukiwiki.cafelounge.net/plus/
    国際化の実装方法のアイデア、国アイコンの公開に感謝します。

 ・ 「極悪」さんのwiki (Perl)
    http://hpcgi1.nifty.com/dune/gwiki.pl 特に、YukiWikiDBに感謝します。

 ・ 塚本牧生さんのWalWiki (Perl)
    http://digit.que.ne.jp/work/
    テーブル機能、部分編集機能に感謝します。

 ・ その他、パッチを提供して頂いた以下の方に感謝します。
    Mr koizumi, wadldw, pochi

作者

Copyright (C) 2004-2007 by Nekyo
http://nekyo.qp.land.to/　（リンク切れ）

Copyright (C) 2002-2007 by Hiroshi Yuki
http://www.hyuki.com/

Copyright (C) 2005-2015 by ななみ (ななこっち★)
http://nanakochi.daiba.cx/　http://www.daiba.cx/　http://chat.daiba.cx/
http://vpsinfo.jp/　http://eat.jp.net/　http://pyu.be/　http://power.daiba.cx/
http://twitter.com/nanakochi123456/
http://ja.wikipedia.org/wiki/%e5%88%a9%e7%94%a8%e8%80%85%3aPapu

Copyright (C) 2004-2007 by やしがにもどき
http://hpcgi1.nifty.com/it2f/wikinger/pyukiwiki.cgi　（リンク切れ）

Copyright (C) 2005-2007 by Junichi
http://www.re-birth.com/　（コンテンツなし）

Copyright (C) 2005-2015 PukiWiki Developers Team
http://pyukiwiki.info/ http://pyukiwiki.sfjp.jp/

