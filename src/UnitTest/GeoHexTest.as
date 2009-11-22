package UnitTest
{
	import net.geogames.GeoHex;
	
	import org.libspark.as3unit.assert.assertEquals;
	import org.libspark.as3unit.test;
    
    use namespace test;
	public class GeoHexTest
	{
		
 // 緯度経度レベルからGeoHexコードを返す latlng2geohex
        
        //	レベル省略書式  = 7
         //期待する結果: rmox
        test function latlng2geohex_levelless():void
        {
        	var lat:Number  = 34.692489;
        	var lon:Number = 135.500302;
        	//var level:int = 60;
        	var expect:String="rmox";
            var zone:GeoHex = new GeoHex();
            
           assertEquals(expect, zone.latlng2geohex(lat,lon));
        }
        
        //レベルが7以下の場合 
         //期待する結果: 132bBGK(7桁書式出力)
        test function latlng2geohex_underlevel7():void
        {
        	var lat:Number  = 34.692489;
        	var lon:Number = 135.500302;
        	var level:int = 1;
        	var expect:String="132bBGK";
            var zone:GeoHex = new GeoHex();
            
           assertEquals(expect, zone.latlng2geohex(lat,lon,level));
        }
        

         //期待する結果: 032dD(level60は0)
        test function latlng2geohex_level60():void
        {
        	var lat:Number  = 34.692489;
        	var lon:Number = 135.500302;
        	var level:int = 60;
        	var expect:String="032dD";
            var zone:GeoHex = new GeoHex();
            
           assertEquals(expect, zone.latlng2geohex(lat,lon,level));
        }
        
         //期待する結果: fcaLw
        test function latlng2geohex_level15():void
        {
        	var lat:Number  = 34.692489;
        	var lon:Number = 135.500302;
        	var level:int = 15;
        	var expect:String="fcaLw";
            var zone:GeoHex = new GeoHex();
            
           assertEquals(expect, zone.latlng2geohex(lat,lon,level));
        }
        
        
        
// GeoHexから緯度経度レベルを返す geohex2latlng
        
        //	レベル省略書式 wkmP
        //期待する結果: 35.654108
        test function geohex2latlng_レベル省略書式():void
        {
        	var code:String="wkmP";
            var zone:GeoHex = new GeoHex();
            
            var expect:Object= new Object();
            expect["lat"] = 35.654108;
            expect["lng"] = 139.700874;
            expect["level"]=7;
            
            var result:Object = zone.geohex2latlng(code);
            
            assertEquals(expect["lat"],result["lat"],"lat");
            assertEquals(expect["lng"],result["lng"],"lng");
            assertEquals(expect["level"],result["level"],"level");
        }
        
        //	レベル1 132KpwT
        //期待する結果: 35.658310
        test function geohex2latlng_レベル1():void
        {
        	var code:String="132KpwT";
        	var zone:GeoHex = new GeoHex();
        	
        	var expect:Object= new Object();
            expect["lat"] = 35.658310;
            expect["lng"] = 139.700877;
            expect["level"]=1;
            
            var result:Object = zone.geohex2latlng(code);
            
            assertEquals(expect["lat"],result["lat"],"lat");
            assertEquals(expect["lng"],result["lng"],"lng");
            assertEquals(expect["level"],result["level"],"level");
        }
        
        //	レベル15 ff96I
        //期待する結果: 35.652007
        test function geohex2latlng_レベル15():void
        {
        	var code:String="ff96I";
        	var zone:GeoHex = new GeoHex();
        	
        	var expect:Object= new Object();
            expect["lat"] = 35.652007;
            expect["lng"] = 139.702372;
            expect["level"]=15;
            
            var result:Object = zone.geohex2latlng(code);
            
            assertEquals(expect["lat"],result["lat"],"lat");
            assertEquals(expect["lng"],result["lng"],"lng");
            assertEquals(expect["level"],result["level"],"level");
        }
        
        //	レベル7 7rmox 省略を使わない場合
        //期待する結果: 34.692665
        test function geohex2latlng_レベル7省略を使わない場合テスト():void
        {
        	var code:String="7rmox";
        	var zone:GeoHex = new GeoHex();
 
        	var expect:Object= new Object();
            expect["lat"] = 34.692665;
            expect["lng"] = 135.501638;
            expect["level"]=7;
            
            var result:Object = zone.geohex2latlng(code);
            
            assertEquals(expect["lat"],result["lat"],"lat");
            assertEquals(expect["lng"],result["lng"],"lng");
            assertEquals(expect["level"],result["level"],"level");
        }
 
  
        
// GeoHex間の距離取得  geohex2distance

        //期待する結果: 1
        test function geohex2distance_距離1_方向1():void
        {
        	var code1:String = "wknR";
        	var code2:String = "wkoR";
        	var expect:int = 1;
            var zone:GeoHex = new GeoHex();

            assertEquals(expect,zone.geohex2distance(code1,code2));
        }         
        
        
        //期待する結果: 1
        test function geohex2distance_距離1_方向2():void
        {
        	var code1:String = "wknR";
        	var code2:String = "wkoS";
        	var expect:int = 1;
            var zone:GeoHex = new GeoHex();

            assertEquals(expect,zone.geohex2distance(code1,code2));
        }         
               
         //期待する結果: 1
        test function geohex2distance_距離1_方向3():void
        {
        	var code1:String = "wknR";
        	var code2:String = "wknS";
        	var expect:int = 1;
            var zone:GeoHex = new GeoHex();

            assertEquals(expect,zone.geohex2distance(code1,code2));
        }  
        
         //期待する結果: 1
        test function geohex2distance_距離1_方向4():void
        {
        	var code1:String = "wknR";
        	var code2:String = "wkmR";
        	var expect:int = 1;
            var zone:GeoHex = new GeoHex();

            assertEquals(expect,zone.geohex2distance(code1,code2));
        }  
         //期待する結果: 1
        test function geohex2distance_距離1_方向5():void
        {
        	var code1:String = "wknR";
        	var code2:String = "wkmQ";
        	var expect:int = 1;
            var zone:GeoHex = new GeoHex();

            assertEquals(expect,zone.geohex2distance(code1,code2));
        }  
         //期待する結果: 1
        test function geohex2distance_距離1_方向6():void
        {
        	var code1:String = "wknR";
        	var code2:String = "wknQ";
        	var expect:int = 1;
            var zone:GeoHex = new GeoHex();

            assertEquals(expect,zone.geohex2distance(code1,code2));
        }  
        
        //期待する結果: 2
   		test function geohex2distance_距離2():void
        {
        	var code1:String = "wkrQ";
        	var code2:String = "wkrO";
        	var expect:int = 2;
            var zone:GeoHex = new GeoHex();

            assertEquals(expect,zone.geohex2distance(code1,code2));
        }         
        
         //期待する結果: 4
   		test function geohex2distance_距離4():void
        {
        	var code1:String = "wkrQ";
        	var code2:String = "wknQ";
        	var expect:int = 4;
            var zone:GeoHex = new GeoHex();

            assertEquals(expect,zone.geohex2distance(code1,code2));
        }         
        
          //期待する結果: 8
   		test function geohex2distance_距離8():void
        {
        	var code1:String = "wkrQ";
        	var code2:String = "wkjI";
        	var expect:int = 8;
            var zone:GeoHex = new GeoHex();

            assertEquals(expect,zone.geohex2distance(code1,code2));
        }    
        
          //期待する結果: 7
   		test function geohex2distance_距離7():void
        {
        	var code1:String = "wkiH";
        	var code2:String = "wkeK";
        	var expect:int = 7;
            var zone:GeoHex = new GeoHex();

            assertEquals(expect,zone.geohex2distance(code1,code2));
        }  
        
            
// コード中のヘックスレベルを返す geohex2level
        
        //期待する結果:  -1
        test function geohex2level_引数無し():void
        {
            var zone:GeoHex = new GeoHex();
            var expect:Object= new Object();
            expect["level"]=-1;
            
            var result:Object = zone.geohex2level("");
            
           assertEquals(expect["level"],result["level"]);
        }
        
        //期待する結果: -1
        test function geohex2level_コードが8桁以上():void
        {
        	var zone:GeoHex = new GeoHex();
            var expect:Object= new Object();
            expect["level"]=-1;
            expect["code"]="wkqPSDD";
            expect["c_length"]=8;
            
            var result:Object = zone.geohex2level("0wkqPSDD");
            
        	assertEquals(expect["level"],result["level"]);
           	assertEquals(expect["code"],result["code"]);
           	assertEquals(expect["c_length"],result["c_length"]);
        }
        
        //期待する結果: 20
        test function geohex2level_Test():void
        {
        	//var expect:int=20;
            var zone:GeoHex = new GeoHex();
            
            var expect:Object= new Object();
            expect["level"]=20;
            expect["code"]="wkqP";
            expect["c_length"]=5;
            
           assertEquals(expect["level"], zone.geohex2level("kwkqP")["level"],"level");
           assertEquals(expect["code"], zone.geohex2level("kwkqP")["code"],"code");
           assertEquals(expect["c_length"], zone.geohex2level("kwkqP")["c_length"],"c_length");
        }
         //期待する結果: 7
        test function geohex2level_デフォルト4桁():void
        {
        	//var expect:int=7;
            var zone:GeoHex = new GeoHex();
            var expect:Object= new Object();
            expect["level"]=7;
             
           assertEquals(expect["level"], zone.geohex2level("wkqP")["level"]);
        }
        
         //期待する結果: 60
        test function geohex2level_0の場合はlevel60():void
        {
        	//var expect:int=60;
            var zone:GeoHex = new GeoHex();
            var expect:Object= new Object();
            expect["level"]=60;
            
        	assertEquals(expect["level"], zone.geohex2level("YwkqP")["level"]);
        }
        
         //Readme.txt記述用変換テスト
        test function latlng2geohex_test():void
        {
        	var GeoHexCode:String;
            var zone:GeoHex = new GeoHex();
            var expect:String="rnvs";
            
        	assertEquals(expect, zone.latlng2geohex(35,135,7));
        }
        
        
	}
}