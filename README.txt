## GeoHexAS3 DESCRIPTION
GeoHexAS3 (c) 2009 calcul
http://blog.goo.ne.jp/calcul/
http://twitter.com/calcul_omikan


GeoHex �N���X

�EGeoHexAS3��Action Script3.0��œ��{����̎Ό`���W�n��񋟂���N���X�ł��B
�EGeoHexAS3�͈ܓx�o�x�Ɣ͈̓��x������GeoHex�R�[�h�̐����AGeoHex�R�[�h����ܓx�o�x�E���x���̑��ݕϊ����\�ł��B
�EGeoHex�R�[�h�ϊ��̑��A���[�e�B���e�B�[�֐��A�v���p�e�B��񋟂��܂��B


GeoHex�̊T�v (http://geogames.net/)

   1. ���{�������Ԃ̖����Z�p�`�|���S���i�w�b�N�X�j�ŕ~���l�߂܂��B�w�b�N�X�Ɋ܂܂��ܓx�o�x���A�w�b�N�X�̃T�C�Y�i�U�O�i�K�j�ɂ��S0�V���̒Z���R�[�h�ɕϊ����܂��B
   2. �ܓx�o�x���璼�ڕϊ����s�����߁A���W�b�N�P�̂ŕϊ����\�ł��B
   3. ��`���b�V���ƈقȂ�A�}�X�ڊԂ̋������قړ������Ȃ�܂��B�i�ܓx�ɂ���k�����̒����͑����قȂ�܂����A���p�͈͓��B�j
   4. ���̐��x���������߁A�v���C�o�V�[�̕ی�Ɍ����Ă��܂��B
   5. �אڂ���w�b�N�X���U�����ŕ\���邽�߁A�A�������O�Ղ��w�b�N�X�R�[�h�{[1-6]*n�ŕ\�����Ƃ��\�ł��B


  �����҂�sa2da (http://geogames.net/)�ł��B
  AS3�ȊO�̎����Ƃ��āAJavaScript/Perl/Ruby�����݂��܂��B



�g����

�Enet/geogames �ȉ��ɁAGeoHex.as���R�s�[�B *�uimport net.geogames.GeoHex�v ���L�q�B 

�E�ȉ��́A�ܓx�o�x��GeoHex�R�[�h�ɕϊ�����R�[�h 

	
	var GeoHexCode:String;
	var zone:GeoHex = new GeoHex();	// import net.geogames.GeoHex;
	
	GeoHexCode = zone.latlng2geohex(35,135,7);	//�ܓx,�o�x,���x���̏�
	
	trace(GeoHexCode);	//�o��: rnvs


�E�ׂ������t�@�����X�́AASDOC���Q�Ƃ��Ă��������B
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
 