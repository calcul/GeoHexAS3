## GeoHexAS3 DESCRIPTION
GeoHexAS3 (c) 2009 calcul
http://blog.goo.ne.jp/calcul/
http://twitter.com/calcul_omikan


GeoHex クラス

・GeoHexAS3はAction Script3.0上で日本限定の斜形座標系を提供するクラスです。
・GeoHexAS3は緯度経度と範囲レベルからGeoHexコードの生成、GeoHexコードから緯度経度・レベルの相互変換が可能です。
・GeoHexコード変換の他、ユーティリティー関数、プロパティを提供します。


GeoHexの概要 (http://geogames.net/)

   1. 日本中を隙間の無い六角形ポリゴン（ヘックス）で敷き詰めます。ヘックスに含まれる緯度経度を、ヘックスのサイズ（６０段階）により４0７桁の短いコードに変換します。
   2. 緯度経度から直接変換を行うため、ロジック単体で変換が可能です。
   3. 矩形メッシュと異なり、マス目間の距離がほぼ等しくなります。（緯度により南北方向の長さは多少異なりますが、実用範囲内。）
   4. 一定の精度幅を持つため、プライバシーの保護に向いています。
   5. 隣接するヘックスを６方向で表せるため、連続した軌跡をヘックスコード＋[1-6]*nで表すことが可能です。


  発明者はsa2da (http://geogames.net/)です。
  AS3以外の実装として、JavaScript/Perl/Rubyが存在します。


使い方

<<<<<<< HEAD
使い方

・net/geogames 以下に、GeoHex.asをコピー。 *「import net.geogames.GeoHex」 を記述。 

=======
・net/geogames 以下に、GeoHex.asをコピー。 *「import net.geogames.GeoHex」 を記述。 

>>>>>>> de8798704addc392ffb38dbc8d16bece17914709
・以下は、緯度経度をGeoHexコードに変換するコード 

	
	var GeoHexCode:String;
	var zone:GeoHex = new GeoHex();	// import net.geogames.GeoHex;
	
	GeoHexCode = zone.latlng2geohex(35,135,7);	//緯度,経度,レベルの順
	
	trace(GeoHexCode);	//出力: rnvs


・細かいリファレンスは、ASDOCを参照してください。
	ASDOC http://github.com/geohexas3/asdoc/



  * The GeoHex is a latitude/longitude encoding system invented by sa2da.
  * GeoHex divides geometry regions into hexagonal grid and set an unique identifier to each grid. It supports only Japan region so far.
  * The coding idea is opened under the Creative Commons Attribution 2.1 Japan Lisence.
  * GeoHexAs3 Documentation: http://github.com/geohexas3/asdoc/
  * GeoHex Original Wiki(Japanese): http://geogames.net/labs/geohex
  * GeoHex Demo: http://geogames.net/hex/
  * Various GeoHex Libraries: http://github.com/geohex/

## LICENSE
 
(The MIT License)
 
Copyright (c) 2008 David Troy, Roundhouse Technologies LLC
 
Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:
 
The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 