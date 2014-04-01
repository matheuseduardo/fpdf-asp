<script language="jscript" runat="server" charset="utf-8">

/****************************************************************************
*                                                                           *
* Software				: 	cImage			                                *
* Version				: 	0.01	                                        *
* Date					: 	2003/11/15                                      *
* Author				:   Lorenzo Abbati	                                *
* License				:  	Freeware                                        *
* Site					:	http://www.aspxnet.it	                        *
*                                                                           *
*****************************************************************************/

function cImage(){

	this.Buffer;
	this.width=-1;
	this.height=-1;
	this.mime="";
	this.channels;
	this.bits;
	this.size=-1;
	this.extension;
	this.id;

	this.Open=function Open(pFileName){
	this.FileName = pFileName
	this.Buffer=Server.CreateObject("ADODB.Stream");
	this.Buffer.CharSet ="ISO-8859-1";
	this.Buffer.Type = 2
	this.Buffer.Open()
	//Response.Write(Server.MapPath(pFileName));Response.End;
	this.Buffer.LoadFromFile(Server.MapPath(pFileName));
	this.Buffer.Position = 0
	this.size=this.Buffer.Size;
	this.extension = pFileName.substring(pFileName.lastIndexOf(".")+1).toLowerCase();

	this.mime = this.GetMimeType(this.extension);
		switch(this.mime){
			case "image/jpeg":this._parseJpeg();
		}
	}

	this.GetMimeType=function GetMimeType(ext){
		switch(ext){
			case "jpg":
			case "jpeg":
				return "image/jpeg";
			case "png":
				return "image/png";
		}
	}

	function toAscii(code){
		//debug(code)
		switch(code){
			case 8364: code=128;break;
			case 8218: code=130;break;
			case 402: code=131;break;
			case 8222: code=132;break;
			case 8230: code=133;break;
			case 8224: code=134;break;
			case 8225: code=135;break;
			case 710: code=136;break;
			case 8240: code=137;break;
			case 352: code=138;break;
			case 8249: code=139;break;
			case 338: code=140;break;
			case 381: code=142;break;
			case 8216: code=145;break;
			case 8217: code=146;break;
			case 8220: code=147;break;
			case 8221: code=148;break;
			case 8226: code=149;break;
			case 8211: code=150;break;
			case 8212: code=151;break;
			case 732: code=152;break;
			case 8482: code=153;break;
			case 353: code=154;break;
			case 8250: code=155;break;
			case 339: code=156;break;
			case 382: code=158;break;
			case 376: code=159;break;
			default:
				Response.Write("Error ascii code : " + code);
				Response.End
		}
		return code;
	}

	this.Read=function Read(nB,radix){
		var res=""
		if (arguments.length<2){radix=16;}
		else if (radix=="string"){return this.Buffer.ReadText(nB);}
		for(i=1;i<=nB;i++){
				ch = this.Buffer.ReadText(1).charCodeAt(0)
				if (ch>255)ch=toAscii(ch)
				ch = ch.toString(16)
				if (ch.length==1)ch = "0" + ch
				res += ch
			}
		if (radix!=16){
			res = res.toString(radix);
			if (radix==10){res = parseInt(res,16)}
			else if (radix==2){
				if (res.length!=nB*8){
					s = "";for (i=0;i<nB*8-res.length;i++){s+="0"}
					res = s + res;
				}
			}
		}
		return res;
	}

	this._parseJpeg = function _parseJpeg(){
		var TEM = 0x01;	var SOF = 0xc0;	var DHT = 0xc4;	var JPGA= 0xc8
		var DAC = 0xcc;	var RST = 0xd0;	var SOI = 0xd8;	var EOI = 0xd9
		var SOS = 0xda;	var DQT = 0xdb;	var DNL = 0xdc;	var DRI = 0xdd
		var DHP = 0xde;	var EXP = 0xdf;var APP = 0xe0;	var JPG = 0xf0
		var COM = 0xfe; var marker=0;var length;
		this.id=2;
		if (this.Read(1,10)==0xff){
			while(!this.Buffer.EOS){
			marker = this.Read(1,10)
			while (marker==0xff){marker = this.Read(1,10)}
			switch(marker){
				case DHP:case SOF+0:case SOF+1:case SOF+2:case SOF+3:case SOF+5:
				case SOF+6:case SOF+7:case SOF+9:case SOF+10:case SOF+11:case SOF+13:case SOF+14:case SOF+15:
						length = this.Read(2,10)
						this.bits		= this.Read(1,10)
						this.height		= this.Read(2,10)
						this.width		= this.Read(2,10)
						this.channels	= this.Read(1,10)
						return;
				case APP+0:	case APP+1:	case APP+2:	case APP+3:case APP+4:	case APP+5:	case APP+6:	case APP+7:
				case APP+8:	case APP+9:	case APP+10:case APP+11:case APP+12:case APP+13:case APP+14:case APP+15:
				case DRI:case SOS:	case DHT:case DAC:case DNL:case EXP:
					h=this.Read(2,10)-2
					this.Buffer.Position +=  h;
					break;
				}
			}
		}
	}

	this._parsePng = function _parsePng(){

	}

	this.GetBuffer=function GetBuffer(){
		this.Buffer.Position=0
		return this.Buffer.ReadText()
	}

	this.Close=function Close(){
		this.Buffer.Close();
	}

}
</script>




