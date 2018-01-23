<!--#include File="images.asp"-->
<!--#include File="math.asp"-->
<script language="javascript" runat="server" charset="utf-8">

/****************************************************************************
*                                                                           *
* Software				: 	Basics for FPDF Class                           *
* Version				: 	0.01	                                        *
* Date					: 	2003/11/15                                      *
* Author				:   Lorenzo Abbati	                                *
* License				:  	Freeware                                        *
* Site					:	http://www.aspxnet.it	                        *
*                                                                           *
*****************************************************************************/

function CreateJsObject(s){return eval('new '+s);}
function cfile(){this.obj;this.mode;this.isBinary=false;}
function clib(){
this.fso = new ActiveXObject("Scripting.FileSystemObject");
this.empty=function empty(s){
	if (s==''||s=='undefined')return true
	else return false;
;}
this.ord=function ord(ch){return ch.charCodeAt(0)}
this.count=function count(ar){var i=0;for (k in ar){i++}return i;}
this.strlen=function strlen(s){s1 = new String(s);return s1.length;}
this.chr=function chr(value){return String.fromCharCode(value)}
this.die=function die(s){Response.Write("<font style='font.size:11;font-family:verdana'>" + s +"</font>");Response.End}
this.basename=function basename(s){
	i=s.lastIndexOf("/")
	if(i<0){i=0}
	return s.substring(i,s.length)
}
this.fopen=function fopen(name,params){
	switch(params.charAt(0)){
		case "r" : v = 1;c=false;p=Server.MapPath(name);break;
		case "w" : v = 2;c=true;p=name;break;
		case "a" : v = 8;c=true;p=Server.MapPath(name);break;
	}
	var f = new cfile();
	try{
	f.obj=this.fso.OpenTextFile(p,v,c);
	}
	catch(e){return e;}
	f.mode=params.charAt(0);
	if (params.length>1){if (params.charAt(1)=="b"){f.isBinary = true}};
	return f;
}

this.eregi=function eregi(r,s){
	re = new RegExp(r,"gi")
	return re.test(s)
}

this.explode=function explode(ch,svalue,limit){
	var s=new String(svalue)
	if(arguments.length=2){return s.split(ch)}
	else{return s.split(ch,limit)}
}

this.ltrim=function ltrim(s) {
	return s.replace(/^\s+/,"");
}
this.trim=function trim(s) {
	//debug(s)
	ns = new String(s)
	return ns.replace(/\s+$|^\s+/g,"");
}
this.rtrim=function rtrim(s) {
	ns = new String(s)
	return ns.replace(/\s+$/,"");
}

this.file=function file(path){
	var f
	var ar = new Array()
	try{
	f = this.fso.OpenTextFile(Server.MapPath(path), 1);
	while (!f.atEndOfStream){
		ar[ar.length] =  f.ReadLine();
		}
	f.close()
	return ar;
	}
	catch(e){this.die("Error, path not found : "+path) }
}

this.fwrite=function fwrite(f,buffer){
	try{f.obj.write(buffer)}
	catch(e){return e.number;}
	return true;
}

this.fread=function fread(f,nch){
	try{f.obj.read(nch)}
	catch(e){return e.number;}
	return true;
}

this.fclose=function fclose(f){
	try{f.obj.close()}
	catch(e){return e.number;}
	return true;
}

this.substr=function substr(){
	var i;var s;
	s = new String(arguments[0])
	if (arguments.length==2){
		e=s.length;
		i=(arguments[1]<0?s.length+arguments[1]:arguments[1])
		}
	else{
		i=arguments[1]
		e=(arguments[2]<0?s.length+arguments[2]:arguments[2])
		}

	return s.substr(i,e)
}
this.strrpos=function strrpos(s,ch){
	res = s.lastIndexOf(ch)
	if (res>0-1){return res}else{return false}
}
this.strpos=function strpos(s,ch,start){
	if (arguments.length<3){start=0}
	res = s.indexOf(ch,start);
	if (res>-1){return res}else{return false}
}
this.is_int=function is_int(v){
	try{
	res=!isNaN(parseInt(v))
	}
	catch(e){res=false}
	return res;
}
this.is_string=function is_string(s){
	try{
	res=isNaN(parseInt(s))}
	catch(e){res=false}
	return res;
}
this.is_array=function is_array(o){
	try{t=(o.constructor==Array);}
	catch(e){t=false}
	finally{return t}
}
this.date=function date(s){
	var i;
	r="";var d = new Date();
	for(i=0;i<s.length;i++){
	switch(s.charAt(i)){
		case "Y" : {
			r = r + d.getFullYear();
			break;}
		case "m":{
			r = r + d.getMonth()+1;
			break;}
		case "d":{
			r = r + d.getDay();
			break;}
		case "H":{
			r = r + d.getHours();
			break;}
		case "i":{
			r = r + d.getMinutes();
			break;}
		case "s":{
			r = r + d.getSeconds();
			break;}
		/* adicionado 'default' por matheus eduardo 
		matheuseduardo.com@gmail.com */
		default: {
			r = r + s.charAt(i);
			break;}
		}
	}
	return r;
}
this.str_replace=function str_replace(psearchText,preplaceText,poriginalString){

	searchText=new String(psearchText)
	replaceText=new String(preplaceText)
	originalString=new String(poriginalString)

	return originalString.split(searchText).join(replaceText);
}

this.str_replace1=function str_replace1(psearchText,preplaceText,poriginalString){
	originalString=new String(poriginalString)
	s = 'new RegExp("' + psearchText + '","gi")'
	Response.Write(s);
	Response.End;
	re = eval(s);
	return originalString.replace(re,preplaceText)
}
this.substr_count=function substr_count(s,ch){
	ar = s.split(ch);
	return ar.length;
}
this.isset=function isset(s){if(s){return true}else{return false}}
this.function_exists=function function_exists(s){
	if(s="gzcompress"){return false};
}
this.gzcompress=function gzcompress(){Response.Write("gzcom");Response.End;}
this.getimagesize=function getimagesize(){Response.Write("getimagesize");Response.End;}
this.imagesx=function imagesx(){Response.Write("imagex");Response.End;}
this.imagesy=function imagesy(){Response.Write("imagey");Response.End;}
this.tempnam=function tempnam(){Response.Write("temname");Response.End;}
this.imagejpeg=function imagejpeg(){Response.Write("imagjpg");Response.End;}
this.scalar_array=function scalar_test(ar){
	var i;
	s='ar';tmp='';
	for(i=0;i<arguments.length;i++){
			if(i==0){s="ar";}
			else
			{
			tmp = ( typeof(arguments[i])=="number" ? arguments[i] : "\"" + arguments[i] +"\"");
			s +=  "[" + tmp + "]" ;
			}
			o=eval(s);
			if (!this.is_array(o)){
				eval(s + "=new Array()");
			}
	}
	return;
}
this.newArray=function newArray(){
	var i;
	var ar=new Array();
	for(i=0;i<arguments.length;i++){
		ar[arguments[i]]=arguments[i+1];i=i+1
	}
	return ar;
}
this.file_exists=function file_exists(path){
	res = this.fso.FileExists(Server.MapPath(path))
	return res;
}

this.readtextfile=function readtextfile(path){
	var f,res
	if (this.file_exists(path)){
	f = this.fso.OpenTextFile(Server.MapPath(path), 1);
	res = f.ReadAll();
	f.close()
	}
	else{die("Path Not Found : "+Server.MapPath(path))}
	return res;
}

this.readbinfile=function readbinfile(path){
	var f,res;
	f = Server.CreateObject("ADODB.Stream");
	f.CharSet ="ISO-8859-1";
	f.Type=2
	f.Open()
	f.LoadFromFile(Server.MapPath(path))
	f.Position=0
	res = f.ReadText();
	f.Close()
	return res;
}

this.filesize=function filesize(path){
	if(!this.file_exists(path)){return false;}
	return this.fso.getFile(Server.MapPath(path)).size;
}

this.printf = function printf(format) {
   document.write(_spr(format, arguments));
}


this.sprintf=function sprintf(format) {
   return _spr(format, arguments);
}

this.SaveToFile=function SaveToFile(filename,buffer){
	var f;
	f=this.fso.OpenTextFile(Server.MapPath(filename),2,true)
	f.write(buffer);
	f.close();
}

this._spr=function _spr(format, args) {
   function isdigit(c) {
      return (c <= "9") && (c >= "0");
   }

   function rep(c, n) {
      var s = "";
      while (--n >= 0)
         s += c;
      return s;
   }

   var c;
   var i, ii, j = 1;
   var retstr = "";
   var space = "&nbsp;";


   for (i = 0; i < format.length; i++) {
      var buf = "";
      var segno = "";
      var expx = "";
      c = format.charAt(i);
      if (c == "\n") {
         c = "<br>";
      }
      if (c == "%") {
         i++;
         leftjust = false;
         if (format.charAt(i) == '-') {
            i++;
            leftjust = true;
         }
         padch = ((c = format.charAt(i)) == "0") ? "0" : space;
         if (c == "0")
            i++;
         field = 0;
         if (isdigit(c)) {
            field = parseInt(format.substring(i));
            i += String(field).length;
         }

         if ((c = format.charAt(i)) == '.') {
            digits = parseInt(format.substring(++i));
            i += String(digits).length;
            c = format.charAt(i);
         }
         else
            digits = 0;

         switch (c.toLowerCase()) {
            case "x":
               buf = args[j++].toString(16);
               break;
            case "e":
               expx = -1;
            case "f":
            case "d":
               if (args[j] < 0) {
                  args[j] = -args[j];
                  segno = "-";
                  field--;
               }
               if (expx != "") {
                  with (Math)
                     expx = floor(log(args[j]) / LN10);
                  args[j] /= Number("1E" + expx);
                  field -= String(expx).length + 2;
               }
               var x = args[j++];
               for (ii=0; ii < digits && x - Math.floor(x); ii++)
                  x *= 10;

               x = String(Math.round(x));

               x = rep("0", ii - x.length + 1) + x;

               buf += x.substring(0, x.length - ii);

               if (digits > 0)
                  buf += "." + x.substring(x.length - ii) + rep("0", digits - ii);
               if (expx != "") {
                  var expsign = (expx >= 0) ? "+" : "-";
                  expx = Math.abs(expx) + "";
                  buf += c + expsign + rep("0", 3 - expx.length) + expx;
               }
               break;
            case "o":
               buf = args[j++].toString(8);
               break;
            case "s":
               buf = args[j++];
               break;
            case "c":
               buf = args[j++].substring(0, 1);
               break;
            default:
               retstr += c;
         }
         field -= buf.length;
         if (!leftjust) {
            if (padch == space)
               retstr += rep(padch, field) + segno;
            else
               retstr += segno + rep("0", field);
         }
         retstr += buf;
         if (leftjust)
            retstr += rep(space, field);
      }
      else
         retstr += c;
   }
   return retstr;
}
}
</script>