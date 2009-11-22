/**
 * GeoHex 日本限定の斜形座標系を提供するクラス
 * GeoHex仕様(http://geogames.net/labs/geohex)
 * 
 * 2009/11/17 バージョン管理の取り決めが不明のためこの記述
 * 2009/11/19 package名追加
 * 2009/11/21 perl版を移植した　http://svn.coderepos.org/share/lang/perl/Geo-Hex/trunk/lib/Geo/Hex.pm
*/

package net.geogames
{
	/**
	 * 斜形座標系 GeoHexを提供する
	 * @author calcul にやにや製作(http://blog.goo.ne.jp/calcul/)
	 * @langversion ActionScript 3.0
	 */
	public class GeoHex
	{
		//定数ここから 
		//0:60 a:10 z:35 Z:61
		private const H_KEY:String = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
		private const DEFAULT_LEVEL:int = 7;
		private const MAX_LEVEL:int = 60;
		private const H_GRID:int = 1000;	//たぶんこれからも固定
		
		private const MIN_X_LON:Number = 122930;	//与那国島
		private const MIN_X_LAT:Number = 24448;
		private const MIN_Y_LON:Number = 141470;	//南硫黄島
		private const MIN_Y_LAT:Number = 24228;
		//定数ここまで
		
		private var _level:int;
		private var _code:String;
		private var _lat:Number;
		private var _lng:Number;
		
		//getter,setter
		public function get level():int { return _level;}
		public function set level(v:int):void   {_level=v;}
		
		public function get code():String{ return  _code;}
		public function set code(str:String):void{ _code=str;}

		public function get lat():Number{ return _lat;}		
		public function set lat(v:Number):void { _lat = v;}
			
		public function get lng():Number{ return _lng;}		
		public function set lng(v:Number):void { _lng = v;}
		
	
		public function GeoHex()
		{
			
		}
		
		/**
		 * GeoHexコードから緯度経度とレベル、コード長を取り出す
		 * @langversion ActionScript 3.0
		 * @param hexcode GeoHexコード
		 * @return 連想配列 "code" "level" "c_length"
		 */
		public function geohex2level(hexcode:String):Object{

			var code:String  = hexcode.substring(1,hexcode.length);
			var level:int    = H_KEY.indexOf(hexcode.charAt(0));
			var c_length:int = hexcode.length;
			
			if(level == 0)
				level = MAX_LEVEL;
				
			if(c_length < 5){
				level = DEFAULT_LEVEL;
				code  = hexcode;
			}
			
			if(c_length < 4 || c_length > 7 || c_length == 0)
				level = -1;

			var obj:Object = new Object();
			obj["code"]     = code;
			obj["level"]    = level;
			obj["c_length"] = c_length;
							
			return obj;	
		}
		
		/**
		 * 緯度経度・レベルをGeoHexコードへ変換する
		 * @langversion ActionScript 3.0
		 * @param lat 緯度
		 * @param lon 経度
		 * @param level レベル(1～60)
		 * @return GeoHexコード
		 */
		public function latlng2geohex(lat:Number,lon:Number,level:int=7):String
		{
			if (level<1 || level>60)
				return "";

			var h_grid:int = 1000;
			var h_size:Number = HexSize(level);
			
		    var lon_grid:Number = lon*h_grid;
		    var lat_grid:Number = lat*h_grid;
		    
		    var unit_x:Number = 6* h_size;
		    var unit_y:Number = 2.8* h_size;
		    var h_k:Number = (Math.round((1.4/3)* h_grid))/h_grid;
		    var base_x:Number = Math.floor((MIN_X_LON + MIN_X_LAT/h_k)/unit_x);
		    var base_y:Number = Math.floor((MIN_Y_LAT - h_k*MIN_Y_LON)/unit_y);
		    
		    
		    var h_pos_x:Number = (lon_grid + lat_grid/h_k)/unit_x  - base_x;
		    var h_pos_y:Number = (lat_grid - h_k*lon_grid)/unit_y  - base_y;
		    var h_x_0:Number = Math.floor(h_pos_x);
		    var h_y_0:Number = Math.floor(h_pos_y);
		    var h_x_q:Number = Math.floor((h_pos_x - h_x_0)*100)/100;
		    var h_y_q:Number = Math.floor((h_pos_y - h_y_0)*100)/100;
		    var h_x:Number = Math.round(h_pos_x);
		    var h_y:Number = Math.round(h_pos_y);
		    
		    if(h_y_q>-h_x_q+1){
		        if((h_y_q<2*h_x_q)&&(h_y_q>0.5*h_x_q)){
		            h_x = h_x_0 + 1;
		            h_y = h_y_0 + 1;
		        }
		    }else if(h_y_q<-h_x_q+1){
		        if((h_y_q>(2*h_x_q)-1)&&(h_y_q<(0.5*h_x_q)+0.5)){
		            h_x = h_x_0;
		            h_y = h_y_0;
		        }
		    }
		    
		    return hyhx2geohex(h_y,h_x,level);
		}
		
		//HexSize計算
		private function HexSize(level:int):Number
		{
			if(level) {
		          return level* 0.5;
		    }else{
		          return 7* 0.5;
		    }
		}
		
		/**
		 * GeoHexコードから緯度経度・レベルへ変換する
		 * @langversion ActionScript 3.0
		 * @param code GeoHexコード
		 * @return 連想配列 "lat","lng","level"を返す
		 */
		public function geohex2latlng(code:String):Object{
			
			var obj:Object = geohex2hyhx(code);
			var level:int  = obj["level"];
			var h_x:Number = obj["h_x"];
			var h_y:Number = obj["h_y"];
			var h_k:Number = obj["h_k"];
			var unit_x:Number = obj["unit_x"];
			var unit_y:Number = obj["unit_y"];
			var base_x:Number = obj["base_x"];
			var base_y:Number = obj["base_y"];
			
			var h_lat:Number = (h_k   * (h_x+base_x)*unit_x + (h_y+base_y)*unit_y)/2;
		    var h_lon:Number = (h_lat - (h_y+base_y)*unit_y)/h_k;
		    
		    var result:Object = new Object();
		    result["lat"]= Mathround(h_lat/H_GRID,6);
		    result["lng"]= Mathround(h_lon/H_GRID,6);
		    result["level"]= level;
		 
			return result;
		}
		
		/**
		 * 四捨五入
		 * @langversion ActionScript 3.0
		 * @param i 元の数値
		 * @param digit 小数点以下有効位
		 * @return 四捨五入された数値を返す
		 */
		private function Mathround(i:Number,digit:Number):Number{
		    return Number(i.toFixed(digit));
		}
		
		/**
		 * GeoHexコードを計算要素に分解
		 * @langversion ActionScript 3.0
		 * @param hexcode GeoHexコード
		 * @return 連想配列 "level" "h_x" "h_y" "h_k" "unit_x" "unit_y" "base_x" "base_y"
		 */
		private function geohex2hyhx(hexcode:String):Object{

			var obj:Object = geohex2level(hexcode);
			var code:String  = obj["code"];
			var level:int    = obj["level"];			
			var c_length:int = obj["c_length"];
			
			var h_grid:int = 1000;
			var unit_x:Number = 6.0 * HexSize(level);
		    var unit_y:Number = 2.8 * HexSize(level);
		    var h_k:Number = (Math.round((1.4/3)* h_grid))/h_grid;
		    var base_x:Number = Math.floor((MIN_X_LON + MIN_X_LAT/h_k)/unit_x);
		    var base_y:Number = Math.floor((MIN_Y_LAT - h_k*MIN_Y_LON)/unit_y);
			
			var h_x:Number;
		    var h_y:Number;
		    
		    if(c_length > 5){
		    	 h_x = H_KEY.indexOf( code.charAt(0) )* 3600 + H_KEY.indexOf( code.charAt(2) )* 60 + H_KEY.indexOf( code.charAt(4) );
		    	 h_y = H_KEY.indexOf( code.charAt(1) )* 3600 + H_KEY.indexOf( code.charAt(3) )* 60 + H_KEY.indexOf( code.charAt(5) );
		    }
		    else{
		    	 h_x = H_KEY.indexOf( code.charAt(0) )* 60 + H_KEY.indexOf( code.charAt(2) );
		    	 h_y = H_KEY.indexOf( code.charAt(1) )* 60 + H_KEY.indexOf( code.charAt(3) );
		    }

			var result:Object = new Object();
			result["level"]=level;
			result["h_x"]=h_x;
			result["h_y"]=h_y;
			result["h_k"]=h_k;
			result["unit_x"]=unit_x;
			result["unit_y"]=unit_y;
			result["base_x"]=base_x;
			result["base_y"]=base_y;
			
			return result;
		}
		
		/**
		 * 計算要素をGeoHexに変換
		 * @langversion ActionScript 3.0
		 * @param h_y
		 * @param h_x
		 * @param level
		 * @return GeoHexコード
		 */
		private function hyhx2geohex(h_y:Number,h_x:Number,level:int=7):String{
			
			var code:String;
			var h_x_100:Number = Math.floor(h_x/3600);
		    var h_x_10 :Number = Math.floor((h_x%3600)/60);
		    var h_x_1  :Number = Math.floor((h_x%3600)%60);
		    var h_y_100:Number = Math.floor(h_y/3600);
		    var h_y_10 :Number = Math.floor((h_y%3600)/60);
		    var h_y_1  :Number = Math.floor((h_y%3600)%60);
		    
		    if(level == 7)
		   		code = H_KEY.charAt(h_x_10) + H_KEY.charAt(h_y_10) + H_KEY.charAt(h_x_1) + H_KEY.charAt(h_y_1);
			else{
		        if(level < 7)
		            code = H_KEY.charAt(level%60) + H_KEY.charAt(h_x_100) + H_KEY.charAt(h_y_100) + H_KEY.charAt(h_x_10) + H_KEY.charAt(h_y_10) + H_KEY.charAt(h_x_1) + H_KEY.charAt(h_y_1);
		        else
		            code = H_KEY.charAt(level%60) + H_KEY.charAt(h_x_10) + H_KEY.charAt(h_y_10) + H_KEY.charAt(h_x_1) + H_KEY.charAt(h_y_1);
		    }
			return code;
		    
		}
		
		/**
		 * GeoHex間の距離取得 
		 * @langversion ActionScript 3.0
		 * @param GeoHexコード1
		 * @param GeoHexコード2
		 * @return 距離
		 */
		public function geohex2distance(code1:String,code2:String):int{
			
			var code_1:Object = geohex2hyhx(code1);
			var code_2:Object = geohex2hyhx(code2);
			
			if(code_1["level"] != code_2["level"])
				return -1;
			
			var dh_y:Number=code_1["h_y"] - code_2["h_y"];
			var dh_x:Number=code_1["h_x"] - code_2["h_x"];
			
			var ah_y:Number = Math.abs(dh_y);
			var ah_x:Number = Math.abs(dh_x);
			
			if ( dh_y * dh_x > 0 ) 
		    	return ah_x > ah_y ? ah_x : ah_y;
		    else 
		        return ah_x + ah_y;	
		}
		
		
		
		
		/**
		 * 中心座標計算 getZoneByLocationの代替
		 * @langversion ActionScript 3.0
		 * @param lat 緯度
		 * @param lon 経度
		 * @param level レベル
		 * @return 連想配列 "lat" "lng" "level" "code"
		 */
		public function latlng2center(lat:Number, lon:Number, level:int=7):Object{
			
			var h_size:Number = HexSize(level);
		    var lon_grid:Number = lon*H_GRID;
		    var lat_grid:Number = lat*H_GRID;
		    var unit_x:Number = 6* h_size;
		    var unit_y:Number = 2.8* h_size;
		    var h_k:Number = (Math.round((1.4/3)* H_GRID))/H_GRID;
		    var base_x:Number = Math.floor((MIN_X_LON + MIN_X_LAT/h_k)/unit_x);
		    var base_y:Number = Math.floor((MIN_Y_LAT - h_k*MIN_Y_LON)/unit_y);
		    var h_pos_x:Number = (lon_grid + lat_grid/h_k)/unit_x  - base_x;
		    var h_pos_y:Number = (lat_grid - h_k*lon_grid)/unit_y  - base_y;
		    var h_x_0:Number = Math.floor(h_pos_x);
		    var h_y_0:Number = Math.floor(h_pos_y);
		    var h_x_q:Number = Math.floor((h_pos_x - h_x_0)*100)/100;
		    var h_y_q:Number = Math.floor((h_pos_y - h_y_0)*100)/100;
		    var h_x:Number = Math.round(h_pos_x);
		    var h_y:Number = Math.round(h_pos_y);
		    
		    if(h_y_q>-h_x_q+1){
		        if((h_y_q<2*h_x_q)&&(h_y_q>0.5*h_x_q)){
		            h_x = h_x_0 + 1;
		            h_y = h_y_0 + 1;
		        }
		    }else if(h_y_q<-h_x_q+1){
		        if((h_y_q>(2*h_x_q)-1)&&(h_y_q<(0.5*h_x_q)+0.5)){
		            h_x = h_x_0;
		            h_y = h_y_0;
		        }
		    }
		    
		    var h_x_100:Number = Math.floor(h_x/3600);
		    var h_x_10:Number = Math.floor((h_x%3600)/60);
		    var h_x_1:Number = Math.floor((h_x%3600)%60);
		    var h_y_100:Number = Math.floor(h_y/3600);
		    var h_y_10:Number = Math.floor((h_y%3600)/60);
		    var h_y_1:Number = Math.floor((h_y%3600)%60);
		   
		    var h_lat:Number = (h_k*(h_x+base_x)*unit_x + (h_y+base_y)*unit_y)/2;
		    var h_lon:Number = (h_lat - (h_y+base_y)*unit_y)/h_k;
		    
		    
		    var result:Object= new Object();
		    result["lat"]= Mathround(h_lat/H_GRID,6);
		    result["lng"]= Mathround(h_lon/H_GRID,6);
		    result["level"]=level;
		    
		    var code:String;
		    if(level == 7)
		   		code = H_KEY.charAt(h_x_10) + H_KEY.charAt(h_y_10) + H_KEY.charAt(h_x_1) + H_KEY.charAt(h_y_1);
			else{
		        if(level < 7)
		            code = H_KEY.charAt(level%60) + H_KEY.charAt(h_x_100) + H_KEY.charAt(h_y_100) + H_KEY.charAt(h_x_10) + H_KEY.charAt(h_y_10) + H_KEY.charAt(h_x_1) + H_KEY.charAt(h_y_1);
		        else
		            code = H_KEY.charAt(level%60) + H_KEY.charAt(h_x_10) + H_KEY.charAt(h_y_10) + H_KEY.charAt(h_x_1) + H_KEY.charAt(h_y_1);
		    }
		    result["code"]= code;
		    
		    return result;
		    
		}
		
		/**
		 * ポリゴン座標計算 (渡される値(lat,lon)がセンター座標である場合のみ使用可)
		 * @langversion ActionScript 3.0
		 * @param lat 緯度
		 * @param lon 経度
		 * @param level レベル
		 * @return Array ポリゴン座標[0..6]
		 */
		public function latlng2polygon(lat:Number, lon:Number, level:int=7):Array{
			
			var d:Number =  HexSize(level) / H_GRID;
	    
			var polygon:Array= [{y:lat          ,x: lon - 2* d},
			        			{y:lat + 1.4* d ,x: lon - 1* d},
			        			{y:lat + 1.4* d ,x: lon + 1* d},
			        			{y:lat          ,x: lon + 2* d},
			        			{y:lat - 1.4* d ,x: lon + 1* d},
			        			{y:lat - 1.4* d ,x: lon - 1* d},
			        			{y:lat          ,x: lon - 2* d}];     

			return polygon;
		}
		
		/**
		 * ポリゴン座標計算 
		 * @langversion ActionScript 3.0
		 * @param GeoHexコード
		 * @return Array ポリゴン座標[0..6]
		 */
		public function geohex2polygon(hexcode:String):Array{
			
			//中心の座標をGeoHexコードから引き出して計算
			var center:Object = geohex2latlng(hexcode);
			var d:Number = HexSize(center["level"]) / H_GRID;
			
			var polygon:Array= [{y:center["lat"]          ,x: center["lng"] - 2* d},
			        			{y:center["lat"] + 1.4* d ,x: center["lng"] - 1* d},
			        			{y:center["lat"] + 1.4* d ,x: center["lng"] + 1* d},
			        			{y:center["lat"]          ,x: center["lng"] + 2* d},
			        			{y:center["lat"] - 1.4* d ,x: center["lng"] + 1* d},
			        			{y:center["lat"] - 1.4* d ,x: center["lng"] - 1* d},
			        			{y:center["lat"]          ,x: center["lng"] - 2* d}];     

			return polygon;
		}
		
		
	}
}